import 'dart:convert';
import 'dart:ui' as ui;
import 'package:tmt_flutter_untils/sources/datetime_utils/datetime_until.dart';
import 'package:tmt_flutter_untils/sources/regex_pattern.dart';
import 'package:crypto/crypto.dart';
import 'package:diacritic/diacritic.dart';
import 'package:tmt_flutter_untils/sources/string_utils/string_utils.dart';

extension StringExtensions on String {
  bool isNullOrEmpty() {
    return (this == null || this.isEmpty);
  }

  bool isNotNullOrEmpty() {
    return (this != null && this.isNotEmpty);
  }

  T toEnum<T>(Iterable<T> values) {
    return values.firstWhere((f) => f.toString().split('.').last == this,
        orElse: () => null);
  }

  bool isEmail() {
    return RegExp(emailPattern).hasMatch(this);
  }

  bool isUrl() => RegExp(urlPattern).hasMatch(this);

  bool isPhoneNumber() => RegExp(phonePattern).hasMatch(this);
  bool isBase64() => RegExp(base64Pattern).hasMatch(this);
  String encryptMd5() => md5.convert(utf8.encode(this)).toString();
  String encodeToBase64() {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.encode(this);
  }

  String decodeFromBase64() {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.decode(this);
  }

  String validate(bool Function(String) condition, String message) {
    if (condition(this)) {
      return null;
    }
    return message;
  }

  DateTime toDateTime() => DateTime.parse(this);

  String removeVietnameseMark({bool toLower = false}) =>
      toLower ? removeDiacritics(this.toLowerCase()) : removeDiacritics(this);

  ui.Color toColor() {
    return ui.Color(int.parse(this));
  }

  bool isLowerCase() {
    return StringUtils.isLowerCase(this);
  }

  bool isUpperCase() {
    return StringUtils.isUpperCase(this);
  }

  bool isAscii() {
    return StringUtils.isAscii(this);
  }

  List<String> chunk(int chunkSize) {
    return StringUtils.chunk(this, chunkSize);
  }

  String hideNumber(String number, {int start, int end, String replacement}) {
    return StringUtils.hideNumber(
      number,
      start: start,
      end: end,
      replacement: replacement,
    );
  }
}
