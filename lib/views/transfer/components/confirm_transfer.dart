import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/model/account.dart';
import 'package:kro_banking/theme/app_colors.dart';
import 'package:kro_banking/utils/currency_formater.dart';
import 'package:kro_banking/widgets/buttons/app_elevated_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmTransfer extends StatefulWidget {
  final Account? selectedPayer;
  final Account? selectedRecipient;
  final double transferAmount;

  const ConfirmTransfer({
    super.key,
    required this.selectedPayer,
    required this.selectedRecipient,
    required this.transferAmount,
  });

  @override
  _ConfirmTransferState createState() => _ConfirmTransferState();
}

class _ConfirmTransferState extends State<ConfirmTransfer> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.kBgWhite,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KContents.kRadius.medium)),
      child: SizedBox(
        width: context.pWidth(500),
        height: context.pWidth(500),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    color: Colors.white,
                    onPressed: () {
                      if (_pageController.page == 0) {
                        context.pop();
                        return;
                      }
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Text(
                    "Transfer Between Accounts",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildTransferSummaryPage(),
                  _buildPinPage(_pageController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransferSummaryPage() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pay From Account: ${widget.selectedPayer?.type ?? ""}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            'Current Balance: ${appCurrency(widget.selectedPayer?.balance ?? 0)}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          const SizedBox(height: 50, child: VerticalDivider()),
          const Spacer(),
          Text(
            'Recipient Account: ${widget.selectedRecipient?.type ?? ""}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Current Balance: ${appCurrency(widget.selectedRecipient?.balance ?? 0)}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          const Spacer(
            flex: 2,
          ),
          Text(
            textAlign: TextAlign.end,
            'Transfer Amount: ${appCurrency(widget.transferAmount)}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Expanded(
                child: AppElevatedButton(
                  onPressed: () {
                    _pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  title: ('Proceed'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPinPage(PageController pageController) {
    return Padding(
      padding: KContents.kCardPad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction PIN',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: TransactionPinInput(
              pageController: pageController,
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionPinInput extends StatefulWidget {
  const TransactionPinInput({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<TransactionPinInput> createState() => _TransactionPinInputState();
}

class _TransactionPinInputState extends State<TransactionPinInput> {
  TextEditingController textEditingController = TextEditingController();

  late final StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.pWidth(20)),
            child: PinCodeTextField(
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: context.pWidth(60),
                  fieldWidth: context.pWidth(50),
                  activeColor: context.colorScheme.primary,
                  inactiveColor: context.colorScheme.primary,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.transparent),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: textEditingController,
              onCompleted: (v) {},
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 6) {
                  return " ";
                }
                return null;
              },
              appContext: context,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Expanded(
                child: AppElevatedButton(
                  onPressed: () {
                    formKey.currentState!.validate();
                    // conditions for validating
                    if (currentText.length != 6) {
                      errorController.add(ErrorAnimationType
                          .shake); // Triggering error shake animation
                    }
                  },
                  title: ('Confirm Transfer'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
