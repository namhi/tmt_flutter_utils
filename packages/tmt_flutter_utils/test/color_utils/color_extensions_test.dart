import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tmt_flutter_utils/tmt_flutter_utils.dart';

void main() {
  group('ColorExtensions', () {
    group('textColor', () {
      test('should return white for dark colors', () {
        expect(const Color(0xFF000000).textColor(), const Color(0xFFFFFFFF));
        expect(const Color(0xFF0000FF).textColor(), const Color(0xFFFFFFFF));
        expect(const Color(0xFF00FF00).textColor(), const Color(0xFFFFFFFF));
        expect(const Color(0xFFFF0000).textColor(), const Color(0xFFFFFFFF));
      });

      test('should return black for bright colors', () {
        expect(const Color(0xFFFFFFFF).textColor(), const Color(0xFF323232));
        expect(const Color(0xFFFFFF00).textColor(), const Color(0xFF323232));
        expect(const Color(0xFF00FFFF).textColor(), const Color(0xFF323232));
        expect(const Color(0xFFFF00FF).textColor(), const Color(0xFF323232));
      });

      test('should return black for light gray', () {
        expect(const Color(0xFF808080).textColor(), const Color(0xFF323232));
        expect(const Color(0xFFAAAAAA).textColor(), const Color(0xFF323232));
      });

      test('should return white for dark gray', () {
        expect(const Color(0xFF404040).textColor(), const Color(0xFFFFFFFF));
        expect(const Color(0xFF202020).textColor(), const Color(0xFFFFFFFF));
      });

      test('should preserve alpha value', () {
        const semiTransparentRed = Color(0x80FF0000);
        final result = semiTransparentRed.textColor();

        expect(result.alpha, 0x80);
        expect(result.red, 0xFF);
        expect(result.green, 0xFF);
        expect(result.blue, 0xFF);
      });

      test('should handle medium brightness colors', () {
        // Medium brightness where luminance is close to 0.5
        const mediumColor = Color(0xFF808080); // Gray with luminance ~0.5
        final result = mediumColor.textColor();

        // Should return black since luminance = 0.5, not > 0.5
        expect(result, const Color(0xFF323232));
      });

      test('should return consistent result for same color', () {
        const color = Color(0xFF123456);
        final result1 = color.textColor();
        final result2 = color.textColor();

        expect(result1, result2);
      });
    });
  });
}
