/*
 * *
 *  * Created by NamNV, Công ty TNHH TM& DV Trực Tuyến Trường Minh Thịnh on 4/9/19 9:59 AM
 *  * Copyright (c) 2020 . All rights reserved.
 *  * Last modified 4/9/19 9:53 AM
 *
 */

import 'dart:convert';
import 'dart:ui' as ui;
import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:tmt_flutter_untils/sources/regex_pattern.dart';
import 'package:crypto/crypto.dart';
import 'package:diacritic/diacritic.dart' as diacritic;
import 'package:tmt_flutter_untils/sources/string_utils/string_utils.dart';

import '../constant.dart';

extension StringNullExtensionsEx on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => this != null && this != '';
  bool isNull() => StringUtils.isNull(this);
  String valueIfNullOrEmpty(String nullValue) =>
      StringUtils.stringIfNullOrEmpty(this, nullValue);
}

extension StringExtensions on String {
  bool isBool() => StringUtils.isBool(this);

  bool isNumber() => StringUtils.isNumber(this);
  bool isInt() => StringUtils.isInt(this);
  bool isDouble() => StringUtils.isDouble(this);
  bool isNumericOnly() => StringUtils.isNumericOnly(this);
  bool isLowerCase() => StringUtils.isLowerCase(this);
  bool isUpperCase() => StringUtils.isUpperCase(this);
  bool isAscii() => StringUtils.isAscii(this);
  bool isEmail() => RegExp(emailPattern).hasMatch(this);
  bool isUrl() => RegExp(urlPattern).hasMatch(this);

  /// Extract first email from string.
  /// Return null value if string not has an email.
  /// Throw a exception if the input string is null.
  String? extractEmail() => StringUtils.extractEmail(this);

  /// Whether a string is contain a email.
  /// throw a exception if the input string is null.
  bool get isContainEmail => StringUtils.isContainEmail(this);

  /// Indicates whether a string is a phone number or not.
  bool isPhoneNumber() => RegExp(phoneNumberPattern).hasMatch(this);

  /// Indicates whether a string is encrypted of base64 format.d
  bool isBase64() => RegExp(base64Pattern).hasMatch(this);

  /// Indicates whether a string is ipv4 format or not.
  bool isIpv4() => StringUtils.isIPv4(this);

  /// Indicates whether a string is ipv6 format or not.
  bool isIpv6() => StringUtils.isIPv6(this);
  T? toEnum<T>(Iterable<T> values) {
    return values.firstWhereOrNull((f) => f.toString().split('.').last == this);
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

  String? validate(bool Function(String) condition, String message) {
    if (condition(this)) {
      return null;
    }
    return message;
  }

  DateTime toDateTime() => DateTime.parse(this);

  String removeVietnameseMark({bool toLower = false}) => toLower
      ? diacritic.removeDiacritics(this.toLowerCase())
      : diacritic.removeDiacritics(this);

  /// Remove diacritics character on string
  /// Example: Đây là Tiếng Việt -> "Day la Tieng Viet"
  String removeDiacritics([bool toLower = false]) {
    String key = toLower ? this.toLowerCase() : this;
    return diacritic.removeDiacritics(key);
  }

  ui.Color toColor() {
    return ui.Color(int.parse(this));
  }

  /// Split a string into many chunks by chunkSize
  /// Example: 'abcdefghijk' -> [abcd, efgh, ijk] if chunkSize = 4
  List<String> chunk(int chunkSize) {
    return StringUtils.chunk(this, chunkSize);
  }

  /// hide characters from [start] to [end] by [replacement]
  /// For example: 0908075555 -> 09****5555
  String? hideNumber(
      {required int start, int? end, required String replacement}) {
    return StringUtils.hideNumber(
      this,
      start: start,
      end: end,
      replacement: replacement,
    );
  }

  /// Start substring a unicode string start at [startAt] by [prefix].
  String? trimUnicode(int startAt, [String prefix = '...']) =>
      StringUtils.trimUnicode(this, startAt, prefix);

  /// Extract the first phone number string on [this] string.
  /// Default it replace 'o'=> '0"
  String? extractPhoneNumber(
          [Map<String, String> replace = const {"o": "0"}]) =>
      StringUtils.extractPhoneNumber(this, replace);

  String? getFirstPhoneNumber(
          {Map<String, String>? replace, String? pattern}) =>
      StringUtils.getPhoneNumberFromText(
        this,
        pattern: pattern,
        replace: replace,
      );

  dynamic parseJson({Object reviver(Object? key, Object? value)?}) {
    return jsonDecode(this, reviver: reviver);
  }

  /// Cast a number string to [int];
  int toInt({int radix = 10}) {
    try {
      return int.parse(this, radix: radix);
    } catch (e) {
      throw ArgumentError('This string is not a int number');
    }
  }

  num? tryToNum({separate = ',', decimalPlace = '.'}) =>
      StringUtils.tryToNum(this,
          separate: separate, decimalPlace: decimalPlace);

  /// Cast a number string to [double]
  double toDouble() {
    try {
      return double.parse(this);
    } catch (error) {
      throw ArgumentError('This string is not a double number');
    }
  }

  String valueIfNullOrEmpty(String nullValue) =>
      StringUtils.stringIfNullOrEmpty(this, nullValue);

  /// Repeat string [input] [n] times with [separator]
  ///
  /// Example:
  /// ```dart
  /// print('hello', 3, ':'); // hello:hello:hello
  /// ```
  String repeat(int n, [String separator = '']) =>
      StringUtils.repeat(this, n, separator);
}
