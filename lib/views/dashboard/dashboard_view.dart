import 'package:flutter/material.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/router/route.dart';
import 'package:kro_banking/router/router.dart';
import 'package:kro_banking/theme/app_colors.dart';
import 'package:kro_banking/views/dashboard/components/account_card.dart';
import 'package:kro_banking/views/dashboard/components/bill_card.dart';
import 'package:kro_banking/views/wrapper/view_wrapper.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewWrapper(
      headerTitle: "Desktop",
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
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
          ),
          const SizedBox(
            height: KContents.kHorizontalPad,
          ),
          Wrap(
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: context.pHeight(KContents.kHorizontalPad),
            spacing: context.pWidth(KContents.kHorizontalPad),
            children: [
              Container(
                // height: 100,
                padding: KContents.kCardPad,
                width: 880,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: context.colorScheme.primary.withOpacity(0.2)),
                    color: AppColors.kBgWhite,
                    borderRadius:
                        BorderRadius.circular(KContents.kRadius.medium)),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Recurring Bills",
                          style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  context.textTheme.titleMedium!.fontSize! + 2),
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              AppRouter.router.go(AppRoutes.billPayments);
                            },
                            child: const Text("View All"))
                      ],
                    ),
                    const SizedBox(
                      height: KContents.kCardPadVertical,
                    ),
                    Wrap(
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: context.pHeight(KContents.kHorizontalPad),
                      spacing: context.pWidth(KContents.kHorizontalPad),
                      children: const [
                        BillCard(),
                        BillCard(),
                        BillCard(),
                      ],
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
