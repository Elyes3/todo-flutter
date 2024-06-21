import 'package:intl/intl.dart';

int getDateTime(DateTime dateTime) {
  DateTime midnight = DateTime(dateTime.year, dateTime.month, dateTime.day);
  int millis = midnight.millisecondsSinceEpoch;
  return millis;
}

String dateFromMillis(int millis) {
  print(millis);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(millis);
  String formattedDate = DateFormat('dd-MM-yyyy').format(date);
  return formattedDate;
}
