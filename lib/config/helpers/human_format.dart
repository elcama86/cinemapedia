import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: "",
      locale: "en",
    ).format(number);

    return formatterNumber;
  }

  static String year(DateTime date) {
    return date.year.toString();
  }
}
