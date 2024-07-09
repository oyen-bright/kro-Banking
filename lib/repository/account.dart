import 'dart:developer';

import 'package:kro_banking/model/account.dart';
import 'package:kro_banking/model/transaction.dart';
import 'package:kro_banking/service/account.dart';
import 'package:kro_banking/service/transaction.dart';

class AccountRepository {
  final AccountService accountService;
  final TransactionService transactionService;

  AccountRepository(this.accountService, this.transactionService);

  Future<(String?, List<Account>?)> getAccounts(String userId) async {
    try {
      final response = await accountService.getAccounts(userId);

      return (null, response);
    } catch (e) {
      logger(e);
      return (e.toString(), null);
    }
  }

  Future<(String?, String?)> makeTransfer(
      String userId, Account from, Account to, String amount) async {
    try {
      await accountService.transfer(userId, from, to, amount);

      final DateTime now = DateTime.now();
      const String transactionId = "";
      final String description = "Transfer from ${from.type} to ${to.type}";
      const String type = "Transfer";
      final double transferAmount = double.parse(amount);

      final Transaction fromTransaction = Transaction(
        id: transactionId,
        dateTime: now,
        description: description,
        amount: -transferAmount,
        type: type,
        balance: from.balance - transferAmount,
        accountId: from.id,
      );

      final Transaction toTransaction = Transaction(
        id: transactionId,
        dateTime: now,
        description: description,
        amount: transferAmount,
        type: type,
        balance: to.balance + transferAmount,
        accountId: to.id,
      );

      await Future.wait([
        transactionService.addTransaction(userId, fromTransaction),
        transactionService.addTransaction(userId, toTransaction)
      ]);

      return (null, "Transfer Successfully");
    } catch (e) {
      logger(e);
      return (e.toString(), null);
    }
  }

  void listenToAccountChanges(
      String userId, Function(List<Account>) onChanged) {
    accountService.listenToAccountChanges(userId, onChanged);
  }

  static void logger(e) {
    log(e.toString(), name: "ServiceRepo Error");
  }
}
