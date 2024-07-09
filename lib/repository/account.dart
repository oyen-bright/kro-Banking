import 'dart:developer';

import 'package:kro_banking/model/account.dart';
import 'package:kro_banking/service/account.dart';

class AccountRepository {
  final AccountService accountService;

  AccountRepository(this.accountService);

  Future<(String?, List<Account>)> getAccounts(String userId) async {
    try {
      final response = await accountService.getAccounts(userId);

      return (null, response);
    } catch (e) {
      logger(e);
      return (e.toString(), <Account>[]);
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
