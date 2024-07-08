import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/views/wrapper/view_wrapper.dart';
import 'package:kro_banking/widgets/app_shimer.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewWrapper(
      headerTitle: "Desktop",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: context.pHeight(KContents.kHorizontalPad),
            spacing: context.pWidth(KContents.kHorizontalPad),
            children: const [
              AccountCard(),
              AccountCard(),
              AccountCard(),
            ],
          )
        ],
      ),
    );
  }
}

class AccountCard extends StatefulWidget {
  const AccountCard({super.key});

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  bool isVisible = false;

  static Widget get shimmmer => const AppShimmer(child: AccountCard());

  @override
  Widget build(BuildContext context) {
    const amount = "1000020";

    return Container(
      width: 425,
      decoration: BoxDecoration(
          color: context.colorScheme.secondary,
          borderRadius: BorderRadius.circular(KContents.kRadius.medium)),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                "Available Balance",
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
            "\$ ${isVisible ? amount : "*" * amount.length}",
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
                      "%20",
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
