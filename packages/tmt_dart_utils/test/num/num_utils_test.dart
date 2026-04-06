import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_utils.dart';

void main() {
  group('NumUtils', () {
    group('toStringFormatWithOption', () {
      group('integer input', () {
        test('should format integer with separators', () {
          final result = NumUtils.toStringFormatWithOption(
            decimalSeparator: ',',
            thousandSeparator: '.',
            precision: 2,
            input: 10000001,
          );
          expect(result, '10.000.001,00');
        });

        test('should format integer with zero precision', () {
          final result = NumUtils.toStringFormatWithOption(
            decimalSeparator: ',',
            thousandSeparator: '.',
            precision: 0,
            input: 1000,
          );
          expect(result, '1.000');
        });

        test('should handle large integers', () {
          final result = NumUtils.toStringFormatWithOption(
            decimalSeparator: ',',
            thousandSeparator: '.',
            precision: 2,
            input: 999999999999,
          );
          expect(result, contains('999'));
        });

        test('should handle small integers (less than thousand)', () {
          final result = NumUtils.toStringFormatWithOption(
            decimalSeparator: ',',
            thousandSeparator: '.',
            precision: 2,
            input: 999,
          );
          expect(result, '999,00');
        });

        test('should handle negative integers', () {
          final result = NumUtils.toStringFormatWithOption(
            decimalSeparator: ',',
            thousandSeparator: '.',
            precision: 2,
            input: -1000000,
          );
          expect(result, '-1.000.000,00');
        });
      });

      group('double input', () {
        test('should format double with separators', () {
          final result = NumUtils.toStringFormatWithOption(
            decimalSeparator: ',',
            thousandSeparator: '.',
            precision: 2,
            input: 1234.5678,
          );
          expect(result, '1.234,56');
        });

        test('should format double with different precision', () {
          final result = NumUtils.toStringFormatWithOption(
            decimalSeparator: ',',
            thousandSeparator: '.',
            precision: 4,
            input: 1234.5678,
          );
          expect(result, '1,235');
        });

        test('should handle zero with precision', () {
          final result = NumUtils.toStringFormatWithOption(
            decimalSeparator: ',',
            thousandSeparator: '.',
            precision: 2,
            input: 0,
          );
          expect(result, '0,00');
        });

        test('should handle negative numbers', () {
          final result = NumUtils.toStringFormatWithOption(
            decimalSeparator: ',',
            thousandSeparator: '.',
            precision: 2,
            input: -1234.56,
          );
          expect(result, '-1.234,56');
        });

        test('should handle very small decimals', () {
          final result = NumUtils.toStringFormatWithOption(
            decimalSeparator: ',',
            thousandSeparator: '.',
            precision: 2,
            input: 0.001,
          );
          expect(result, '0,00');
        });

        test('should handle double with many decimal places', () {
          final result = NumUtils.toStringFormatWithOption(
            decimalSeparator: ',',
            thousandSeparator: '.',
            precision: 3,
            input: 1234.56789123,
          );
          expect(result, '1.234,568');
        });
      });

      group('different separators', () {
        test('should use custom separators', () {
          final result = NumUtils.toStringFormatWithOption(
            decimalSeparator: '.',
            thousandSeparator: ',',
            precision: 2,
            input: 1234567.89,
          );
          expect(result, '1,234,567.89');
        });

        test('should handle Vietnamese format', () {
          final result = NumUtils.toStringFormatWithOption(
            decimalSeparator: ',',
            thousandSeparator: '.',
            precision: 2,
            input: 1234567.89,
          );
          expect(result, '1.234.567,89');
        });

        test('should handle same separators', () {
          final result = NumUtils.toStringFormatWithOption(
            decimalSeparator: ' ',
            thousandSeparator: '_',
            precision: 2,
            input: 1234567.89,
          );
          expect(result, '1_234_567 89');
        });
      });

      group('edge cases', () {
        test('should handle zero precision for double', () {
          final result = NumUtils.toStringFormatWithOption(
            decimalSeparator: ',',
            thousandSeparator: '.',
            precision: 0,
            input: 1234.56,
          );
          expect(result, '1.235');
        });

        test('should handle high precision', () {
          final result = NumUtils.toStringFormatWithOption(
            decimalSeparator: ',',
            thousandSeparator: '.',
            precision: 6,
            input: 1234,
          );
          expect(result, '1.234,000000');
        });
      });
    });

    group('getNumberWithThousandSeparator', () {
      test('should add thousand separators to number string', () {
        expect(
          NumUtils.getNumberWithThousandSeparator('1234567', ','),
          '1,234,567',
        );
      });

      test('should handle negative numbers', () {
        expect(
          NumUtils.getNumberWithThousandSeparator('-1234567', ','),
          '-1,234,567',
        );
      });

      test('should handle zero', () => expect(NumUtils.getNumberWithThousandSeparator('0', ','), '0'););

      test('should handle decimal numbers', () {
        expect(
          NumUtils.getNumberWithThousandSeparator('12345.67', ','),
          '12,346',
        );
      });

      test('should handle large numbers', () {
        expect(
          NumUtils.getNumberWithThousandSeparator('999999999999', ','),
          '999,999,999,999',
        );
      });

      test('should handle different separator', () {
        expect(
          NumUtils.getNumberWithThousandSeparator('1234567', '.'),
          '1.234.567',
        );
      });

      test('should handle small numbers (less than thousand)', () {
        expect(
          NumUtils.getNumberWithThousandSeparator('999', ','),
          '999',
        );
      });

      test('should handle single digit', () {
        expect(
          NumUtils.getNumberWithThousandSeparator('5', ','),
          '5',
        );
      });

      test('should handle thousands boundary', () {
        expect(
          NumUtils.getNumberWithThousandSeparator('1000', ','),
          '1,000',
        );
      });

      test('should handle millions', () {
        expect(
          NumUtils.getNumberWithThousandSeparator('1234567890', ','),
          '1,234,567,890',
        );
      });
    });
  });
}
