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
    if (input is int) {
      final real =
          getNumberWithThousandSeparator(input.toString(), thousandSeparator);

      final result = '$real${precision > 0 ? '${decimalSeparator}00' : ''}';
      return result;
    }
    final String inputString = input.toString();
    final inputStringSplit = inputString.split('.');
    final realString = inputStringSplit[0];
    final realStringWithThousand =
        getNumberWithThousandSeparator(realString, thousandSeparator);

    if (precision == 0) {
      return realStringWithThousand;
    } else {
      final decimalString =
          inputStringSplit.length > 1 ? inputStringSplit[1] : null;

      return '$realStringWithThousand$decimalSeparator${decimalString != null ? decimalString : '0'.repeat(precision)}';
    }
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
