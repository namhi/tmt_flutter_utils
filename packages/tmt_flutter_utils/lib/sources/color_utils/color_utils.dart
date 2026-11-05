import 'package:flutter/material.dart';

class ColorUtils {
  ColorUtils._();
  static Color? fromHex(String hexString, [Color? defaultValue]) {
    try {
      final buffer = StringBuffer();
      var hex = hexString.replaceFirst('#', '');
      if (hex.length == 3) {
        // Expand short hex (#ABC) to its 6-digit form (ABCABC)
        hex = hex + hex;
      }
      if (hex.length == 6) buffer.write('ff');
      buffer.write(hex);
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return defaultValue;
    }
  }
}
