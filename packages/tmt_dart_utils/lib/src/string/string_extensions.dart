import 'dart:convert';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:crypto/crypto.dart';
import 'package:diacritic/diacritic.dart' as diacritic;

import '../constant.dart';
import 'string_utils.dart';

extension StringNullExtensionsEx on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => this != null && this != '';
  bool isNull() => StringUtils.isNull(this);
  String valueIfNullOrEmpty(String nullValue) =>
      StringUtils.stringIfNullOrEmpty(this, nullValue);

  String get valueOrEmpty => this != null ? this! : '';
  bool get isNullOrBlank => this == null || this == '';
  bool get isNotNullOrBlank => this != null && this != '';
}

extension StringExtensions on String {
  bool get isBool => StringUtils.isBool(this);

  bool get isNumber => StringUtils.isNumber(this);
  bool get isInt => StringUtils.isInt(this);
  bool get isDouble => StringUtils.isDouble(this);
  bool get isNumericOnly => StringUtils.isNumericOnly(this);
  bool get isLowerCase => StringUtils.isLowerCase(this);
  bool get isUpperCase => StringUtils.isUpperCase(this);
  bool get isAscii => StringUtils.isAscii(this);
  bool get isEmail => RegExp(emailPattern).hasMatch(this);
  bool get isUrl => RegExp(urlPattern).hasMatch(this);
  bool get isCapitalized => isNotEmpty && this[0].isUpperCase;

  /// Whether a string is contain a email.
  /// throw a exception if the input string is null.
  bool get isContainEmail => StringUtils.isContainEmail(this);

  /// Indicates whether a string is a phone number or not.
  bool get isPhoneNumber => RegExp(phoneNumberPattern).hasMatch(this);

  /// Indicates whether a string is encrypted of base64 format.d
  bool get isBase64 => RegExp(base64Pattern).hasMatch(this);

  /// Indicates whether a string is ipv4 format or not.
  bool get isIpv4 => StringUtils.isIPv4(this);

  /// Indicates whether a string is ipv6 format or not.
  bool get isIpv6 => StringUtils.isIPv6(this);

  /// Extract first email from string.
  /// Return null value if string not has an email.
  /// Throw a exception if the input string is null.
  String? extractEmail() => StringUtils.extractEmail(this);

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

  /// Return [DateTime] value from String, try set [toLocal] =true if you want.
  DateTime toDateTime({bool toLocal = false}) {
    final result = DateTime.parse(this);
    if (toLocal) {
      return result.toLocal();
    } else {
      return result;
    }
  }

  String removeVietnameseMark({bool toLower = false}) => toLower
      ? diacritic.removeDiacritics(toLowerCase())
      : diacritic.removeDiacritics(this);

  /// Remove diacritics character on string
  /// Example: Đây là Tiếng Việt -> "Day la Tieng Viet"
  String removeDiacritics([bool toLower = false]) {
    String key = toLower ? toLowerCase() : this;
    return diacritic.removeDiacritics(key);
  }

  /// Split a string into many chunks by chunkSize
  /// Example: 'abcdefghijk' -> [abcd, efgh, ijk] if chunkSize = 4
  List<String> chunk(int chunkSize) {
    return StringUtils.chunk(this, chunkSize);
  }

  /// hide characters from [start] to [end] by [replacement]
  /// For example: 0908075555 -> 09****5555
  String? hideNumber({
    required int start,
    int? end,
    required String replacement,
  }) {
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

  dynamic parseJson({Object Function(Object? key, Object? value)? reviver}) {
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

  double? toDoubleOrNull() {
    try {
      return double.parse(this);
    } catch (error) {
      return null;
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

  /// using [jsonDecode] to convert Json String to Map<String,dynamic>
  Map<String, dynamic> toMap() => jsonDecode(this);

  /// Get the first character String on each word in Strings.
  ///
  /// Ex: The blue sky => Tbs
  String getInitials() => StringUtils.getInitials(string: this);

  /// Returns a copy of this string and make the first letter uppercase
  ///
  /// * "công ty quảng cáo" -> "Công ty quảng cáo"
  /// * "CÔNG TY QUẢNG CÁO" -> "Công ty quảng cáo"'
  String capitalize([bool allWord = false]) =>
      StringUtils.capitalize(this, allWords: allWord);

  String get urlEncode => Uri.encodeFull(this);
  String get urlDecode => Uri.decodeFull(this);

  /// Returns cammel case of String.
  String toCamelCase() {
    return StringUtils.camelCase(this);
  }

  String toUpperCamelCase() {
    return StringUtils.upperCamelCase(this);
  }

  String toLowerUnderscore() {
    return StringUtils.lowerUnderscore(this);
  }

  String toLowerFirstCharacter() {
    return substring(0, 1).toLowerCase() + substring(1);
  }
}
