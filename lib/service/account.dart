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
