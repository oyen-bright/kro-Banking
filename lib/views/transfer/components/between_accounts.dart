import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kro_banking/bloc/bloc/dashboard_bloc.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/model/account.dart';
import 'package:kro_banking/utils/currency_formater.dart';
import 'package:kro_banking/views/transfer/components/confirm_transfer.dart';
import 'package:kro_banking/widgets/buttons/app_elevated_button.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BetweenAccount extends StatefulWidget {
  const BetweenAccount({super.key});

  @override
  State<BetweenAccount> createState() => _BetweenAccountState();
}

class _BetweenAccountState extends State<BetweenAccount> {
  List<Account> accounts = [];

  Account? selectedRecipient;
  Account? selectedPayer;

  double transferAmount = 0.0;

  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (accounts.isEmpty) {
          accounts = state.data.$1 ?? [];
        } else if (state.data.$1 != null && state.data.$1!.isNotEmpty) {
          accounts = state.data.$1!;
        }

        return ResponsiveBuilder(builder: (context, device) {
          if (device.isDesktop) {
            return Row(
              children: [
                _buildBetweenAccount(context, controller, 3),
                const Padding(
                  padding: KContents.kCardPad,
                  child: VerticalDivider(),
                ),
                _buildTransferSummary(context, controller, 2),
              ],
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildBetweenAccount(context, controller, 0),
                const SizedBox(
                  height: 50,
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                _buildTransferSummary(context, controller, 1),
              ],
            );
          }
        });
      },
    );
  }

  Expanded _buildTransferSummary(
      BuildContext context, TextEditingController controller, int flex) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Text(
            "Transfer Summary",
            style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: context.textTheme.titleLarge!.fontSize!),
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pay From Account: ${selectedPayer?.type ?? ""}',
                maxLines: 2,
                style: context.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              AutoSizeText(
                  'Current Balance: ${appCurrency(selectedPayer?.balance ?? 0)}',
                  maxLines: 1,
                  style: context.textTheme.bodyLarge),
              AutoSizeText('Transfer Amount:${appCurrency(transferAmount)}',
                  maxLines: 1, style: context.textTheme.bodyLarge),
              Text(
                'New Balance: ${appCurrency((selectedPayer?.balance ?? 0) - transferAmount)}',
                maxLines: 2,
                style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w300,
                    color: transferAmount > (selectedPayer?.balance ?? 0)
                        ? Colors.red
                        : Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const SizedBox(height: 50, child: VerticalDivider()),
          const SizedBox(height: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recipient Account: ${selectedRecipient?.type ?? ""}',
                maxLines: 2,
                style: context.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              AutoSizeText(
                  'Current Balance:  ${appCurrency(selectedRecipient?.balance ?? 0)}',
                  maxLines: 1,
                  style: context.textTheme.bodyLarge),
              AutoSizeText('Transfer Amount:  ${appCurrency(transferAmount)} ',
                  maxLines: 1, style: context.textTheme.bodyLarge),
              Text(
                  'New Balance: ${appCurrency((selectedRecipient?.balance ?? 0) + transferAmount)} ',
                  maxLines: 2,
                  style: context.textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w300)),
            ],
          ),
          const SizedBox(height: 5),
          const SizedBox(height: 50, child: VerticalDivider()),
          const SizedBox(height: 5),
          AppElevatedButton(
            onPressed: selectedRecipient != null &&
                    selectedPayer != null &&
                    transferAmount > 0 &&
                    transferAmount <= (selectedPayer?.balance ?? 0.0)
                ? () async {
                    final response = await showDialog<bool?>(
                      barrierDismissible: false,
                      useRootNavigator: true,
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmTransfer(
                          transferAmount: transferAmount,
                          selectedPayer: selectedPayer,
                          selectedRecipient: selectedRecipient,
                        );
                      },
                    );
                    if (response != null && response) {
                      setState(() {
                        selectedPayer = null;
                        selectedRecipient = null;
                        transferAmount = 0;
                        controller.clear();
                      });
                    }
                  }
                : null,
            title: ('Transfer'),
          ),
          const SizedBox(height: 5),
          AppElevatedButton(
            onPressed: selectedRecipient != null ||
                    selectedPayer != null ||
                    transferAmount > 0 ||
                    transferAmount <= (selectedPayer?.balance ?? 0.0)
                ? () {
                    setState(() {
                      selectedPayer = null;
                      selectedRecipient = null;
                      transferAmount = 0;
                    });
                  }
                : null,
            title: ('Cancel'),
          ),
        ],
      ),
    );
  }

  Expanded _buildBetweenAccount(
      BuildContext context, TextEditingController controller, int flex) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 30),
          Text(
            "Transfer Between Accounts",
            style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: context.textTheme.titleLarge!.fontSize!),
          ),
          const SizedBox(height: 20),
          Text(
            'Recipient Account',
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 5),
          DropdownButtonFormField<Account>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            hint: const Text("Select Recipient Account"),
            items: accounts.map((Account account) {
              return DropdownMenuItem<Account>(
                value: account,
                child: Text(
                    '${account.type} (Balance: \$${account.balance.toStringAsFixed(2)})'),
              );
            }).toList(),
            onChanged: (Account? newValue) {
              setState(() {
                selectedRecipient = newValue;
                selectedPayer = null;
              });
            },
            value: selectedRecipient,
          ),
          const SizedBox(height: 17),
          Text(
            'Pay From Account',
            textAlign: TextAlign.left,
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 5),
          DropdownButtonFormField<Account>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: accounts
                .where((account) => account != selectedRecipient)
                .map((Account account) {
              return DropdownMenuItem<Account>(
                value: account,
                child: Text(
                    '${account.type} (Balance: \$${account.balance.toStringAsFixed(2)})'),
              );
            }).toList(),
            onChanged: selectedRecipient == null
                ? null
                : (Account? newValue) {
                    setState(() {
                      selectedPayer = newValue;
                    });
                  },
            value: selectedPayer,
            disabledHint: const Text('Select Recipient Account first'),
          ),
          const SizedBox(height: 17),
          Text(
            'Amount',
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            onChanged: (value) {
              setState(() {
                transferAmount = double.tryParse(value) ?? 0.0;
              });
            },
          ),
          if (selectedPayer != null && transferAmount > selectedPayer!.balance)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Insufficient balance!',
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.red,
                ),
              ),
            ),

          // const SizedBox(height: 17),
        ],
      ),
    );
  }
}
