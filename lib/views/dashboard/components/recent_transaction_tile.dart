import 'package:flutter/material.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/model/transaction.dart';
import 'package:kro_banking/utils/currency_formater.dart';
import 'package:kro_banking/utils/date_formater.dart';

class CardTile extends StatelessWidget {
  const CardTile({super.key, required this.transaction});
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    bool isDebit = transaction.isDebit;
    return Column(
      children: [
        ListTile(
          title: Text(
            transaction.description,
            maxLines: 1,
          ),
          subtitle: Text(
            formatDate(transaction.dateTime),
            maxLines: 1,
          ),
          trailing: Text(
            appCurrency(transaction.amount),
            style: context.textTheme.titleMedium,
          ),
          leading: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: !isDebit
                  ? Colors.green.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
            ),
            child: Icon(isDebit ? Icons.arrow_outward : Icons.arrow_back),
          ),
        ),
        const Divider()
      ],
    );
  }
}
