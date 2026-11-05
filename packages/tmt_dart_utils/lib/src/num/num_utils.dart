import 'package:tmt_dart_utils/src/string/string_extensions.dart';

import '../../tmt_dart_utils.dart';

class NumUtils {
  NumUtils._();

  /// Convert a num (double) to String with String format by option.
  /// Example:
  /// Input: 1000.523
  /// Options : decimalSeparator = '.', thousandSeparator = ',', precision = '2'
  /// Result: 1,000.52
  static String toStringFormatWithOption({
    required String decimalSeparator,
    required String thousandSeparator,
    required int precision,
    required num input,
  }) {
    if (precision < 0 || precision > 20) {
      throw ArgumentError('precision must be between 0 and 20');
    }
    if (input is int) {
      final real =
          getNumberWithThousandSeparator(input.toString(), thousandSeparator);

      final result =
          '$real${precision > 0 ? '$decimalSeparator${'0'.repeat(precision)}' : ''}';
      return result;
    }
    // Round to [precision] decimals, then thousand-separate the integer part.
    final roundedSplit = input.toStringAsFixed(precision).split('.');
    final realStringWithThousand =
        getNumberWithThousandSeparator(roundedSplit[0], thousandSeparator);

    if (precision == 0) {
      return realStringWithThousand;
    }
    final decimalString =
        roundedSplit.length > 1 ? roundedSplit[1] : '0'.repeat(precision);
    return '$realStringWithThousand$decimalSeparator$decimalString';
  }

  /// Add thousand sign to raw input number string.
  /// Ex: When Input is '1234567' then result is '1.234.567'
  static String getNumberWithThousandSeparator(
      String input, String thousandSeparator) {
    int count = 0;
    final StringBuffer sb = StringBuffer();
    final mark = input[0] == '-' ? '-' : '';
    final inputRemovedMark = RegExp(r'\d+').stringMatch(input) ?? '';
    final String inputReverse = StringUtils.reverse(inputRemovedMark);

    for (var i = 0; i < inputReverse.length; i++) {
      final e = inputReverse[i];
      if (i != inputReverse.length - 1) {
        count += 1;
      }

      sb.write(e);
      if (count == 3) {
        sb.write(thousandSeparator);
        count = 0;
      }
    }

    final result = sb.toString();
    return mark + StringUtils.reverse(result);
  }
}
