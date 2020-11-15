/*
 * *
 *  * Created by NamNV, Công ty TNHH TM& DV Trực Tuyến Trường Minh Thịnh on 4/9/19 9:59 AM
 *  * Copyright (c) 2020 . All rights reserved.
 *  * Last modified 4/9/19 9:53 AM
 *
 */

import 'dart:convert';
import 'dart:ui' as ui;
import 'package:tmt_flutter_untils/sources/regex_pattern.dart';
import 'package:crypto/crypto.dart';
import 'package:diacritic/diacritic.dart' as diacritic;
import 'package:tmt_flutter_untils/sources/string_utils/string_utils.dart';

extension StringExtensions on String {
  bool isBool() => StringUtils.isBool(this);
  bool isNull() => StringUtils.isNull(this);
  bool isNumber() => StringUtils.isNumber(this);
  bool isInt() => StringUtils.isInt(this);
  bool isDouble() => StringUtils.isDouble(this);
  bool isNumericOnly() => StringUtils.isNumericOnly(this);
  bool isLowerCase() => StringUtils.isLowerCase(this);
  bool isUpperCase() => StringUtils.isUpperCase(this);
  bool isAscii() => StringUtils.isAscii(this);

  bool isNotNullOrEmpty() => this != null && this.isNotEmpty;
  bool isNullOrEmpty() => this == null || this.isEmpty;
  bool isEmail() => RegExp(emailPattern).hasMatch(this);
  bool isUrl() => RegExp(urlPattern).hasMatch(this);
  bool isPhoneNumber() => RegExp(phoneNumberPattern).hasMatch(this);
  bool isBase64() => RegExp(base64Pattern).hasMatch(this);

  T toEnum<T>(Iterable<T> values) {
    return values.firstWhere((f) => f.toString().split('.').last == this,
        orElse: () => null);
  }

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

  String removeVietnameseMark({bool toLower = false}) => toLower
      ? diacritic.removeDiacritics(this.toLowerCase())
      : diacritic.removeDiacritics(this);

  String removeDiacritics([bool toLower = false]) {
    String key = toLower ? this.toLowerCase() : this;
    return diacritic.removeDiacritics(key);
  }

  ui.Color toColor() {
    return ui.Color(int.parse(this));
  }

  List<String> chunk(int chunkSize) {
    return StringUtils.chunk(this, chunkSize);
  }

  String hideNumber({int start, int end, String replacement}) {
    return StringUtils.hideNumber(
      this,
      start: start,
      end: end,
      replacement: replacement,
    );
  }

  String trimUnicode(int startAt, [String prefix = '...']) =>
      StringUtils.trimUnicode(this, startAt, prefix);

  String extractPhoneNumber([Map<String, String> replace = const {"o": "0"}]) =>
      StringUtils.extractPhoneNumber(this, replace);

  dynamic parseJson({Object reviver(Object key, Object value)}) {
    return jsonDecode(this, reviver: reviver);
  }

  int toInt({int radix = 10}) {
    try {
      return int.parse(this, radix: radix);
    } catch (e) {
      return null;
    }
  }

  double toDouble() {
    try {
      return double.parse(this);
    } catch (error) {
      return null;
    }
  }
}
