import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_utils.dart';

void main() {
  group('DateTimeRangeType', () {
    test('should have correct enum values', () {
      expect(DateTimeRangeType.DAY.index, 0);
      expect(DateTimeRangeType.WEEK.index, 1);
      expect(DateTimeRangeType.MONTH.index, 2);
      expect(DateTimeRangeType.YEAR.index, 3);
    });

    test('should support all enum types', () {
      final types = DateTimeRangeType.values;
      expect(types, hasLength(4));
      expect(types, contains(DateTimeRangeType.DAY));
      expect(types, contains(DateTimeRangeType.WEEK));
      expect(types, contains(DateTimeRangeType.MONTH));
      expect(types, contains(DateTimeRangeType.YEAR));
    });

    test('should maintain order', () {
      final types = DateTimeRangeType.values;
      expect(types[0], DateTimeRangeType.DAY);
      expect(types[1], DateTimeRangeType.WEEK);
      expect(types[2], DateTimeRangeType.MONTH);
      expect(types[3], DateTimeRangeType.YEAR);
    });
  });
}
