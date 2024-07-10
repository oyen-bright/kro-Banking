import 'dart:developer';

import 'package:kro_banking/model/transaction.dart';
import 'package:kro_banking/service/transaction.dart';

class TransactionRepository {
  final TransactionService transactionService;

  TransactionRepository(this.transactionService);

  Future<(String?, List<Transaction>?)> getTransactions(String userId) async {
    try {
      final response = await transactionService.getAllTransactions(userId);
      return (null, response);
    } catch (e) {
      logger(e);
      return (e.toString(), null);
    }
  }

  void listenToTransactionChanges(
      String userId, Function(List<Transaction>) onChanged) {
    transactionService.listenToTransactions(userId, onChanged);
  }

  Future<void> addTransaction(String userId, Transaction transaction) async {
    try {
      await transactionService.addTransaction(userId, transaction);
    } catch (e) {
      logger(e);
      rethrow;
    }
  }

  static void logger(e) {
    log(e.toString(), name: "TransactionRepo Error");
  }
}
