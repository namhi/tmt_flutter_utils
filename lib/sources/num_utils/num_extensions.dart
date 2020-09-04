import 'package:intl/intl.dart';

const vietnameseCurrencyFormat = '###,###,###,###,###';
const englishCurrencyFormat = '###,###,###,###.##';

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

  /// Format số thành định dạng tiền tệ phù hợp với ngôn ngữ
  /// ví dụ: 10.34 với $
  /// ví dụ: 10 với vnd
  String toCurrencyFormat([String newFormat, String newLocate]) {}
}
