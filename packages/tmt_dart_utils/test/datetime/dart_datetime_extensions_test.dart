import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_extensions.dart';

void main() {
  group('DartDateTimeExtensions', () {
    group('toDayOfWeek', () {
      test('should return Vietnamese day of week', () {
        final monday = DateTime(2025, 1, 6); // Monday
        expect(monday.toDayOfWeek('vi-VN'), 'Thứ hai');
      });

      test('should return English day of week', () {
        final monday = DateTime(2025, 1, 6); // Monday
        expect(monday.toDayOfWeek('en-US'), 'Monday');
      });

      test('should return Sunday for Sunday', () {
        final sunday = DateTime(2025, 1, 12); // Sunday
        expect(sunday.toDayOfWeek('vi-VN'), 'Chủ nhật');
        expect(sunday.toDayOfWeek('en-US'), 'Sunday');
      });

      test('should work for all weekdays', () {
        final tuesday = DateTime(2025, 1, 7);
        final wednesday = DateTime(2025, 1, 8);
        final thursday = DateTime(2025, 1, 9);
        final friday = DateTime(2025, 1, 10);
        final saturday = DateTime(2025, 1, 11);

        expect(tuesday.toDayOfWeek('vi-VN'), 'Thứ ba');
        expect(wednesday.toDayOfWeek('vi-VN'), 'Thứ tư');
        expect(thursday.toDayOfWeek('vi-VN'), 'Thứ năm');
        expect(friday.toDayOfWeek('vi-VN'), 'Thứ sáu');
        expect(saturday.toDayOfWeek('vi-VN'), 'Thứ bảy');
      });
    });

    group('toStringFormat', () {
      test('should format date with custom format', () {
        final date = DateTime(2025, 1, 15, 14, 30, 45);
        expect(date.toStringFormat('dd/MM/yyyy'), '15/01/2025');
        expect(date.toStringFormat('HH:mm'), '14:30');
      });

      test('should handle different formats', () {
        final date = DateTime(2025, 1, 15);
        expect(date.toStringFormat('yyyy-MM-dd'), '2025-01-15');
        expect(date.toStringFormat('dd-MM-yyyy'), '15-01-2025');
      });
    });

    group('toTimeAgo', () {
      test('should return time ago string', () {
        final now = DateTime.now().subtract(const Duration(days: 1));
        expect(now.toTimeAgo('en'), 'a day ago');
      });

      test('should handle recent times', () {
        final now = DateTime.now().subtract(const Duration(minutes: 5));
        expect(now.toTimeAgo('en'), '5 minutes ago');
      });

      test('should handle old times', () {
        final now = DateTime.now().subtract(const Duration(days: 365));
        expect(now.toTimeAgo('en'), contains('ago'));
      });
    });

    group('clearTime', () {
      test('should set time to midnight', () {
        final date = DateTime(2025, 1, 15, 14, 30, 45, 500);
        final result = date.clearTime();
        expect(result, DateTime(2025, 1, 15, 0, 0, 0, 0));
      });

      test('should clear all time components', () {
        final date = DateTime(2025, 1, 15, 14, 30, 45, 123, 456);
        final result = date.clearTime();
        expect(result.millisecond, 0);
        expect(result.microsecond, 0);
      });
    });

    group('setLastDay', () {
      test('should set time to end of day', () {
        final date = DateTime(2025, 1, 15, 10, 30, 45);
        final result = date.setLastDay();
        expect(result.hour, 23);
        expect(result.minute, 59);
        expect(result.second, 59);
        expect(result.millisecond, 999);
      });

      test('should preserve date', () {
        final date = DateTime(2025, 1, 15, 10, 30, 45);
        final result = date.setLastDay();
        expect(result.year, 2025);
        expect(result.month, 1);
        expect(result.day, 15);
      });
    });

    group('addHours', () {
      test('should add hours to date', () {
        final date = DateTime(2025, 1, 15, 10, 30, 45);
        final result = date.addHours(5);
        expect(result, DateTime(2025, 1, 15, 15, 30, 45));
      });

      test('should handle negative hours', () {
        final date = DateTime(2025, 1, 15, 10, 30, 45);
        final result = date.addHours(-5);
        expect(result, DateTime(2025, 1, 15, 5, 30, 45));
      });
    });

    group('addDays', () {
      test('should add days to date', () {
        final date = DateTime(2025, 1, 15);
        final result = date.addDays(7);
        expect(result, DateTime(2025, 1, 22));
      });

      test('should handle negative days', () {
        final date = DateTime(2025, 1, 15);
        final result = date.addDays(-3);
        expect(result, DateTime(2025, 1, 12));
      });
    });

    group('addMinutes', () {
      test('should add minutes to date', () {
        final date = DateTime(2025, 1, 15, 10, 30, 0);
        final result = date.addMinutes(45);
        expect(result, DateTime(2025, 1, 15, 11, 15, 0));
      });

      test('should handle negative minutes', () {
        final date = DateTime(2025, 1, 15, 11, 15, 0);
        final result = date.addMinutes(-30);
        expect(result, DateTime(2025, 1, 15, 10, 45, 0));
      });
    });
  });
}
