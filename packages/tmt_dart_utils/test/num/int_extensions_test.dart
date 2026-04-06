import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_extensions.dart';

void main() {
  group('IntExtensions', () {
    group('Duration getters', () {
      group('hour', () {
        test('should convert int to Duration in hours', () {
          expect(1.hour, const Duration(hours: 1));
          expect(5.hour, const Duration(hours: 5));
          expect(0.hour, Duration.zero);
        });

        test('should work with negative hours', () {
          expect((-1).hour, const Duration(hours: -1));
        });
      });

      group('minute', () {
        test('should convert int to Duration in minutes', () {
          expect(1.minute, const Duration(minutes: 1));
          expect(30.minute, const Duration(minutes: 30));
          expect(0.minute, Duration.zero);
        });

        test('should work with negative minutes', () {
          expect((-15).minute, const Duration(minutes: -15));
        });
      });

      group('second', () {
        test('should convert int to Duration in seconds', () {
          expect(1.second, const Duration(seconds: 1));
          expect(60.second, const Duration(minutes: 1));
          expect(0.second, Duration.zero);
        });

        test('should work with negative seconds', () {
          expect((-30).second, const Duration(seconds: -30));
        });
      });
    });

    group('byteSizeToString', () {
      test('should return "0 B" for zero or negative values', () {
        expect(0.byteSizeToString(), '0 B');
        expect((-1).byteSizeToString(), '0 B');
        expect((-100).byteSizeToString(), '0 B');
      });

      test('should return bytes for values < 1024', () {
        expect(1.byteSizeToString(), '1.00 B');
        expect(512.byteSizeToString(), '512.00 B');
        expect(1023.byteSizeToString(), '1023.00 B');
      });

      test('should return kilobytes for values >= 1024 and < 1048576', () {
        expect(1024.byteSizeToString(), '1.00 kB');
        expect(2048.byteSizeToString(), '2.00 kB');
        expect(1536.byteSizeToString(), '1.50 kB');
      });

      test('should return megabytes for values >= 1048576 and < 1073741824', () {
        expect(1048576.byteSizeToString(), '1.00 MB');
        expect(2097152.byteSizeToString(), '2.00 MB');
        expect(1572864.byteSizeToString(), '1.50 MB');
      });

      test('should return gigabytes for values >= 1073741824 and < 1099511627776', () {
        expect(1073741824.byteSizeToString(), '1.00 GB');
        expect(2147483648.byteSizeToString(), '2.00 GB');
      });

      test('should return terabytes for large values', () {
        expect(1099511627776.byteSizeToString(), '1.00 TB');
        expect(2199023255552.byteSizeToString(), '2.00 TB');
      });

      test('should respect custom fraction digits', () {
        expect(1536.byteSizeToString(0), '2 kB');
        expect(1536.byteSizeToString(1), '1.5 kB');
        expect(1536.byteSizeToString(2), '1.50 kB');
        expect(1536.byteSizeToString(4), '1.5000 kB');
      });

      test('should handle very large values', () {
        // Petabytes
        expect(1125899906842624.byteSizeToString(), '1.00 PB');
        // Exabytes
        expect(1152921504606846976.byteSizeToString(), '1.00 EB');
      });
    });
  });

  group('IntNullEx', () {
    group('valueOrDefault', () {
      test('should return the value when int is not null', () {
        const int value = 42;
        expect(value.valueOrDefault(), 42);
      });

      test('should return zero (default) when int is null', () {
        const int? value = null;
        expect(value.valueOrDefault(), 0);
      });

      test('should return custom default value when int is null', () {
        const int? value = null;
        expect(value.valueOrDefault(99), 99);
      });

      test('should work with negative numbers', () {
        const int value = -123;
        expect(value.valueOrDefault(), -123);
      });

      test('should work with zero', () {
        const int value = 0;
        expect(value.valueOrDefault(), 0);
      });

      test('should work with very large numbers', () {
        const int value = 9223372036854775807; // max int64
        expect(value.valueOrDefault(), 9223372036854775807);
      });
    });
  });
}
