import 'dart:ui' as ui;
import 'package:flutter_test/flutter_test.dart';
import 'package:tmt_flutter_utils/tmt_flutter_utils.dart';

void main() {
  group('FlutterStringUtils', () {
    group('hasOnlyEmojis', () {
      test('should return true for single emoji', () {
        expect(FlutterStringUtils.hasOnlyEmojis('😀'), true);
        expect(FlutterStringUtils.hasOnlyEmojis('🎉'), true);
        expect(FlutterStringUtils.hasOnlyEmojis('❤️'), true);
      });

      test('should return true for multiple emojis', () {
        expect(FlutterStringUtils.hasOnlyEmojis('😀🎉❤️'), true);
        expect(FlutterStringUtils.hasOnlyEmojis('👍👏🙌'), true);
      });

      test('should return false for text mixed with emojis', () {
        expect(FlutterStringUtils.hasOnlyEmojis('Hello😀'), false);
        expect(FlutterStringUtils.hasOnlyEmojis('🎉Test'), false);
        expect(FlutterStringUtils.hasOnlyEmojis('A🎉B'), false);
      });

      test('should return false for plain text', () {
        expect(FlutterStringUtils.hasOnlyEmojis('Hello'), false);
        expect(FlutterStringUtils.hasOnlyEmojis('123'), false);
        expect(FlutterStringUtils.hasOnlyEmojis('ABC'), false);
      });

      test('should return true for emojis with whitespace when ignoreWhitespace is true', () {
        expect(FlutterStringUtils.hasOnlyEmojis('😀 🎉', ignoreWhitespace: true), true);
        expect(FlutterStringUtils.hasOnlyEmojis('👍 👏', ignoreWhitespace: true), true);
      });

      test('should return false for emojis with whitespace when ignoreWhitespace is false', () {
        expect(FlutterStringUtils.hasOnlyEmojis('😀 🎉', ignoreWhitespace: false), false);
      });

      test('should handle empty string', () {
        expect(FlutterStringUtils.hasOnlyEmojis(''), true);
        expect(FlutterStringUtils.hasOnlyEmojis('', ignoreWhitespace: true), true);
      });

      test('should handle whitespace only when ignoreWhitespace is true', () {
        expect(FlutterStringUtils.hasOnlyEmojis('   ', ignoreWhitespace: true), true);
      });

      test('should handle whitespace only when ignoreWhitespace is false', () {
        expect(FlutterStringUtils.hasOnlyEmojis('   ', ignoreWhitespace: false), true);
      });

      test('should return false for numbers', () {
        expect(FlutterStringUtils.hasOnlyEmojis('123'), false);
      });

      test('should return false for special characters', () {
        expect(FlutterStringUtils.hasOnlyEmojis('!@#'), false);
      });

      test('should handle complex emoji sequences', () {
        expect(FlutterStringUtils.hasOnlyEmojis('👨‍👩‍👧‍👦'), true); // Family emoji
        expect(FlutterStringUtils.hasOnlyEmojis('🏳️‍🌈'), true); // Rainbow flag
      });
    });
  });

  group('ToColorStringEx', () {
    group('toColor', () {
      test('should parse valid hex string to Color', () {
        expect('0xFFFF0000'.toColor(), const ui.Color(0xFFFF0000));
        expect('0xFF0000FF'.toColor(), const ui.Color(0xFF0000FF));
        expect('0xFF00FF00'.toColor(), const ui.Color(0xFF00FF00));
      });

      test('should handle ARGB format', () {
        expect('0x80FF0000'.toColor(), const ui.Color(0x80FF0000));
        expect('0x00000000'.toColor(), const ui.Color(0x00000000));
        expect('0xFFFFFFFF'.toColor(), const ui.Color(0xFFFFFFFF));
      });

      test('should handle different color values', () {
        expect('0xFF123456'.toColor(), const ui.Color(0xFF123456));
        expect('0xFFABCDEF'.toColor(), const ui.Color(0xFFABCDEF));
      });
    });
  });

  group('IntColorEx', () {
    group('toColor', () {
      test('should convert int to Color', () {
        expect(0xFFFF0000.toColor(), const ui.Color(0xFFFF0000));
        expect(0xFF0000FF.toColor(), const ui.Color(0xFF0000FF));
        expect(0xFF00FF00.toColor(), const ui.Color(0xFF00FF00));
      });

      test('should handle ARGB values', () {
        expect(0x80FF0000.toColor(), const ui.Color(0x80FF0000));
        expect(0x00000000.toColor(), const ui.Color(0x00000000));
        expect(0xFFFFFFFF.toColor(), const ui.Color(0xFFFFFFFF));
      });

      test('should handle different color values', () {
        expect(0xFF123456.toColor(), const ui.Color(0xFF123456));
        expect(0xFFABCDEF.toColor(), const ui.Color(0xFFABCDEF));
      });

      test('should handle zero value', () {
        expect(0x0.toColor(), const ui.Color(0x00000000));
      });
    });
  });
}
