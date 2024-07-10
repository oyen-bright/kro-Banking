import 'package:flutter/material.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/model/bills.dart';
import 'package:kro_banking/utils/currency_formater.dart';
import 'package:kro_banking/utils/date_formater.dart';

class BillsTile extends StatelessWidget {
  final Bill bill;
  const BillsTile({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      // leading: Container(
      //   padding: const EdgeInsets.all(15),
      //   decoration: BoxDecoration(
      //     color: bill.isPending
      //         ? Colors.green.withOpacity(0.2)
      //         : Colors.pr.withOpacity(0.2),
      //   ),
      //   child: Icon(isDebit ? Icons.arrow_outward : Icons.arrow_back),
      // ),
      title: Text(
        bill.name,
        style: context.textTheme.titleMedium,
      ),
      subtitle: Text(
        "Due Date: ${formatDate(bill.dueDate)}",
        style: context.textTheme.titleMedium,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '  ${appCurrency(bill.amount)}',
            style: context.textTheme.titleMedium,
          ),
          Container(
            color: bill.isPending ? Colors.amber[100] : Colors.green[100],
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            child: Text(bill.status),
          )
        ],
      ),
    );
  }
}
