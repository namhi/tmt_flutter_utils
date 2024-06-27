import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_extensions.dart';

void main() {
  group('String extensions', () {
    test('Test toCamelCase true', () {
      const test = 'How many times';
      final result = test.toCamelCase();
      expect(result, 'howManyTimes');
    });

    test('Test toCamelCase true', () {
      const test = 'How_many     times version  _2';
      final result = test.toCamelCase();
      expect(result, 'howManyTimesVersion2');
    });

    test('Test toCamelCase true', () {
      const test = 'How_many times version  _2';
      final result = test.toCamelCase();
      expect(result != 'howmanyTimesVersion2', true);
    });

    test('Test toUpperCamelCase true', () {
      const test = 'How_many times version  _2';
      final result = test.toUpperCamelCase();
      expect(result, 'HowManyTimesVersion2');
    });

    test('Test toUpperCamelCase failure', () {
      const test = 'How_many  times      version   _2';
      final result = test.toUpperCamelCase();
      expect(result != 'HowmanyTimesVersion2', true);
    });

    test('Test toLowerUnderscore true', () {
      const test = 'How  _many times   version  _2';
      final result = test.toLowerUnderscore();
      expect(result, 'how_many_times_version_2');
    });

    test('Test toLowerUnderscore failure', () {
      const test = 'How_many  times      version   _2';
      final result = test.toLowerUnderscore();
      expect(result != 'How_many_times_version_2', true);
    });

    test('Hide Number', () {
      const test = '0901000123';
      final result = test.hideNumber(start: 7, replacement: '***');
      expect(result == '0901000***', true);
    });
  });
}
