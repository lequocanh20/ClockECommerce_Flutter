import 'package:intl/intl.dart';

class Utilities {

  static String formatCurrency(dynamic price) {
    // Intl.defaultLocale = 'vi_VN';
    // var format = NumberFormat.simpleCurrency(locale: Intl.defaultLocale);
    final oCcy = NumberFormat("#,##0");
    return oCcy.format(price) + NumberFormat.simpleCurrency(locale: 'vi_VN').currencySymbol;
  }
}
