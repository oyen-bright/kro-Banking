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
          .collection('transactions')
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

List<Map<String, dynamic>> transactionsData = [
  {
    "Date": "2024-05-01",
    "Description": "Opening Balance",
    "Amount": "₦5,000.00",
    "Type": "Opening",
    "Balance": "₦5,000.00",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-05-03",
    "Description": "Grocery Store",
    "Amount": "-₦80.50",
    "Type": "Debit",
    "Balance": "₦4,919.50",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-05-05",
    "Description": "Gas Station",
    "Amount": "-₦35.25",
    "Type": "Debit",
    "Balance": "₦4,884.25",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-05-08",
    "Description": "Restaurant",
    "Amount": "-₦75.00",
    "Type": "Debit",
    "Balance": "₦4,809.25",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-05-10",
    "Description": "Utility Bill",
    "Amount": "-₦120.00",
    "Type": "Debit",
    "Balance": "₦4,689.25",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-05-12",
    "Description": "ATM Withdrawal",
    "Amount": "-₦200.00",
    "Type": "Debit",
    "Balance": "₦4,489.25",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-05-15",
    "Description": "Deposit - Salary",
    "Amount": "₦2,500.00",
    "Type": "Deposit",
    "Balance": "₦6,989.25",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-05-18",
    "Description": "Online Shopping",
    "Amount": "-₦90.75",
    "Type": "Debit",
    "Balance": "₦6,898.50",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-05-20",
    "Description": "ATM Withdrawal",
    "Amount": "-₦100.00",
    "Type": "Debit",
    "Balance": "₦6,798.50",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-05-22",
    "Description": "Deposit - Refund",
    "Amount": "₦30.00",
    "Type": "Deposit",
    "Balance": "₦6,828.50",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-05-25",
    "Description": "Coffee Shop",
    "Amount": "-₦5.75",
    "Type": "Debit",
    "Balance": "₦6,822.75",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-05-28",
    "Description": "Mobile Phone Bill",
    "Amount": "-₦45.00",
    "Type": "Debit",
    "Balance": "₦6,777.75",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-05-30",
    "Description": "Rent",
    "Amount": "-₦800.00",
    "Type": "Debit",
    "Balance": "₦5,977.75",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-06-01",
    "Description": "Deposit - Bonus",
    "Amount": "₦300.00",
    "Type": "Deposit",
    "Balance": "₦6,277.75",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-06-03",
    "Description": "Grocery Store",
    "Amount": "-₦70.20",
    "Type": "Debit",
    "Balance": "₦6,207.55",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-06-05",
    "Description": "Gas Station",
    "Amount": "-₦38.40",
    "Type": "Debit",
    "Balance": "₦6,169.15",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-06-08",
    "Description": "Restaurant",
    "Amount": "-₦62.50",
    "Type": "Debit",
    "Balance": "₦6,106.65",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-06-10",
    "Description": "Utility Bill",
    "Amount": "-₦110.00",
    "Type": "Debit",
    "Balance": "₦5,996.65",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-06-12",
    "Description": "ATM Withdrawal",
    "Amount": "-₦150.00",
    "Type": "Debit",
    "Balance": "₦5,846.65",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-06-15",
    "Description": "Deposit - Gift",
    "Amount": "₦50.00",
    "Type": "Deposit",
    "Balance": "₦5,896.65",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-06-18",
    "Description": "ATM Withdrawal",
    "Amount": "-₦200.00",
    "Type": "Debit",
    "Balance": "₦5,696.65",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-06-20",
    "Description": "Deposit - Refund",
    "Amount": "₦20.00",
    "Type": "Deposit",
    "Balance": "₦5,716.65",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-06-23",
    "Description": "Coffee Shop",
    "Amount": "-₦8.25",
    "Type": "Debit",
    "Balance": "₦5,708.40",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-06-25",
    "Description": "Mobile Phone Bill",
    "Amount": "-₦55.00",
    "Type": "Debit",
    "Balance": "₦5,653.40",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-06-28",
    "Description": "Rent",
    "Amount": "-₦750.00",
    "Type": "Debit",
    "Balance": "₦4,903.40",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-07-01",
    "Description": "Deposit - Salary",
    "Amount": "₦2,800.00",
    "Type": "Deposit",
    "Balance": "₦7,703.40",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-07-03",
    "Description": "Grocery Store",
    "Amount": "-₦90.00",
    "Type": "Debit",
    "Balance": "₦7,613.40",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-07-05",
    "Description": "Gas Station",
    "Amount": "-₦40.50",
    "Type": "Debit",
    "Balance": "₦7,572.90",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-07-08",
    "Description": "Restaurant",
    "Amount": "-₦85.00",
    "Type": "Debit",
    "Balance": "₦7,487.90",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-07-10",
    "Description": "Utility Bill",
    "Amount": "-₦130.00",
    "Type": "Debit",
    "Balance": "₦7,357.90",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-07-12",
    "Description": "ATM Withdrawal",
    "Amount": "-₦180.00",
    "Type": "Debit",
    "Balance": "₦7,177.90",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-07-15",
    "Description": "Deposit - Bonus",
    "Amount": "₦400.00",
    "Type": "Deposit",
    "Balance": "₦7,577.90",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-07-18",
    "Description": "Online Shopping",
    "Amount": "-₦120.00",
    "Type": "Debit",
    "Balance": "₦7,457.90",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-07-20",
    "Description": "ATM Withdrawal",
    "Amount": "-₦150.00",
    "Type": "Debit",
    "Balance": "₦7,307.90",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-07-23",
    "Description": "Coffee Shop",
    "Amount": "-₦7.00",
    "Type": "Debit",
    "Balance": "₦7,300.90",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-07-25",
    "Description": "Mobile Phone Bill",
    "Amount": "-₦50.00",
    "Type": "Debit",
    "Balance": "₦7,250.90",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-07-28",
    "Description": "Rent",
    "Amount": "-₦800.00",
    "Type": "Debit",
    "Balance": "₦6,450.90",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-07-30",
    "Description": "Deposit - Gift",
    "Amount": "₦60.00",
    "Type": "Deposit",
    "Balance": "₦6,510.90",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-08-02",
    "Description": "Grocery Store",
    "Amount": "-₦85.50",
    "Type": "Debit",
    "Balance": "₦6,425.40",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-08-05",
    "Description": "Gas Station",
    "Amount": "-₦45.75",
    "Type": "Debit",
    "Balance": "₦6,379.65",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-08-08",
    "Description": "Restaurant",
    "Amount": "-₦70.00",
    "Type": "Debit",
    "Balance": "₦6,309.65",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-08-10",
    "Description": "Utility Bill",
    "Amount": "-₦140.00",
    "Type": "Debit",
    "Balance": "₦6,169.65",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-08-12",
    "Description": "ATM Withdrawal",
    "Amount": "-₦220.00",
    "Type": "Debit",
    "Balance": "₦5,949.65",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-08-15",
    "Description": "Deposit - Salary",
    "Amount": "₦2,600.00",
    "Type": "Deposit",
    "Balance": "₦8,549.65",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-08-18",
    "Description": "Online Shopping",
    "Amount": "-₦100.50",
    "Type": "Debit",
    "Balance": "₦8,449.15",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-08-20",
    "Description": "ATM Withdrawal",
    "Amount": "-₦120.00",
    "Type": "Debit",
    "Balance": "₦8,329.15",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-08-23",
    "Description": "Coffee Shop",
    "Amount": "-₦6.50",
    "Type": "Debit",
    "Balance": "₦8,322.65",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-08-25",
    "Description": "Mobile Phone Bill",
    "Amount": "-₦60.00",
    "Type": "Debit",
    "Balance": "₦8,262.65",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-08-28",
    "Description": "Rent",
    "Amount": "-₦850.00",
    "Type": "Debit",
    "Balance": "₦7,412.65",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-08-30",
    "Description": "Deposit - Bonus",
    "Amount": "₦350.00",
    "Type": "Deposit",
    "Balance": "₦7,762.65",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-09-02",
    "Description": "Grocery Store",
    "Amount": "-₦95.20",
    "Type": "Debit",
    "Balance": "₦7,667.45",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-09-05",
    "Description": "Gas Station",
    "Amount": "-₦50.75",
    "Type": "Debit",
    "Balance": "₦7,616.70",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-09-08",
    "Description": "Restaurant",
    "Amount": "-₦80.00",
    "Type": "Debit",
    "Balance": "₦7,536.70",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-09-10",
    "Description": "Utility Bill",
    "Amount": "-₦125.00",
    "Type": "Debit",
    "Balance": "₦7,411.70",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-09-12",
    "Description": "ATM Withdrawal",
    "Amount": "-₦170.00",
    "Type": "Debit",
    "Balance": "₦7,241.70",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-09-15",
    "Description": "Deposit - Refund",
    "Amount": "₦40.00",
    "Type": "Deposit",
    "Balance": "₦7,281.70",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-09-18",
    "Description": "Online Shopping",
    "Amount": "-₦110.00",
    "Type": "Debit",
    "Balance": "₦7,171.70",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-09-20",
    "Description": "ATM Withdrawal",
    "Amount": "-₦130.00",
    "Type": "Debit",
    "Balance": "₦7,041.70",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-09-23",
    "Description": "Coffee Shop",
    "Amount": "-₦5.00",
    "Type": "Debit",
    "Balance": "₦7,036.70",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-09-25",
    "Description": "Mobile Phone Bill",
    "Amount": "-₦45.00",
    "Type": "Debit",
    "Balance": "₦6,991.70",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-09-28",
    "Description": "Rent",
    "Amount": "-₦800.00",
    "Type": "Debit",
    "Balance": "₦6,191.70",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-09-30",
    "Description": "Deposit - Gift",
    "Amount": "₦70.00",
    "Type": "Deposit",
    "Balance": "₦6,261.70",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-10-02",
    "Description": "Grocery Store",
    "Amount": "-₦75.80",
    "Type": "Debit",
    "Balance": "₦6,185.90",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-10-05",
    "Description": "Gas Station",
    "Amount": "-₦42.25",
    "Type": "Debit",
    "Balance": "₦6,143.65",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-10-08",
    "Description": "Restaurant",
    "Amount": "-₦65.00",
    "Type": "Debit",
    "Balance": "₦6,078.65",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-10-10",
    "Description": "Utility Bill",
    "Amount": "-₦135.00",
    "Type": "Debit",
    "Balance": "₦5,943.65",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-10-12",
    "Description": "ATM Withdrawal",
    "Amount": "-₦190.00",
    "Type": "Debit",
    "Balance": "₦5,753.65",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-10-15",
    "Description": "Deposit - Salary",
    "Amount": "₦2,900.00",
    "Type": "Deposit",
    "Balance": "₦8,653.65",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-10-18",
    "Description": "Online Shopping",
    "Amount": "-₦130.00",
    "Type": "Debit",
    "Balance": "₦8,523.65",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-10-20",
    "Description": "ATM Withdrawal",
    "Amount": "-₦110.00",
    "Type": "Debit",
    "Balance": "₦8,413.65",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-10-23",
    "Description": "Coffee Shop",
    "Amount": "-₦4.50",
    "Type": "Debit",
    "Balance": "₦8,409.15",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-10-25",
    "Description": "Mobile Phone Bill",
    "Amount": "-₦40.00",
    "Type": "Debit",
    "Balance": "₦8,369.15",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-10-28",
    "Description": "Rent",
    "Amount": "-₦850.00",
    "Type": "Debit",
    "Balance": "₦7,519.15",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-10-30",
    "Description": "Deposit - Bonus",
    "Amount": "₦380.00",
    "Type": "Deposit",
    "Balance": "₦7,899.15",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-11-02",
    "Description": "Grocery Store",
    "Amount": "-₦100.50",
    "Type": "Debit",
    "Balance": "₦7,798.65",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-11-05",
    "Description": "Gas Station",
    "Amount": "-₦55.25",
    "Type": "Debit",
    "Balance": "₦7,743.40",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-11-08",
    "Description": "Restaurant",
    "Amount": "-₦90.00",
    "Type": "Debit",
    "Balance": "₦7,653.40",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-11-10",
    "Description": "Utility Bill",
    "Amount": "-₦145.00",
    "Type": "Debit",
    "Balance": "₦7,508.40",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-11-12",
    "Description": "ATM Withdrawal",
    "Amount": "-₦200.00",
    "Type": "Debit",
    "Balance": "₦7,308.40",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-11-15",
    "Description": "Deposit - Refund",
    "Amount": "₦50.00",
    "Type": "Deposit",
    "Balance": "₦7,358.40",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-11-18",
    "Description": "Online Shopping",
    "Amount": "-₦115.00",
    "Type": "Debit",
    "Balance": "₦7,243.40",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-11-20",
    "Description": "ATM Withdrawal",
    "Amount": "-₦125.00",
    "Type": "Debit",
    "Balance": "₦7,118.40",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-11-23",
    "Description": "Coffee Shop",
    "Amount": "-₦5.75",
    "Type": "Debit",
    "Balance": "₦7,112.65",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-11-25",
    "Description": "Mobile Phone Bill",
    "Amount": "-₦50.00",
    "Type": "Debit",
    "Balance": "₦7,062.65",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-11-28",
    "Description": "Rent",
    "Amount": "-₦800.00",
    "Type": "Debit",
    "Balance": "₦6,262.65",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-11-30",
    "Description": "Deposit - Gift",
    "Amount": "₦80.00",
    "Type": "Deposit",
    "Balance": "₦6,342.65",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-12-02",
    "Description": "Grocery Store",
    "Amount": "-₦85.00",
    "Type": "Debit",
    "Balance": "₦6,257.65",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-12-05",
    "Description": "Gas Station",
    "Amount": "-₦47.50",
    "Type": "Debit",
    "Balance": "₦6,210.15",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-12-08",
    "Description": "Restaurant",
    "Amount": "-₦75.00",
    "Type": "Debit",
    "Balance": "₦6,135.15",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-12-10",
    "Description": "Utility Bill",
    "Amount": "-₦130.00",
    "Type": "Debit",
    "Balance": "₦6,005.15",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-12-12",
    "Description": "ATM Withdrawal",
    "Amount": "-₦180.00",
    "Type": "Debit",
    "Balance": "₦5,825.15",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-12-15",
    "Description": "Deposit - Salary",
    "Amount": "₦2,800.00",
    "Type": "Deposit",
    "Balance": "₦8,625.15",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-12-18",
    "Description": "Online Shopping",
    "Amount": "-₦120.00",
    "Type": "Debit",
    "Balance": "₦8,505.15",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-12-20",
    "Description": "ATM Withdrawal",
    "Amount": "-₦100.00",
    "Type": "Debit",
    "Balance": "₦8,405.15",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-12-23",
    "Description": "Coffee Shop",
    "Amount": "-₦4.00",
    "Type": "Debit",
    "Balance": "₦8,401.15",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
  {
    "Date": "2024-12-25",
    "Description": "Mobile Phone Bill",
    "Amount": "-₦35.00",
    "Type": "Debit",
    "Balance": "₦8,366.15",
    "accountId": "n7Je9qkzTVWMVoA8sH21"
  },
  {
    "Date": "2024-12-28",
    "Description": "Rent",
    "Amount": "-₦850.00",
    "Type": "Debit",
    "Balance": "₦7,516.15",
    "accountId": "GGovtv3PdD0aLUIFW1gl"
  },
  {
    "Date": "2024-12-30",
    "Description": "Deposit - Bonus",
    "Amount": "₦400.00",
    "Type": "Deposit",
    "Balance": "₦7,916.15",
    "accountId": "KKn21Nnv8Ux9zjenAxug"
  },
];
