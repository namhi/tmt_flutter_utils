import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_utils.dart';

void main() {
  group('Date Range Functions', () {
    group('getFirstDateOfWeek', () {
      test('should return Monday of the week', () {
        final tuesday = DateTime(2025, 1, 7); // Jan 7, 2025 is Tuesday
        final result = getFirstDateOfWeek(tuesday);
        expect(result.weekday, DateTime.monday);
        expect(result, DateTime(2025, 1, 6, 0, 0, 0));
      });

      test('should return time set to midnight', () {
        final date = DateTime(2025, 1, 8, 14, 30, 45);
        final result = getFirstDateOfWeek(date);
        expect(result.hour, 0);
        expect(result.minute, 0);
        expect(result.second, 0);
      });
    });

    group('getLastDateOfWeek', () {
      test('should return Sunday of the week', () {
        final tuesday = DateTime(2025, 1, 7); // Jan 7, 2025 is Tuesday
        final result = getLastDateOfWeek(tuesday);
        expect(result.weekday, DateTime.sunday);
      });

      test('should return time set to end of day', () {
        final date = DateTime(2025, 1, 8, 10, 15, 30);
        final result = getLastDateOfWeek(date);
        expect(result.hour, 23);
        expect(result.minute, 59);
        expect(result.second, 59);
      });
    });

    group('getFirstDateOfMonth', () {
      test('should return first day of month', () {
        final date = DateTime(2025, 1, 15);
        final result = getFirstDateOfMonth(date);
        expect(result, DateTime(2025, 1, 1, 0, 0, 0));
      });

      test('should work for December', () {
        final date = DateTime(2025, 12, 15);
        final result = getFirstDateOfMonth(date);
        expect(result, DateTime(2025, 12, 1, 0, 0, 0));
      });
    });

    group('getLastDateOfMonth', () {
      test('should return last day of month', () {
        final date = DateTime(2025, 1, 15);
        final result = getLastDateOfMonth(date);
        expect(result, DateTime(2025, 1, 31, 23, 59, 59, 999, 999));
      });

      test('should work for February in non-leap year', () {
        final date = DateTime(2025, 2, 15);
        final result = getLastDateOfMonth(date);
        expect(result, DateTime(2025, 2, 28, 23, 59, 59, 999, 999));
      });

      test('should work for February in leap year', () {
        final date = DateTime(2024, 2, 15);
        final result = getLastDateOfMonth(date);
        expect(result, DateTime(2024, 2, 29, 23, 59, 59, 999, 999));
      });
    });
  });

  group('Predefined Time Ranges', () {
    group('getTimeRangeToday', () {
      test('should return today\'s date range', () {
        final now = DateTime(2025, 1, 15, 10, 30, 45);
        final range = getTimeRangeToday(now);
        expect(range.type, DateTimeRangeType.DAY);
        expect(range.startDate, DateTime(2025, 1, 15, 0, 0, 0));
        expect(range.endDate, DateTime(2025, 1, 15, 23, 59, 59, 999, 999));
      });

      test('should use DateTime.now() when no date provided', () {
        fakeAsync((async) async {
          // This test would use real DateTime.now()
          // For testing, we just verify the function returns a range
          final range = getTimeRangeToday();
          expect(range, isA<DateTimeRange>());
        });
      });
    });

    group('getTimeRangeYesterday', () {
      test('should return yesterday\'s date range', () {
        final now = DateTime(2025, 1, 15, 10, 30, 45);
        final range = getTimeRangeYesterday(now);
        expect(range.type, DateTimeRangeType.DAY);
        expect(range.startDate, DateTime(2025, 1, 14, 0, 0, 0));
        expect(range.endDate, DateTime(2025, 1, 14, 23, 59, 59, 999, 999));
      });
    });

    group('getTimeRangeLast7Day', () {
      test('should return last 7 days range', () {
        final now = DateTime(2025, 1, 15, 10, 30, 45);
        final range = getTimeRangeLast7Day(now);
        expect(range.type, DateTimeRangeType.DAY);
        expect(range.startDate, DateTime(2025, 1, 9, 0, 0, 0));
        expect(range.endDate, DateTime(2025, 1, 15, 23, 59, 59, 999, 999));
      });
    });

    group('getTimeRangeLast28Day', () {
      test('should return last 28 days range', () {
        final now = DateTime(2025, 1, 30, 10, 30, 45);
        final range = getTimeRangeLast28Day(now);
        expect(range.type, DateTimeRangeType.DAY);
        expect(range.startDate, DateTime(2025, 1, 2, 0, 0, 0));
        expect(range.endDate, DateTime(2025, 1, 30, 23, 59, 59, 999, 999));
      });
    });

    group('getTimeRangeLast30Day', () {
      test('should return last 30 days range', () {
        final now = DateTime(2025, 1, 31, 10, 30, 45);
        final range = getTimeRangeLast30Day(now);
        expect(range.type, DateTimeRangeType.DAY);
        expect(range.startDate, DateTime(2025, 1, 1, 0, 0, 0));
        expect(range.endDate, DateTime(2025, 1, 31, 23, 59, 59, 999, 999));
      });
    });

    group('getTimeRangeLast90Day', () {
      test('should return last 90 days range', () {
        final now = DateTime(2025, 4, 15, 10, 30, 45);
        final range = getTimeRangeLast90Day(now);
        expect(range.type, DateTimeRangeType.DAY);
        expect(range.startDate, DateTime(2025, 1, 15, 0, 0, 0));
        expect(range.endDate, DateTime(2025, 4, 15, 23, 59, 59, 999, 999));
      });
    });

    group('getTimeRangeThisWeek', () {
      test('should return this week range', () {
        final now = DateTime(2025, 1, 15, 10, 30, 45); // Wednesday
        final range = getTimeRangeThisWeek(now);
        expect(range.type, DateTimeRangeType.WEEK);
        expect(range.name, 'Tuần này');
        expect(range.startDate.weekday, DateTime.monday);
        expect(range.endDate.weekday, DateTime.sunday);
      });
    });

    group('getTimeRangeLastWeek', () {
      test('should return last week range', () {
        final now = DateTime(2025, 1, 15, 10, 30, 45); // Wednesday
        final range = getTimeRangeLastWeek(now);
        expect(range.type, DateTimeRangeType.WEEK);
        expect(range.name, 'Tuần trước');
      });
    });

    group('getTimeRangeThisMonth', () {
      test('should return this month range', () {
        final now = DateTime(2025, 1, 15, 10, 30, 45);
        final range = getTimeRangeThisMonth(now);
        expect(range.type, DateTimeRangeType.MONTH);
        expect(range.name, 'Tháng này');
        expect(range.startDate.day, 1);
      });
    });

    group('getTimeRangeLastMonth', () {
      test('should return last month range', () {
        final now = DateTime(2025, 2, 15, 10, 30, 45);
        final range = getTimeRangeLastMonth(now);
        expect(range.type, DateTimeRangeType.MONTH);
        expect(range.name, 'Tháng trước');
        expect(range.startDate, DateTime(2025, 1, 1, 0, 0, 0));
        expect(range.endDate.month, 1); // January
      });
    });

    group('getTimeRangeCustomMonth', () {
      test('should return custom month range with today\'s date', () {
        final now = DateTime(2025, 1, 15, 10, 30, 45);
        final range = getTimeRangeCustomMonth(now);
        expect(range.type, DateTimeRangeType.MONTH);
        expect(range.name, 'Tùy chọn tháng');
        expect(range.startDate, DateTime(2025, 1, 15, 0, 0, 0));
        expect(range.endDate, DateTime(2025, 1, 15, 23, 59, 59, 999, 999));
      });

      test('should use DateTime.now() when no date provided', () {
        fakeAsync((async) async {
          final range = getTimeRangeCustomMonth();
          expect(range, isA<DateTimeRange>());
          expect(range.type, DateTimeRangeType.MONTH);
        });
      });
    });

    group('getTimeRangeCustomDay', () {
      test('should return custom day range with today\'s date', () {
        final now = DateTime(2025, 1, 15, 10, 30, 45);
        final range = getTimeRangeCustomDay(now);
        expect(range.type, DateTimeRangeType.DAY);
        expect(range.name, 'Tùy chọn ngày');
        expect(range.startDate, DateTime(2025, 1, 15, 0, 0, 0));
        expect(range.endDate, DateTime(2025, 1, 15, 23, 59, 59, 999, 999));
      });

      test('should use DateTime.now() when no date provided', () {
        fakeAsync((async) async {
          final range = getTimeRangeCustomDay();
          expect(range, isA<DateTimeRange>());
          expect(range.type, DateTimeRangeType.DAY);
        });
      });
    });

    group('getTimeRangeThisYear', () {
      test('should return this year range', () {
        final now = DateTime(2025, 6, 15, 10, 30, 45);
        final range = getTimeRangeThisYear(now);
        expect(range.type, DateTimeRangeType.YEAR);
        expect(range.name, 'Năm nay');
        expect(range.startDate, DateTime(2025, 1, 1, 0, 0, 0));
        expect(range.endDate, DateTime(2025, 12, 31, 23, 59, 59, 999, 999));
      });
    });

    group('getTimeRangeLastYear', () {
      test('should return last year range', () {
        final now = DateTime(2025, 6, 15, 10, 30, 45);
        final range = getTimeRangeLastYear(now);
        expect(range.type, DateTimeRangeType.YEAR);
        expect(range.name, 'Năm trước');
        expect(range.startDate, DateTime(2024, 1, 1, 0, 0, 0));
        expect(range.endDate, DateTime(2024, 12, 31, 23, 59, 59, 999, 999));
      });
    });

    group('datetimeToStringSort', () {
      test('should return day when date is in current month', () {
        final today = DateTime(2025, 1, 15, 10, 30, 45);
        final date = DateTime(2025, 1, 10);
        expect(datetimeToStringSort(date, today), '10');
      });

      test('should return day/month when date is in current year but different month', () {
        final today = DateTime(2025, 1, 15, 10, 30, 45);
        final date = DateTime(2024, 12, 10);
        expect(datetimeToStringSort(date, today), '10/12');
      });

      test('should return full date when date is in different year', () {
        final today = DateTime(2025, 1, 15, 10, 30, 45);
        final date = DateTime(2024, 6, 10);
        expect(datetimeToStringSort(date, today), '10/06/2024');
      });

      test('should use DateTime.now() when no date provided', () {
        // This test uses real DateTime.now()
        final result = datetimeToStringSort(DateTime(2025, 1, 15));
        expect(result, isA<String>());
      });
    });
  });

  group('DartDateUtils', () {
    group('changeDate', () {
      test('should change date part of DateTime', () {
        final current = DateTime(2025, 1, 15, 10, 30, 45);
        final changeDate = DateTime(2024, 12, 25);
        final result = DartDateUtils.changeDate(current, changeDate);
        expect(result, DateTime(2024, 12, 25, 10, 30, 45));
      });

      test('should preserve time of original DateTime', () {
        final current = DateTime(2025, 1, 15, 14, 30, 45);
        final changeDate = DateTime(2024, 12, 25);
        final result = DartDateUtils.changeDate(current, changeDate);
        expect(result.hour, 14);
        expect(result.minute, 30);
        expect(result.second, 45);
      });
    });

    group('addDaysToDateTime', () {
      test('should add days to DateTime', () {
        final date = DateTime(2025, 1, 15);
        final result = DartDateUtils.addDaysToDateTime(date, 7);
        expect(result, DateTime(2025, 1, 22));
      });

      test('should handle negative days', () {
        final date = DateTime(2025, 1, 15);
        final result = DartDateUtils.addDaysToDateTime(date, -7);
        expect(result, DateTime(2025, 1, 8));
      });

      test('should preserve time', () {
        final date = DateTime(2025, 1, 15, 10, 30, 45);
        final result = DartDateUtils.addDaysToDateTime(date, 1);
        expect(result.hour, 10);
        expect(result.minute, 30);
        expect(result.second, 45);
      });
    });

    group('addHoursToDateTime', () {
      test('should add hours to DateTime', () {
        final date = DateTime(2025, 1, 15, 10, 30, 45);
        final result = DartDateUtils.addHoursToDateTime(date, 5);
        expect(result, DateTime(2025, 1, 15, 15, 30, 45));
      });

      test('should handle negative hours', () {
        final date = DateTime(2025, 1, 15, 10, 30, 45);
        final result = DartDateUtils.addHoursToDateTime(date, -5);
        expect(result, DateTime(2025, 1, 15, 5, 30, 45));
      });

      test('should preserve minutes and seconds', () {
        final date = DateTime(2025, 1, 15, 10, 30, 45);
        final result = DartDateUtils.addHoursToDateTime(date, 2);
        expect(result.minute, 30);
        expect(result.second, 45);
      });
    });

    group('addMinutesToDateTime', () {
      test('should add minutes to DateTime', () {
        final date = DateTime(2025, 1, 15, 10, 30, 0);
        final result = DartDateUtils.addMinutesToDateTime(date, 45);
        expect(result, DateTime(2025, 1, 15, 11, 15, 0));
      });

      test('should handle negative minutes', () {
        final date = DateTime(2025, 1, 15, 11, 15, 0);
        final result = DartDateUtils.addMinutesToDateTime(date, -30);
        expect(result, DateTime(2025, 1, 15, 10, 45, 0));
      });

      test('should preserve seconds', () {
        final date = DateTime(2025, 1, 15, 10, 30, 45);
        final result = DartDateUtils.addMinutesToDateTime(date, 15);
        expect(result.second, 45);
      });
    });
  });
}
