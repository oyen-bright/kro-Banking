import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kro_banking/bloc/dashboard/dashboard_bloc.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/model/account.dart';
import 'package:kro_banking/model/bills.dart';
import 'package:kro_banking/model/transaction.dart';
import 'package:kro_banking/theme/app_colors.dart';
import 'package:kro_banking/views/dashboard/components/account_card.dart';
import 'package:kro_banking/views/transfer/components/between_accounts.dart';
import 'package:kro_banking/views/wrapper/view_wrapper.dart';
import 'package:kro_banking/widgets/overlay/loading_overlay.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTransfer(context, isLoading, data),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTransfer(BuildContext context, bool isLoading,
      (List<Account>?, List<Bill>?, List<Transaction>?) data) {
    return LoadingOverlay(
      child: ResponsiveBuilder(builder: (context, device) {
        return Container(
          padding: KContents.kCardPad,
          width: 1000,
          height: device.isDesktop ? 760 : 1300,
          decoration: BoxDecoration(
              border: Border.all(
                  color: context.colorScheme.primary.withOpacity(0.2)),
              color: AppColors.kBgWhite,
              borderRadius: BorderRadius.circular(KContents.kRadius.medium)),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: context.colorScheme.primary.withOpacity(0.2)),
                      color: AppColors.kBgWhite,
                      borderRadius:
                          BorderRadius.circular(KContents.kRadius.medium)),
                  child: const TabBar(
                    tabs: [
                      Tab(text: "Between Account"),
                      Tab(text: "Other Transfers"),
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
        );
      }),
    );
  }

  Column _buildAccounts(
      bool isLoading,
      (List<Account>?, List<Bill>?, List<Transaction>?) data,
      BuildContext context) {
    return Column(
      children: [
        if (isLoading || data.$1 == null)
          ...List.generate(
            3,
            (_) => Padding(
              padding: EdgeInsets.only(
                  bottom: context.pWidth(KContents.kHorizontalPad)),
              child: AccountCard.small(account: Account.dummy),
            ),
          )
        else
          ...data.$1!.map((account) => Padding(
                padding: EdgeInsets.only(
                    bottom: context.pWidth(KContents.kHorizontalPad)),
                child: AccountCard.small(
                  account: account,
                ),
              ))
      ],
    );
  }
}
