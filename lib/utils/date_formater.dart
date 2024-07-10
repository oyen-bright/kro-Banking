import 'package:intl/intl.dart';

String formatDate(DateTime? dateTime) {
  if (dateTime == null) return '';

  DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  return formatter.format(dateTime);
}
