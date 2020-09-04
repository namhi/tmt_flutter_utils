import 'package:intl/intl.dart';

extension DoubleExtensions on num {
  String toStringFormat(String format, {String locate}) {
    if (format == null) {
      throw ArgumentError.notNull('number');
    }
    return NumberFormat(format, locate).format(
      this,
    );
  }

  String toPercentFormat([String newFormat, String locate]) {
    return NumberFormat(newFormat ?? '###,###.##', locate).format(this);
  }

  String toVietnameseCurrencyFormat([String newFormat, String newLocate]) {
    return NumberFormat(newFormat ?? '###,###,###,###,###', newLocate)
        .format(this);
  }
}
