import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:tmt_flutter_utils/tmt_flutter_utils.dart';

void main() {
  group('ColorUtils', () {
    group('fromHex', () {
      test('should parse valid hex color', () {
        expect(ColorUtils.fromHex('#FF0000'), const Color(0xFFFF0000));
        expect(ColorUtils.fromHex('FF0000'), const Color(0xFF000000));
        expect(ColorUtils.fromHex('000000'), const Color(0xFF000000));
        expect(ColorUtils.fromHex('#ABC123'), const Color(0xFFABC123));
      });

      test('should return default value for invalid hex', () {
        expect(ColorUtils.fromHex('invalid', null), isNull);
        expect(ColorUtils.fromHex('xyz', const Color(0xFF000000)), isNull);
        expect(ColorUtils.fromHex('#GGGGGG', const Color(0xFF000000)), isNull);
      });

      test('should return custom default value when specified', () {
        expect(ColorUtils.fromHex('invalid', const Color(0xFF123456)), const Color(0xFF123456));
      });

      test('should handle various hex formats', () {
        expect(ColorUtils.fromHex('#ABC'), const Color(0xFFABCABC));
        expect(ColorUtils.fromHex('ABCDEF'), const Color(0xFFABCDEF));
        expect(ColorUtils.fromHex('#123456'), const Color(0xFF123456));
      });

      test('should handle short hex codes', () {
        expect(ColorUtils.fromHex('ABC', const Color(0xFFABCABC));
        expect(ColorUtils.fromHex('123', const Color(0xFF123123));
      });
    });
  });
}
