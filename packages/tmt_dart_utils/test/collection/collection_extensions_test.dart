import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_extensions.dart';

void main() {
  group('CollectionExtensions', () {
    group('replace', () {
      test('should replace item at specified index', () {
        final list = [1, 2, 3, 4, 5];
        list.replace(10, 2);
        expect(list, [1, 2, 10, 4, 5]);
      });

      test('should remove old item when replacing', () {
        final list = ['a', 'b', 'c', 'd'];
        list.replace('x', 1);
        expect(list, ['a', 'x', 'c', 'd']);
        expect(list, hasLength(4));
      });

      test('should throw when index is out of bounds', () {
        final list = [1, 2, 3];
        expect(() => list.replace(99, 5), throwsA(isA<String>()));
      });

      test('should throw when index equals length', () {
        final list = [1, 2, 3];
        expect(() => list.replace(99, 3), throwsA(isA<String>()));
      });

      test('should handle replacing first element', () {
        final list = [1, 2, 3];
        list.replace(99, 0);
        expect(list, [99, 2, 3]);
      });

      test('should handle replacing last element', () {
        final list = [1, 2, 3];
        list.replace(99, 2);
        expect(list, [1, 2, 99]);
      });

      test('should handle replacing with same value', () {
        final list = [1, 2, 3];
        list.replace(2, 1);
        expect(list, [1, 2, 3]);
      });
    });
  });

  group('IterableExtension', () {
    group('sumBy', () {
      test('should sum values from iterable', () {
        final items = [1, 2, 3, 4, 5];
        expect(items.sumBy((item) => item), 15);
      });

      test('should work with custom transformation', () {
        final items = [1, 2, 3];
        expect(items.sumBy((item) => item * 2), 12);
      });

      test('should handle empty iterable', () {
        final items = <int>[];
        expect(items.sumBy((item) => item), 0);
      });

      test('should work with double values', () {
        final items = [1.5, 2.5, 3.0];
        expect(items.sumBy((item) => item), 7.0);
      });
    });

    group('sumByInt', () {
      test('should sum int values from iterable', () {
        final items = [1, 2, 3, 4, 5];
        expect(items.sumByInt((item) => item), 15);
      });

      test('should handle empty iterable', () {
        final items = <int>[];
        expect(items.sumByInt((item) => item), 0);
      });

      test('should handle negative numbers', () {
        final items = [10, -20, 30];
        expect(items.sumByInt((item) => item), 20);
      });
    });

    group('lengthOrDefault', () {
      test('should return length of non-null iterable', () {
        final items = [1, 2, 3, 4, 5];
        expect(items.lengthOrDefault(), 5);
      });

      test('should return 0 for empty iterable', () {
        final items = <int>[];
        expect(items.lengthOrDefault(), 0);
      });
    });
  });

  group('IterableNullExtension', () {
    group('lengthOrDefault', () {
      test('should return length of non-null iterable', () {
        List<int>? items = [1, 2, 3];
        expect(items.lengthOrDefault(), 3);
      });

      test('should return default value for null iterable', () {
        List<int>? items = null;
        expect(items.lengthOrDefault(), 0);
      });

      test('should return custom default value', () {
        List<int>? items = null;
        expect(items.lengthOrDefault(99), 99);
      });

      test('should return custom default value for empty iterable', () {
        List<int>? items = [];
        expect(items.lengthOrDefault(5), 0);
      });
    });
  });
}
