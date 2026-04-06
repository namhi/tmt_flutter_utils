import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:tmt_flutter_utils/tmt_flutter_utils.dart';

void main() {
  group('FlutterDateUtils', () {
    group('changeTime', () {
      test('should change time of DateTime with TimeOfDay', () {
        final date = DateTime(2025, 1, 15, 10, 30, 45);
        final timeOfDay = const TimeOfDay(hour: 14, minute: 30);

        final result = FlutterDateUtils.changeTime(date, timeOfDay);

        expect(result.year, 2025);
        expect(result.month, 1);
        expect(result.day, 15);
        expect(result.hour, 14);
        expect(result.minute, 30);
        expect(result.second, 0);
        expect(result.millisecond, 0);
      });

      test('should handle midnight time', () {
        final date = DateTime(2025, 1, 15, 10, 30, 45);
        const timeOfDay = TimeOfDay(hour: 0, minute: 0);

        final result = FlutterDateUtils.changeTime(date, timeOfDay);

        expect(result.hour, 0);
        expect(result.minute, 0);
        expect(result.second, 0);
      });

      test('should handle end of day time', () {
        final date = DateTime(2025, 1, 15, 10, 30, 45);
        const timeOfDay = TimeOfDay(hour: 23, minute: 59);

        final result = FlutterDateUtils.changeTime(date, timeOfDay);

        expect(result.hour, 23);
        expect(result.minute, 59);
      });

      test('should preserve date components', () {
        final date = DateTime(2025, 12, 31, 10, 30, 45);
        const timeOfDay = TimeOfDay(hour: 5, minute: 15);

        final result = FlutterDateUtils.changeTime(date, timeOfDay);

        expect(result.year, 2025);
        expect(result.month, 12);
        expect(result.day, 31);
      });

      test('should reset seconds and milliseconds to zero', () {
        final date = DateTime(2025, 1, 15, 10, 30, 45, 123, 456);
        const timeOfDay = TimeOfDay(hour: 12, minute: 0);

        final result = FlutterDateUtils.changeTime(date, timeOfDay);

        expect(result.second, 0);
        expect(result.millisecond, 0);
      });

      test('should handle leap year date', () {
        final date = DateTime(2024, 2, 29, 10, 30, 45);
        const timeOfDay = TimeOfDay(hour: 15, minute: 45);

        final result = FlutterDateUtils.changeTime(date, timeOfDay);

        expect(result.year, 2024);
        expect(result.month, 2);
        expect(result.day, 29);
        expect(result.hour, 15);
        expect(result.minute, 45);
      });
    });
  });
}
