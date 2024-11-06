import 'package:intl/intl.dart';

class HumanFormats {
  static String humanReadableDate(DateTime dateTime) {
    final formatter = DateFormat.MMMEd('en_US');
    return formatter.format(dateTime);
  }
}
