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
import 'package:tmt_flutter_untils/sources/regex_pattern.dart';
import 'package:crypto/crypto.dart';
import 'package:diacritic/diacritic.dart' as diacritic;
import 'package:tmt_flutter_untils/sources/string_utils/string_utils.dart';

import '../constant.dart';

extension StringExtensionsEx on String? {
  bool get isNullOrEmpty => this == null || this != '';
  bool get isNotNullOrEmpty => this != null && this != '';
}

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

  @Deprecated('When enable null safety')
  bool isNotNullOrEmpty() => this.isNotEmpty;
  @Deprecated('When enable null safety')
  bool isNullOrEmpty() => this.isEmpty;
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

  String removeDiacritics([bool toLower = false]) {
    String key = toLower ? this.toLowerCase() : this;
    return diacritic.removeDiacritics(key);
  }

  ui.Color toColor() {
    return ui.Color(int.parse(this));
  }

  /// Split a string into many chunks by chunkSIze
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

  String? extractPhoneNumber(
          [Map<String, String> replace = const {"o": "0"}]) =>
      StringUtils.extractPhoneNumber(this, replace);

  dynamic parseJson({Object reviver(Object? key, Object? value)?}) {
    return jsonDecode(this, reviver: reviver);
  }

  int? toInt({int radix = 10}) {
    try {
      return int.parse(this, radix: radix);
    } catch (e) {
      return null;
    }
  }

  double? toDouble() {
    try {
      return double.parse(this);
    } catch (error) {
      return null;
    }
  }
}
