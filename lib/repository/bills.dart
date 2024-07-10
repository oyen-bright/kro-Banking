import 'dart:developer';

import 'package:kro_banking/service/bills.dart';

class BillRepository {
  final BillService billService;

  BillRepository(this.billService);

  Future<(String?, List<Map<String, dynamic>>?)> getBills(String userId) async {
    try {
      final response = await billService.getAllBills(userId);
      return (null, response);
    } catch (e) {
      logger(e);
      return (e.toString(), null);
    }
  }

  void listenToBillChanges(
      String userId, Function(List<Map<String, dynamic>>) onChanged) {
    billService.listenToBills(userId, onChanged);
  }

  Future<void> addBill(String userId, Map<String, dynamic> billData) async {
    try {
      await billService.addBill(userId, billData);
    } catch (e) {
      logger(e);
      rethrow;
    }
  }

  static void logger(e) {
    log(e.toString(), name: "BillRepo Error");
  }
}
