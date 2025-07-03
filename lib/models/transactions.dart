import 'package:cloud_firestore/cloud_firestore.dart';

class Transactions {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  // Construtor atualizado para null safety
  Transactions({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  // Método para converter um Documento do Firestore em um objeto Transactions
  factory Transactions.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Transactions(
      id: doc.id,
      title: data['title'] ?? '',
      amount: (data['amount'] ?? 0.0).toDouble(),
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  // Método para converter um objeto Transactions em um Map para o Firestore
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'date': Timestamp.fromDate(date),
    };
  }
}
