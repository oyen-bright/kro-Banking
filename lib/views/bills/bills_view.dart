import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kro_banking/bloc/dashboard/dashboard_bloc.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/model/account.dart';
import 'package:kro_banking/model/bills.dart';
import 'package:kro_banking/model/transaction.dart';
import 'package:kro_banking/theme/app_colors.dart';
import 'package:kro_banking/views/dashboard/components/card_header.dart';
import 'package:kro_banking/views/dashboard/components/recent_transaction_tile.dart';
import 'package:kro_banking/views/wrapper/view_wrapper.dart';
import 'package:kro_banking/widgets/app_shimer.dart';
import 'package:kro_banking/widgets/overlay/loading_overlay.dart';

import 'components/transaction_tabs.dart';

class BillsView extends StatelessWidget {
  const BillsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewWrapper(
      headerTitle: "Bills",
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          final (List<Account>?, List<Bill>?, List<Transaction>?) data =
              state.data;

          final isLoading = state.maybeWhen(
            orElse: () => false,
            loading: (_, __, ___) => true,
          );

          return Column(
            children: [
              SizedBox(
                width: 850 + 450,
                child: Row(
                  children: [
                    const Spacer(),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          foregroundColor: context.colorScheme.onPrimary,
                          backgroundColor: context.colorScheme.primary),
                      onPressed: () {},
                      label: const Text("New Bill"),
                      icon: const Icon(Icons.add),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: context.pHeight(KContents.kHorizontalPad),
                spacing: context.pWidth(KContents.kHorizontalPad),
                children: [
                  Container(
                      padding: KContents.kCardPad,
                      width: 850,
                      height: 1200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.colorScheme.primary.withOpacity(0.2),
                        ),
                        color: AppColors.kBgWhite,
                        borderRadius: BorderRadius.circular(
                          KContents.kRadius.medium,
                        ),
                      ),
                      child: LoadingOverlay(
                        child: state.data.$3 != null
                            ? TransactionTabs(
                                transactions: state.data.$3 ?? [],
                              )
                            : const SizedBox.shrink(),
                      )),
                  Container(
                      // height: 100,
                      padding: KContents.kCardPad,
                      width: 425,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  context.colorScheme.primary.withOpacity(0.2)),
                          color: AppColors.kBgWhite,
                          borderRadius:
                              BorderRadius.circular(KContents.kRadius.medium)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CardHeader(
                            title: "Recent Transactions",
                            buttonTitle: "View All",
                            onPressed: () {
                              // AppRouter.router.go(AppRoutes.transactionHistory);
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (isLoading || data.$3 == null)
                            ...List.generate(
                              15,
                              (_) => AppShimmer(
                                  child:
                                      CardTile(transaction: Transaction.dummy)),
                            )
                          else
                            ...AnimateList(
                                interval: 200.ms,
                                effects: [FadeEffect(duration: 100.ms)],
                                children: data.$3!
                                    .take(10)
                                    .map((transaction) => CardTile(
                                          transaction: transaction,
                                        ))
                                    .toList())
                        ],
                      ))
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
