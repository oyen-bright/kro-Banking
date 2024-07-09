import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/utils/currency_formater.dart';

class BillCard extends StatelessWidget {
  final String amount;
  final String title;
  const BillCard({super.key, required this.amount, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(KContents.kRadius.small),
          border:
              Border.all(color: context.colorScheme.primary.withOpacity(0.2))),
      width: 255,
      height: 80,
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 1,
              style: context.textTheme.bodyLarge,
            ),
            AutoSizeText(
              appCurrency(double.parse(amount)),
              maxLines: 1,
              style: context.textTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}
