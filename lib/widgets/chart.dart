import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_personal_money_app/widgets/chart_bar.dart';
import '../models/transactions.dart';

class Chart extends StatelessWidget {
  final List<Transactions> userTransactions;

  // Construtor atualizado para null safety
  const Chart(this.userTransactions, {super.key});

  List<Map<String, Object>> get generateTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (var i = 0; i < userTransactions.length; i++) {
        if (userTransactions[i].date.day == weekDay.day &&
            userTransactions[i].date.month == weekDay.month &&
            userTransactions[i].date.year == weekDay.year) {
          totalSum += userTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E()
            .format(weekDay)
            .substring(0, 1), // Pega apenas a primeira letra do dia
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    // 1. Corrigir o cálculo do total com a conversão correta
    return generateTransactions.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: generateTransactions.map((data) {
            // 2. Fazer a conversão explícita dos tipos aqui
            final day = data['day'] as String;
            final amount = data['amount'] as double;
            final spendingPctOfTotal =
                totalSpending == 0.0 ? 0.0 : amount / totalSpending;

            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                day,
                amount,
                spendingPctOfTotal,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
