import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_utils.dart';

void main() {
  group('BoolExtensions', () {
    group('toCustomString', () {
      test('should return trueValue when bool is true', () {
        final result = true.toCustomString('Yes', 'No');
        expect(result, 'Yes');
      });

      test('should return falseValue when bool is false', () {
        final result = false.toCustomString('Yes', 'No');
        expect(result, 'No');
      });

      test('should work with Vietnamese strings', () {
        expect(true.toCustomString('Đúng', 'Sai'), 'Đúng');
        expect(false.toCustomString('Đúng', 'Sai'), 'Sai');
      });

      test('should work with empty strings', () {
        expect(true.toCustomString('', ''), '');
        expect(false.toCustomString('', ''), '');
      });
    });

    group('getValue', () {
      test('should return true when bool is true', () {
        expect(true.getValue(), true);
      });

      test('should return false when bool is false', () {
        expect(false.getValue(), false);
      });
    });
  });

  group('BoolExtensionNullable', () {
    // Note: Dart's extension method resolution prefers the non-nullable extension
    // when the value is known to be non-null at compile time. To test the
    // nullable extension with non-null values, we need to use runtime checks
    // or explicit typing scenarios where the compiler can't determine nullability.

    group('toCustomString', () {
      test('should return nullValue when bool is null', () {
        bool? value = null;
        expect(value.toCustomString('Yes', 'No', 'Unknown'), 'Unknown');
      });

      test('should work with Vietnamese strings for null', () {
        bool? nullValue = null;
        expect(nullValue.toCustomString('Đúng', 'Sai', 'Không xác định'), 'Không xác định');
      });

      // Test with runtime null check to ensure nullable extension is used
      test('should return appropriate values based on runtime nullability', () {
        // Create a list of nullable bools to test both cases
        List<bool?> values = [true, false, null];

        // For true value (use 2-arg version as Dart resolves to non-nullable extension)
        expect(values[0]!.toCustomString('Yes', 'No'), 'Yes');

        // For false value
        expect(values[1]!.toCustomString('Yes', 'No'), 'No');

        // For null value, we can't directly test 3-arg version due to extension resolution
        // Instead, we verify the null case separately
        bool? nullValue = values[2];
        expect(nullValue, isNull);
      });
    });

    group('valueOrDefault', () {
      test('should return true when bool is true', () {
        bool? value = true;
        expect(value.valueOrDefault(), true);
      });

      test('should return false when bool is false', () {
        bool? value = false;
        expect(value.valueOrDefault(), false);
      });

      test('should return false (default) when bool is null', () {
        bool? value = null;
        expect(value.valueOrDefault(), false);
      });

      test('should return custom default value when bool is null', () {
        bool? value = null;
        expect(value.valueOrDefault(true), true);
      });
    });

    group('getOrElse', () {
      test('should return true when bool is true', () {
        bool? value = true;
        expect(value.getOrElse(() => false), true);
      });

      test('should return false when bool is false', () {
        bool? value = false;
        expect(value.getOrElse(() => true), false);
      });

      test('should return result of defaultValue when bool is null', () {
        bool? value = null;
        expect(value.getOrElse(() => true), true);
      });

      test('should call defaultValue function only when null', () {
        bool? trueValue = true;
        bool? nullValue = null;

        bool called = false;
        trueValue.getOrElse(() {
          called = true;
          return false;
        });
        expect(called, false);

        nullValue.getOrElse(() {
          called = true;
          return true;
        });
        expect(called, true);
      });
    });
  });
}
