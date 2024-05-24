import 'package:intl/intl.dart';

String formatCurrency(String? price) {
  if (price != null) {
    try {
      final double amount = double.parse(price);
      final NumberFormat formatCurrency =
          NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
      return formatCurrency.format(amount);
    } catch (e) {
      return '';
    }
  } else {
    return 'Detail Produk';
  }
}
