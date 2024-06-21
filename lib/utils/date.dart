int getDateTime(DateTime dateTime) {
  DateTime now = DateTime.now();
  DateTime midnight = DateTime(now.year, now.month, now.day);
  int millis = midnight.millisecondsSinceEpoch;
  print(millis);
  return millis;
}
