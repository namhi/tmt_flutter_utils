import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_utils.dart';

void main() {
  group('DateTimeRange', () {
    group('constructor', () {
      test('should create DateTimeRange with all properties', () {
        final now = DateTime.now();
        final range = DateTimeRange(
          name: 'Test Range',
          type: DateTimeRangeType.DAY,
          startDate: now,
          endDate: now.add(const Duration(days: 1)),
        );

        expect(range.name, 'Test Range');
        expect(range.type, DateTimeRangeType.DAY);
        expect(range.startDate, now);
        expect(range.endDate, now.add(const Duration(days: 1)));
      });

      test('should create DateTimeRange with null properties', () {
        final range = DateTimeRange();
        expect(range.name, isNull);
        expect(range.type, isNull);
        expect(range.startDate, isNull);
        expect(range.endDate, isNull);
      });

      test('should create DateTimeRange with partial properties', () {
        final now = DateTime.now();
        final range = DateTimeRange(
          name: 'Partial Range',
          startDate: now,
        );
        expect(range.name, 'Partial Range');
        expect(range.startDate, now);
        expect(range.type, isNull);
        expect(range.endDate, isNull);
      });
    });

    group('DAY type ranges', () {
      test('should handle today range', () {
        final range = getTimeRangeToday();
        expect(range.type, DateTimeRangeType.DAY);
        expect(range.name, 'Hôm nay');
        expect(range.endDate!.isAfter(range.startDate!), true);
      });

      test('should handle yesterday range', () {
        final range = getTimeRangeYesterday();
        expect(range.type, DateTimeRangeType.DAY);
        expect(range.name, 'Hôm qua');
      });

      test('should handle last 7 days range', () {
        final range = getTimeRangeLast7Day();
        expect(range.type, DateTimeRangeType.DAY);
        expect(range.name, '7 ngày qua');
      });

      test('should handle last 28 days range', () {
        final range = getTimeRangeLast28Day();
        expect(range.type, DateTimeRangeType.DAY);
        expect(range.name, '28 ngày qua');
      });

      test('should handle last 30 days range', () {
        final range = getTimeRangeLast30Day();
        expect(range.type, DateTimeRangeType.DAY);
        expect(range.name, '30 ngày qua');
      });

      test('should handle last 90 days range', () {
        final range = getTimeRangeLast90Day();
        expect(range.type, DateTimeRangeType.DAY);
        expect(range.name, '90 ngày qua');
      });

      test('should handle custom day range', () {
        final range = getTimeRangeCustomDay();
        expect(range.type, DateTimeRangeType.DAY);
        expect(range.name, 'Tùy chọn ngày');
      });
    });

    group('WEEK type ranges', () {
      test('should handle this week range', () {
        final range = getTimeRangeThisWeek();
        expect(range.type, DateTimeRangeType.WEEK);
        expect(range.name, 'Tuần này');
      });

      test('should handle last week range', () {
        final range = getTimeRangeLastWeek();
        expect(range.type, DateTimeRangeType.WEEK);
        expect(range.name, 'Tuần trước');
      });
    });

    group('MONTH type ranges', () {
      test('should handle this month range', () {
        final range = getTimeRangeThisMonth();
        expect(range.type, DateTimeRangeType.MONTH);
        expect(range.name, 'Tháng này');
      });

      test('should handle last month range', () {
        final range = getTimeRangeLastMonth();
        expect(range.type, DateTimeRangeType.MONTH);
        expect(range.name, 'Tháng trước');
      });

      test('should handle custom month range', () {
        final range = getTimeRangeCustomMonth();
        expect(range.type, DateTimeRangeType.MONTH);
        expect(range.name, 'Tùy chọn tháng');
      });
    });

    group('YEAR type ranges', () {
      test('should handle this year range', () {
        final range = getTimeRangeThisYear();
        expect(range.type, DateTimeRangeType.YEAR);
        expect(range.name, 'Năm nay');
      });

      test('should handle last year range', () {
        final range = getTimeRangeLastYear();
        expect(range.type, DateTimeRangeType.YEAR);
        expect(range.name, 'Năm trước');
      });
    });

    group('duration calculations', () {
      test('should calculate duration correctly for day range', () {
        final range = getTimeRangeToday();
        final duration = range.endDate!.difference(range.startDate!);
        expect(duration.inDays, 0); // Same day, different times
        expect(duration.inHours, 23); // Almost 24 hours
      });

      test('should handle ranges across month boundaries', () {
        final range = getTimeRangeThisMonth();
        // Start is first day of month, end is last day
        expect(range.startDate!.day, 1);
        expect(range.endDate!.month, range.startDate!.month); // Same month
      });

      test('should handle leap year in month ranges', () {
        final feb2024 = DateTime(2024, 2, 15);
        final range = getTimeRangeThisMonth(feb2024);
        expect(range.endDate!.day, 29); // Leap year
      });
    });

    group('toString', () {
      test('should return string representation', () {
        final now = DateTime(2025, 1, 15, 0, 0, 0);
        final range = DateTimeRange(
          name: 'Test',
          startDate: now,
          endDate: now.add(const Duration(days: 1)),
        );
        final result = range.toString();
        expect(result, contains('Test'));
        expect(result, contains('2025-01-15'));
      });

      test('should handle null values in toString', () {
        final range = DateTimeRange();
        final result = range.toString();
        expect(result, contains('null'));
      });
    });

    group('edge cases', () {
      test('should handle same start and end date for single day', () {
        final now = DateTime(2025, 1, 15, 0, 0, 0);
        final range = DateTimeRange(
          name: 'Single Day',
          startDate: now,
          endDate: DateTime(2025, 1, 15, 23, 59, 59),
          type: DateTimeRangeType.DAY,
        );
        expect(range.startDate!.day, 15);
        expect(range.endDate!.day, 15);
      });

      test('should handle year boundaries', () {
        final range = getTimeRangeLastYear();
        expect(range.startDate!.year, lessThan(DateTime.now().year));
      });
    });
  });
}
