import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financiei/models/transactions.dart';
import 'package:financiei/widgets/chart.dart';
import 'package:financiei/widgets/new_transaction.dart';
import 'package:financiei/widgets/transaction_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final CollectionReference _transactionsCollection =
      FirebaseFirestore.instance.collection('transactions');

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) {
        return NewTransaction(addTransaction: _addTransaction);
      },
    );
  }

  void _addTransaction(String title, double amount, DateTime chosenDate) {
    _transactionsCollection.add({
      'title': title,
      'amount': amount,
      'date': Timestamp.fromDate(chosenDate),
    });
  }

  void _deleteTransaction(String id) {
    _transactionsCollection.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: const Text('Financiei'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    // Calcula a altura disponível na tela
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: StreamBuilder<QuerySnapshot>(
        stream: _transactionsCollection
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'Nenhuma transação adicionada!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover),
                  ),
                ],
              );
            });
          }

          final loadedTransactions = snapshot.data!.docs
              .map((doc) => Transactions.fromFirestore(doc))
              .toList();

          final recentTransactions = loadedTransactions.where((tx) {
            return tx.date
                .isAfter(DateTime.now().subtract(const Duration(days: 7)));
          }).toList();

          return Column(
            children: <Widget>[
              // **A CORREÇÃO ESTÁ AQUI**
              // O Gráfico agora está dentro de um Container com 30% da altura da tela
              Container(
                height: availableHeight * 0.3,
                child: Chart(recentTransactions),
              ),
              // O restante do espaço (70%) é usado pela lista
              SizedBox(
                height: availableHeight * 0.7,
                child: TransactionList(
                  userTransactions: loadedTransactions,
                  deleteTransaction: _deleteTransaction,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
