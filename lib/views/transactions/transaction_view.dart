import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kro_banking/bloc/dashboard/dashboard_bloc.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/theme/app_colors.dart';
import 'package:kro_banking/views/transactions/components/transaction_tabs.dart';
import 'package:kro_banking/views/wrapper/view_wrapper.dart';
import 'package:kro_banking/widgets/overlay/loading_overlay.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewWrapper(
      headerTitle: "Transactions",
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: KContents.kCardPad,
                  width: 1000,
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
            ],
          );
        },
      ),
    );
  }
}
