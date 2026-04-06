import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_extensions.dart';

// Custom class for testing
class CustomObject {
  final String name;
  CustomObject(this.name);
}

void main() {
  group('ObjectExtensions', () {
    group('isNull', () {
      test('should return true when object is null', () {
        Object? value = null;
        expect(value.isNull, true);
      });

      test('should return false when object is not null', () {
        const Object value = 'test';
        expect(value.isNull, false);
      });

      test('should work with various non-null types', () {
        expect(('string' as Object?).isNull, false);
        expect((42 as Object?).isNull, false);
        expect((3.14 as Object?).isNull, false);
        expect((true as Object?).isNull, false);
        expect(([1, 2, 3] as Object?).isNull, false);
        expect(({'key': 'value'} as Object?).isNull, false);
      });

      test('should work with nullable types', () {
        String? nullableString = 'test';
        expect((nullableString as Object?).isNull, false);

        nullableString = null;
        expect((nullableString as Object?).isNull, true);
      });

      test('should work with int?', () {
        int? nullableInt = 42;
        expect((nullableInt as Object?).isNull, false);

        nullableInt = null;
        expect((nullableInt as Object?).isNull, true);
      });

      test('should work with double?', () {
        double? nullableDouble = 3.14;
        expect((nullableDouble as Object?).isNull, false);

        nullableDouble = null;
        expect((nullableDouble as Object?).isNull, true);
      });

      test('should work with bool?', () {
        bool? nullableBool = true;
        expect((nullableBool as Object?).isNull, false);

        nullableBool = null;
        expect((nullableBool as Object?).isNull, true);
      });

      test('should work with List?', () {
        List? nullableList = [1, 2, 3];
        expect((nullableList as Object?).isNull, false);

        nullableList = null;
        expect((nullableList as Object?).isNull, true);
      });

      test('should work with empty collections', () {
        expect(<String>[].isNull, false);
        expect(<String, int>{}.isNull, false);
      });

      test('should work with zero values', () {
        expect((0 as Object?).isNull, false);
        expect((0.0 as Object?).isNull, false);
        expect((false as Object?).isNull, false);
      });

      test('should work with custom objects', () {
        final customObject = CustomObject('test');
        expect(customObject.isNull, false);

        CustomObject? nullableCustomObject = null;
        expect(nullableCustomObject.isNull, true);
      });
    });
  });
}
