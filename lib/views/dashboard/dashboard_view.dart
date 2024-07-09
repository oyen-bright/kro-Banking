import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kro_banking/bloc/bloc/dashboard_bloc.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/model/account.dart';
import 'package:kro_banking/model/bills.dart';
import 'package:kro_banking/model/transaction.dart';
import 'package:kro_banking/router/route.dart';
import 'package:kro_banking/router/router.dart';
import 'package:kro_banking/theme/app_colors.dart';
import 'package:kro_banking/views/dashboard/components/account_card.dart';
import 'package:kro_banking/views/dashboard/components/bill_card.dart';
import 'package:kro_banking/views/dashboard/components/card_header.dart';
import 'package:kro_banking/views/dashboard/components/investment_cart.dart';
import 'package:kro_banking/views/dashboard/components/recent_transaction_tile.dart';
import 'package:kro_banking/views/wrapper/view_wrapper.dart';
import 'package:kro_banking/widgets/app_shimer.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewWrapper(
      headerTitle: "Dashboard",
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          final (List<Account>?, List<Bill>?, List<Transaction>?) data =
              state.data;

          final isLoading = state.maybeWhen(
            orElse: () => false,
            loading: (_, __, ___) => true,
          );

          return Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: context.pHeight(KContents.kHorizontalPad),
                spacing: context.pWidth(KContents.kHorizontalPad),
                children: [
                  if (isLoading || data.$1 == null)
                    ...List.generate(
                      3,
                      (_) => AccountCard.regular(account: Account.dummy),
                    )
                  else
                    ...data.$1!.map((account) {
                      return AccountCard.regular(
                        account: account,
                      );
                    })
                ],
              ),
              const SizedBox(
                height: KContents.kHorizontalPad,
              ),
              Wrap(
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runSpacing: context.pHeight(KContents.kHorizontalPad),
                  spacing: context.pWidth(KContents.kHorizontalPad),
                  children: [
                    Column(
                      children: [
                        Container(
                          // height: 100,
                          padding: KContents.kCardPad,
                          width: 880,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: context.colorScheme.primary
                                      .withOpacity(0.2)),
                              color: AppColors.kBgWhite,
                              borderRadius: BorderRadius.circular(
                                  KContents.kRadius.medium)),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CardHeader(
                                title: "Recurring Bills",
                                buttonTitle: "View All",
                                onPressed: () {
                                  AppRouter.router.go(AppRoutes.billPayments);
                                },
                              ),
                              const SizedBox(
                                height: KContents.kCardPadVertical,
                              ),
                              Wrap(
                                runAlignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                runSpacing:
                                    context.pHeight(KContents.kHorizontalPad),
                                spacing:
                                    context.pWidth(KContents.kHorizontalPad),
                                children: const [
                                  BillCard(),
                                  BillCard(),
                                  BillCard(),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: KContents.kHorizontalPad,
                        ),
                        Container(
                          // height: 100,
                          padding: KContents.kCardPad,
                          width: 880,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: context.colorScheme.primary
                                      .withOpacity(0.2)),
                              color: AppColors.kBgWhite,
                              borderRadius: BorderRadius.circular(
                                  KContents.kRadius.medium)),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CardHeader(
                                title: "Investment Breakdown",
                                buttonTitle: "More Details",
                                onPressed: () {
                                  AppRouter.router.go(AppRoutes.investments);
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Return",
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(
                                            color: context.colorScheme.primary),
                                  ),
                                  const Icon(
                                    FontAwesomeIcons.caretUp,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                  Text(
                                    "40%",
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const InvestmentChart(),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                        // height: 100,
                        padding: KContents.kCardPad,
                        width: 425,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: context.colorScheme.primary
                                    .withOpacity(0.2)),
                            color: AppColors.kBgWhite,
                            borderRadius: BorderRadius.circular(
                                KContents.kRadius.medium)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CardHeader(
                              title: "Recent Transactions",
                              buttonTitle: "View All",
                              onPressed: () {
                                AppRouter.router.go(AppRoutes.investments);
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (isLoading || data.$3 == null)
                              ...List.generate(
                                15,
                                (_) => AppShimmer(
                                    child: CardTile(
                                        transaction: Transaction.dummy)),
                              )
                            else
                              ...data.$3!
                                  .take(10)
                                  .map((transaction) => CardTile(
                                        transaction: transaction,
                                      ))
                          ],
                        ))
                  ])
            ],
          );
        },
      ),
    );
  }
}
