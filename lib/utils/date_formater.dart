import 'package:intl/intl.dart';

String formatDate(DateTime? dateTime) {
  if (dateTime == null) return '';

  String daySuffix = _getDaySuffix(dateTime.day);

  DateFormat formatter = DateFormat.yMMMMd();
  String formattedDate = formatter.format(dateTime);

  return '${dateTime.day}$daySuffix ${formattedDate.substring(formattedDate.indexOf(' ') + 1)}';
}

String _getDaySuffix(int day) {
  if (day >= 11 && day <= 13) {
    return 'th';
  }
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}
