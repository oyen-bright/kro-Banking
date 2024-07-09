import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:kro_banking/model/account.dart';

@Singleton()
class AccountService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Account>> getAccounts(String userId) async {
    try {
      var snapshot = await _firestore
          .collection('User')
          .doc(userId)
          .collection('Accounts')
          .get();

      return snapshot.docs.map((doc) => Account.fromJson(doc.data())).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> transfer(
      String userId, Account from, Account to, String amount) async {
    try {
      double transferAmount = double.parse(amount);

      var fromDoc = await _firestore
          .collection('User')
          .doc(userId)
          .collection('Accounts')
          .doc(from.id)
          .get();

      var toDoc = await _firestore
          .collection('User')
          .doc(userId)
          .collection('Accounts')
          .doc(to.id)
          .get();

      if (!fromDoc.exists || !toDoc.exists) {
        throw Exception('Account not found');
      }

      Account fromAccount = Account.fromJson(fromDoc.data()!);
      Account toAccount = Account.fromJson(toDoc.data()!);

      if (fromAccount.balance < transferAmount) {
        throw Exception('Insufficient balance');
      }

      log(fromAccount.toJson().toString());
      log(toAccount.toJson().toString());
      fromAccount =
          fromAccount.copyWith(balance: (fromAccount.balance - transferAmount));
      toAccount =
          toAccount.copyWith(balance: (toAccount.balance - transferAmount));

      log(fromAccount.toJson().toString());
      log(toAccount.toJson().toString());

      await _firestore
          .collection('User')
          .doc(userId)
          .collection('Accounts')
          .doc(from.id)
          .update({'balance': fromAccount.balance});

      await _firestore
          .collection('User')
          .doc(userId)
          .collection('Accounts')
          .doc(to.id)
          .update({'balance': toAccount.balance});
    } catch (e) {
      rethrow;
    }
  }

  void listenToAccountChanges(
      String userId, Function(List<Account>) onChanged) {
    _firestore
        .collection('User')
        .doc(userId)
        .collection('Accounts')
        .snapshots()
        .listen((snapshot) {
      var accounts =
          snapshot.docs.map((doc) => Account.fromJson(doc.data())).toList();
      onChanged(accounts);
    });
  }
}
