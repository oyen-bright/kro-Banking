import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:kro_banking/model/transaction.dart' as kro;

@Singleton()
class TransactionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addTransaction(
      String userId, kro.Transaction transaction) async {
    try {
      var transactionRef = _firestore
          .collection('User')
          .doc(userId)
          .collection('Transactions')
          .doc();

      String transactionId = transactionRef.id;

      var transactionData = transaction.toJson();
      transactionData['id'] = transactionId;

      await transactionRef.set(transactionData);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<kro.Transaction>> getAllTransactions(String userId) async {
    try {
      var snapshot = await _firestore
          .collection('User')
          .doc(userId)
          .collection('Transactions')
          .get();

      return snapshot.docs
          .map((doc) => kro.Transaction.fromJson(doc.data()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  void listenToTransactions(
      String userId, Function(List<kro.Transaction>) onChanged) {
    _firestore
        .collection('User')
        .doc(userId)
        .collection('Transactions')
        .snapshots()
        .listen((snapshot) {
      var accounts = snapshot.docs
          .map((doc) => kro.Transaction.fromJson(doc.data()))
          .toList();
      onChanged(accounts);
    });
  }
}

double parseAmount(String amountString) {
  String cleaned = amountString.replaceAll('₦', '').replaceAll(',', '');
  return double.parse(cleaned);
}

List<Map<String, dynamic>> sortTransactionsByDate(
    List<Map<String, dynamic>> transactions) {
  List<Map<String, dynamic>> sortedTransactions = List.from(transactions);
  sortedTransactions.sort(
      (a, b) => DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));
  return sortedTransactions;
}
