import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_utils.dart';

void main() {
  group('ListUtils', () {
    group('sumBy', () {
      test('should sum numeric values from list', () {
        final items = [
          {'value': 10},
          {'value': 20},
          {'value': 30}
        ];
        expect(ListUtils.sumBy(items, (item) => item['value'] as num), 60);
      });

      test('should handle empty list', () {
        expect(ListUtils.sumBy([], (item) => 0), 0);
      });

      test('should handle single element', () {
        final items = [{'value': 42}];
        expect(ListUtils.sumBy(items, (item) => item['value'] as num), 42);
      });

      test('should handle negative numbers', () {
        final items = [10, -20, 30];
        expect(ListUtils.sumBy(items, (item) => item), 20);
      });

      test('should handle double values', () {
        final items = [1.5, 2.5, 3.0];
        expect(ListUtils.sumBy(items, (item) => item), 7.0);
      });
    });

    group('sumByInt', () {
      test('should sum int values from list', () {
        final items = [
          {'value': 10},
          {'value': 20},
          {'value': 30}
        ];
        expect(ListUtils.sumByInt(items, (item) => item['value'] as int), 60);
      });

      test('should handle empty list', () {
        expect(ListUtils.sumByInt([], (item) => 0), 0);
      });

      test('should handle negative numbers', () {
        final items = [10, -20, 30];
        expect(ListUtils.sumByInt(items, (item) => item), 20);
      });
    });

    group('quickSort', () {
      test('should sort list of numbers', () {
        final unsorted = [5, 2, 8, 1, 9];
        final sorted = ListUtils.quickSort(unsorted);
        expect(sorted, [1, 2, 5, 8, 9]);
      });

      test('should sort list of strings', () {
        final unsorted = ['banana', 'apple', 'cherry'];
        final sorted = ListUtils.quickSort(unsorted);
        expect(sorted, ['apple', 'banana', 'cherry']);
      });

      test('should handle empty list', () {
        final unsorted = <int>[];
        final sorted = ListUtils.quickSort(unsorted);
        expect(sorted, []);
      });

      test('should handle single element', () {
        final unsorted = [42];
        final sorted = ListUtils.quickSort(unsorted);
        expect(sorted, [42]);
      });

      test('should handle already sorted list', () {
        final unsorted = [1, 2, 3, 4, 5];
        final sorted = ListUtils.quickSort(unsorted);
        expect(sorted, [1, 2, 3, 4, 5]);
      });

      test('should handle reverse sorted list', () {
        final unsorted = [5, 4, 3, 2, 1];
        final sorted = ListUtils.quickSort(unsorted);
        expect(sorted, [1, 2, 3, 4, 5]);
      });

      test('should handle duplicates', () {
        final unsorted = [3, 1, 2, 1, 3];
        final sorted = ListUtils.quickSort(unsorted);
        expect(sorted, [1, 1, 2, 3, 3]);
      });
    });

    group('bubbleSort', () {
      test('should sort list of numbers', () {
        final unsorted = [5, 2, 8, 1, 9];
        final sorted = ListUtils.bubbleSort(unsorted);
        expect(sorted, [1, 2, 5, 8, 9]);
      });

      test('should handle empty list', () {
        final unsorted = <int>[];
        final sorted = ListUtils.bubbleSort(unsorted);
        expect(sorted, []);
      });

      test('should handle single element', () {
        final unsorted = [42];
        final sorted = ListUtils.bubbleSort(unsorted);
        expect(sorted, [42]);
      });

      test('should not modify original list', () {
        final unsorted = [3, 1, 2];
        final original = List.from(unsorted);
        ListUtils.bubbleSort(unsorted);
        expect(unsorted, original); // Original should be unchanged
      });
    });

    group('heapSort', () {
      test('should sort list of numbers', () {
        final unsorted = [5, 2, 8, 1, 9];
        final sorted = ListUtils.heapSort(unsorted);
        expect(sorted, [1, 2, 5, 8, 9]);
      });

      test('should handle empty list', () {
        final unsorted = <int>[];
        final sorted = ListUtils.heapSort(unsorted);
        expect(sorted, []);
      });

      test('should handle single element', () {
        final unsorted = [42];
        final sorted = ListUtils.heapSort(unsorted);
        expect(sorted, [42]);
      });

      test('should modify original list', () {
        final unsorted = [3, 1, 2];
        ListUtils.heapSort(unsorted);
        expect(unsorted, [1, 2, 3]); // Original is modified
      });
    });

    group('getLengthOrDefault', () {
      test('should return length when list is not null', () {
        final list = [1, 2, 3, 4, 5];
        expect(ListUtils.getLengthOrDefault(list), 5);
      });

      test('should return default value when list is null', () {
        expect(ListUtils.getLengthOrDefault(null), 0);
      });

      test('should return custom default value when list is null', () {
        expect(ListUtils.getLengthOrDefault(null, 99), 99);
      });

      test('should return zero for empty list', () {
        final list = <int>[];
        expect(ListUtils.getLengthOrDefault(list), 0);
      });

      test('should work with list of strings', () {
        final list = ['a', 'b', 'c'];
        expect(ListUtils.getLengthOrDefault(list), 3);
      });
    });
  });
}
