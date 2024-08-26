import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:tmt_dart_utils/tmt_dart_utils.dart';

void main() {
  test('Test toStringFormatWithOption() when input is int', () {
    final int input = 10000001;
    final result = NumUtils.toStringFormatWithOption(
        decimalSeparator: ',',
        thousandSeparator: '.',
        precision: 2,
        input: input);

    print(result);
  });
  test('Test toStringFormatWithOption() when input is double', () {
    final double input = 0;
    final result = NumUtils.toStringFormatWithOption(
        decimalSeparator: ',',
        thousandSeparator: '.',
        precision: 2,
        input: input);
    print(result);
  });

  test('intl convert', () {
    double value = 1234.5678;
    final String format = NumberFormat.currency(
      symbol: '',
      decimalDigits: 2,
      name: 'USD',
      locale: 'vi',
    ).format(value);
    print(format);
  });
}
