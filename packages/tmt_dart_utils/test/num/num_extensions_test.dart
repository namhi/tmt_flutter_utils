import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_extensions.dart';

void main() {
  group('NumExtensions', () {
    group('toStringFormat', () {
      test('should format number with given format', () {
        expect(1234.56.toStringFormat('#,##0.00'), '1,234.56');
        expect(1234567.toStringFormat('#,###,###'), '1,234,567');
      });

      test('should handle integer values', () {
        expect(42.toStringFormat('00'), '42');
        expect(7.toStringFormat('000'), '007');
      });

      test('should throw when format is null', () {
        expect(() => 42.toStringFormat(null), throwsArgumentError);
      });

      test('should use custom locale', () {
        expect(1234.56.toStringFormat('#,##0.00', locate: 'vi_VN'), '1.234,56');
      });
    });

    group('toPercentFormat', () {
      test('should format as percentage', () {
        expect(0.75.toPercentFormat(), '0.75');
        expect(0.1234.toPercentFormat('##0.00%'), '12.34%');
      });

      test('should handle integers', () {
        expect(1.toPercentFormat(), '1');
      });
    });

    group('toVietnameseCurrencyFormat', () {
      test('should format as Vietnamese currency', () {
        expect(1234567.toVietnameseCurrencyFormat(), '1,234,567');
      });

      test('should handle decimal values', () {
        expect(1234.56.toVietnameseCurrencyFormat('###,###.##'), '1,234.56');
      });
    });

    group('delaySecond', () {
      test('should delay for specified seconds', () async {
        final stopwatch = Stopwatch()..start();
        await 1.delaySecond();
        stopwatch.stop();
        expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(1000));
        expect(stopwatch.elapsedMilliseconds, lessThan(1200)); // Allow more margin
      });
    });

    group('delayMillisecond', () {
      test('should delay for specified milliseconds', () async {
        final stopwatch = Stopwatch()..start();
        await 100.delayMillisecond();
        stopwatch.stop();
        expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(100));
        expect(stopwatch.elapsedMilliseconds, lessThan(300)); // Allow more margin
      });
    });

    test('should handle zero delay', () async {
      final stopwatch = Stopwatch()..start();
      await 0.delayMillisecond();
      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, lessThan(100)); // Should be very fast
    });
  });
}
