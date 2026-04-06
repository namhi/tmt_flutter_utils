import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_extensions.dart';
import 'package:tmt_dart_utils/src/enum/enum_until.dart';

enum TestEnum { value1, value2, value3 }
enum ComplexEnum { first_value, second_value }

void main() {
  group('convertEnumToString', () {
    test('should convert enum to string without type prefix', () {
      expect(convertEnumToString(TestEnum.value1), 'value1');
      expect(convertEnumToString(TestEnum.value2), 'value2');
      expect(convertEnumToString(TestEnum.value3), 'value3');
    });

    test('should handle different enum types', () {
      expect(convertEnumToString(TestEnum.value1), 'value1');
    });

    test('should handle enum with underscores', () {
      expect(convertEnumToString(ComplexEnum.first_value), 'first_value');
      expect(convertEnumToString(ComplexEnum.second_value), 'second_value');
    });
  });
}
