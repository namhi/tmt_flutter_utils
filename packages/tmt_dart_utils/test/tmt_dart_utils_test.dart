import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_extensions.dart';

void main() {
  group('String extensions', () {
    test('Return true value', () {
      const test = 'How many times';
      final result = test.toCamelCase();
      expect(result, 'howManyTimes');
    });
  });
}
