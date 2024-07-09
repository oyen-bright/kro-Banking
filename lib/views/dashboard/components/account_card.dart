import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/model/account.dart';
import 'package:kro_banking/utils/currency_formater.dart';
import 'package:kro_banking/widgets/app_shimer.dart';

class AccountCard extends StatefulWidget {
  final Account account;
  const AccountCard({super.key, required this.account});

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  bool isVisible = false;

  Widget get shimmer => AppShimmer(child: AccountCard(account: widget.account));

  late final String amount;

  @override
  void initState() {
    amount = appCurrency(widget.account.balance, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 425,
      decoration: BoxDecoration(
          color: context.colorScheme.secondary,
          borderRadius: BorderRadius.circular(KContents.kRadius.medium)),
      padding: KContents.kCardPad,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                widget.account.type,
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onPrimary,
                ),
              ),
              const Spacer(),
              IconButton(
                  // tooltip: "Toggle Visibility",
                  onPressed: () => setState(() {
                        isVisible = !isVisible;
                      }),
                  icon: Icon(
                    isVisible
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                    color: context.colorScheme.onPrimary,
                  ))
            ],
          ),
          const Spacer(
            flex: 2,
          ),
          Text(
            "${KContents.kAppCurrency} ${isVisible ? amount : "*" * amount.length}",
            style: context.textTheme.headlineLarge
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
          ),
          const Spacer(),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "From last month",
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onPrimary,
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
                      //TODO:remove static calculation
                      "%${Random().nextInt(50)}",
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
      ),
    );
  }
}
