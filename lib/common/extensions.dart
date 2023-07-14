import 'package:intl/intl.dart';

extension IdrFormat on int {
  String convertToIdr() {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 2,
    );
    return currencyFormatter.format(this);
  }
}

extension LocalDateFormat on DateTime {
  String formatToString() {
    final dateFormat = DateFormat.yMMMMEEEEd('id');

    return dateFormat.format(this);
  }
}

extension IdrFormatFromString on String {
  String convertToIdr() {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 2,
    );

    final currencyInt = int.parse(this);

    return currencyFormatter.format(currencyInt);
  }

  String formatToLocalFormat() {
    final dateTime = DateTime.parse(this);
    final dateFormat = DateFormat.yMMMMEEEEd('id');

    return dateFormat.format(dateTime);
  }
}
