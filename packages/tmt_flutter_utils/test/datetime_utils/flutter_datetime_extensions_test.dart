import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:tmt_flutter_utils/tmt_flutter_utils.dart';

void main() {
  group('FlutterDateTimeExtensions', () {
    group('changeTime', () {
      test('should change time of DateTime with TimeOfDay', () {
        final date = DateTime(2025, 1, 15, 10, 30, 45);
        const timeOfDay = TimeOfDay(hour: 14, minute: 30);

        final result = date.changeTime(timeOfDay);

        expect(result.year, 2025);
        expect(result.month, 1);
        expect(result.day, 15);
        expect(result.hour, 14);
        expect(result.minute, 30);
        expect(result.second, 0);
      });
    });

    group('addDaysToDate', () {
      test('should add days to date and set time to midnight', () {
        final date = DateTime(2025, 1, 15, 10, 30, 45);

        final result = date.addDaysToDate(7);

        expect(result, DateTime(2025, 1, 22, 0, 0, 0));
      });

      test('should handle negative days', () {
        final date = DateTime(2025, 1, 15, 10, 30, 45);

        final result = date.addDaysToDate(-7);

        expect(result, DateTime(2025, 1, 8, 0, 0, 0));
      });

      test('should handle month boundaries', () {
        final date = DateTime(2025, 1, 30, 10, 30, 45);

        final result = date.addDaysToDate(2);

        expect(result, DateTime(2025, 2, 1, 0, 0, 0));
      });

      test('should handle year boundaries', () {
        final date = DateTime(2025, 12, 31, 10, 30, 45);

        final result = date.addDaysToDate(1);

        expect(result, DateTime(2026, 1, 1, 0, 0, 0));
      });
    });

    group('isSameDayWith', () {
      test('should return true for same day', () {
        final date1 = DateTime(2025, 1, 15, 10, 30, 45);
        final date2 = DateTime(2025, 1, 15, 15, 20, 30);

        expect(date1.isSameDayWith(date2), true);
      });

      test('should return false for different days', () {
        final date1 = DateTime(2025, 1, 15);
        final date2 = DateTime(2025, 1, 16);

        expect(date1.isSameDayWith(date2), false);
      });

      test('should return false for different months', () {
        final date1 = DateTime(2025, 1, 15);
        final date2 = DateTime(2025, 2, 15);

        expect(date1.isSameDayWith(date2), false);
      });

      test('should return false for different years', () {
        final date1 = DateTime(2025, 1, 15);
        final date2 = DateTime(2024, 1, 15);

        expect(date1.isSameDayWith(date2), false);
      });

      test('should return true for same day at midnight', () {
        final date1 = DateTime(2025, 1, 15, 0, 0, 0);
        final date2 = DateTime(2025, 1, 15, 23, 59, 59);

        expect(date1.isSameDayWith(date2), true);
      });
    });

    group('isSameMonthWith', () {
      test('should return true for same month', () {
        final date1 = DateTime(2025, 1, 15);
        final date2 = DateTime(2025, 1, 20);

        expect(date1.isSameMonthWith(date2), true);
      });

      test('should return false for different months', () {
        final date1 = DateTime(2025, 1, 15);
        final date2 = DateTime(2025, 2, 15);

        expect(date1.isSameMonthWith(date2), false);
      });

      test('should return false for different years', () {
        final date1 = DateTime(2025, 1, 15);
        final date2 = DateTime(2024, 1, 15);

        expect(date1.isSameMonthWith(date2), false);
      });

      test('should return true for same month and year', () {
        final date1 = DateTime(2025, 1, 1);
        final date2 = DateTime(2025, 1, 31);

        expect(date1.isSameMonthWith(date2), true);
      });

      test('should return true for December of same year', () {
        final date1 = DateTime(2025, 12, 1);
        final date2 = DateTime(2025, 12, 31);

        expect(date1.isSameMonthWith(date2), true);
      });
    });
  });
}
