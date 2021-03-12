import 'dart:ui';

class ColorUtils {
  ColorUtils._();
  static Color? fromHex(String hexString, [Color? defaultValue]) {
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return defaultValue;
    }
  }
}
