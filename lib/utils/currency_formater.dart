import 'package:intl/intl.dart';
import 'package:kro_banking/constants/app_constants.dart';

String appCurrency(double amount, [bool withSymbol = true]) {
  final formatter = NumberFormat.currency(
    locale: 'en_NG',
    symbol: withSymbol ? KContents.kAppCurrency : "",
  );
  return formatter.format(amount);
}

String appCurrencyRemoval(String formattedAmount) {
  return formattedAmount.replaceAll('₦', '').replaceAll(',', '');
}
