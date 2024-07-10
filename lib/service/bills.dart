import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class BillService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBill(String userId, Map<String, dynamic> billData) async {
    try {
      var billRef =
          _firestore.collection('User').doc(userId).collection('Bills').doc();

      String billId = billRef.id;

      var billDataWithId = {...billData, 'id': billId};

      await billRef.set(billDataWithId);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAllBills(String userId) async {
    try {
      var snapshot = await _firestore
          .collection('User')
          .doc(userId)
          .collection('Bills')
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      rethrow;
    }
  }

  void listenToBills(
      String userId, Function(List<Map<String, dynamic>>) onChanged) {
    _firestore
        .collection('User')
        .doc(userId)
        .collection('Bills')
        .snapshots()
        .listen((snapshot) {
      var bills = snapshot.docs.map((doc) => doc.data()).toList();
      onChanged(bills);
    });
  }
}
