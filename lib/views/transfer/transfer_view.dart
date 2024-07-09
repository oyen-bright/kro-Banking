import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:kro_banking/views/dashboard/components/card_header.dart';
import 'package:kro_banking/views/dashboard/components/recent_transaction_tile.dart';
import 'package:kro_banking/views/transfer/components/between_accounts.dart';
import 'package:kro_banking/views/wrapper/view_wrapper.dart';
import 'package:kro_banking/widgets/app_shimer.dart';
import 'package:kro_banking/widgets/overlay/loading_overlay.dart';

class TransferView extends StatelessWidget {
  const TransferView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewWrapper(
      headerTitle: "Transfer",
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          final (List<Account>?, List<Bill>?, List<Transaction>?) data =
              state.data;

          final isLoading = state.maybeWhen(
            orElse: () => false,
            loading: (_, __, ___) => true,
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: context.pHeight(KContents.kHorizontalPad),
                spacing: context.pWidth(KContents.kHorizontalPad),
                children: [
                  LoadingOverlay(
                    child: Container(
                      padding: KContents.kCardPad,
                      width: 880,
                      height: 800,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  context.colorScheme.primary.withOpacity(0.2)),
                          color: AppColors.kBgWhite,
                          borderRadius:
                              BorderRadius.circular(KContents.kRadius.medium)),
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: context.colorScheme.primary
                                          .withOpacity(0.2)),
                                  color: AppColors.kBgWhite,
                                  borderRadius: BorderRadius.circular(
                                      KContents.kRadius.medium)),
                              child: const TabBar(
                                tabs: [
                                  Tab(
                                      icon:
                                          Icon(Icons.transfer_within_a_station),
                                      text: "Between Account"),
                                  Tab(
                                      icon: Icon(Icons.account_balance),
                                      text: "To Banks"),
                                ],
                              ),
                            ),
                            const Expanded(
                              child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                children: [BetweenAccount(), SizedBox()],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      if (isLoading || data.$1 == null)
                        ...List.generate(
                          3,
                          (_) => Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    context.pWidth(KContents.kHorizontalPad)),
                            child: AppShimmer(
                                child:
                                    AccountCard.small(account: Account.dummy)),
                          ),
                        )
                      else
                        ...data.$1!.map((account) => Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      context.pWidth(KContents.kHorizontalPad)),
                              child: AccountCard.small(
                                account: account,
                              ),
                            ))
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: KContents.kHorizontalPad,
              ),
              LoadingOverlay(
                child: Container(
                    // height: 100,
                    padding: KContents.kCardPad,
                    width: 880,
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
                          title: "Recent Transfers",
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
                                child:
                                    CardTile(transaction: Transaction.dummy)),
                          )
                        else
                          ...data.$3!.take(10).map((transaction) => CardTile(
                                transaction: transaction,
                              ))
                      ],
                    )),
              )
            ],
          );
        },
      ),
    );
  }
}
