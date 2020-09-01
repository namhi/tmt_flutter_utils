import 'dart:convert';
import 'package:tmt_flutter_untils/sources/regex_pattern.dart';
import 'package:crypto/crypto.dart';
import 'package:diacritic/diacritic.dart';

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

  String removeVietnameseMark({bool toLower = false}) =>
      toLower ? removeDiacritics(this.toLowerCase()) : removeDiacritics(this);
}
