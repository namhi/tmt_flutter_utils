import 'package:intl/intl.dart';

extension NumExtensions on num {
  String toStringFormat(String? format, {String? locate}) {
    if (format == null) {
      throw ArgumentError.notNull('number');
    }
    return NumberFormat(format, locate).format(
      this,
    );
  }

  String toPercentFormat([String? newFormat, String? locate]) {
    return NumberFormat(newFormat ?? '###,###.##', locate).format(this);
  }

  String toVietnameseCurrencyFormat([String? newFormat, String? newLocate]) {
    return NumberFormat(newFormat ?? '###,###,###,###,###', newLocate)
        .format(this);
  }

  Future<void> delaySecond() async {
    return await Future.delayed(Duration(seconds: this as int));
  }

  Future<void> delayMillisecond() async {
    return await Future.delayed(Duration(milliseconds: this as int));
  }
}
