import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/model/account.dart';
import 'package:kro_banking/theme/app_colors.dart';
import 'package:kro_banking/utils/currency_formater.dart';

class AccountCard extends StatefulWidget {
  final Account account;
  final bool isSmall;

  const AccountCard._internal({
    super.key,
    required this.account,
    this.isSmall = false,
  });

  factory AccountCard.small({required Account account}) {
    return AccountCard._internal(account: account, isSmall: true);
  }

  factory AccountCard.regular({required Account account}) {
    return AccountCard._internal(account: account);
  }

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  bool isVisible = false;

  final increase = Random().nextInt(50);
  late final String amount;

  @override
  void initState() {
    amount = appCurrency(widget.account.balance, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double cardHeight = widget.isSmall ? 150 : 250;
    const double fontSize = 32;
    const EdgeInsetsGeometry padding = KContents.kCardPad;

    return Container(
      width: 425,
      decoration: BoxDecoration(
          color: AppColors.kBgWhite,
          border:
              Border.all(color: context.colorScheme.primary.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(KContents.kRadius.medium)),
      padding: padding,
      height: cardHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                widget.account.type,
                style: context.textTheme.titleMedium?.copyWith(
                    color: AppColors.color1E1E1E, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () => setState(() {
                        isVisible = !isVisible;
                      }),
                  icon: Icon(
                    isVisible
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                    color: context.colorScheme.primary,
                  ))
            ],
          ),
          const Spacer(
            flex: 2,
          ),
          Text(
            // appCurrency(widget.account.balance, false),
            // "${KContents.kAppCurrency} ${isVisible ? amount : "*" * amount.length}",
            "${KContents.kAppCurrency} ${isVisible ? appCurrency(widget.account.balance, false) : "*" * appCurrency(widget.account.balance, false).length}",
            style: context.textTheme.headlineLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: fontSize),
          ),
          const Spacer(),
          if (!widget.isSmall) ...[
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "From last month",
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.arrowTrendUp,
                        size: 15,
                        color: context.colorScheme.onPrimary,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "%$increase",
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onPrimary,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ],
      ),
    );
  }
}
