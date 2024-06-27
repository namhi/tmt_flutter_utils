/*
 * *
 *  * Created by NamNV, Công ty TNHH TM& DV Trực Tuyến Trường Minh Thịnh on 4/9/19 9:59 AM
 *  * Copyright (c) 2020 . All rights reserved.
 *  * Last modified 4/9/19 9:53 AM
 *
 */

import 'dart:convert';

import 'package:diacritic/diacritic.dart';
import '../constant.dart';

class StringUtils {
  StringUtils._();

  static bool isAscii(String s) {
    try {
      ascii.decode(s.codeUnits);
    } catch (e) {
      return false;
    }
    return true;
  }

  static bool isUpperCase(String s) {
    return s == s.toUpperCase();
  }

  static bool isLowerCase(String s) {
    return s == s.toLowerCase();
  }

  /// Example: hideNumber(0901000123, start: 7)
  /// Input 0901000123 will return 0901000***
  static String? hideNumber(
    String number, {
    required int start,
    int? end,
    required String replacement,
  }) {
    if (end != null && end < start) {
      throw Exception("{end} must greater than {start}");
    }
    if ((end ?? start) > number.length) {
      return number;
    }
    return number.replaceRange(start, end, replacement);
  }

  ///   other method
  ///   String get reverse {
  //     if (isEmpty) {
  //       return '';
  //     }
  //     return toList().reversed.reduce((value, element) => value += element);
  //   }
  static String reverse(String text) {
    if (text == '') {
      return '';
    }
    StringBuffer sb = StringBuffer();
    for (int i = text.length - 1; i >= 0; i--) {
      sb.writeCharCode(text.codeUnitAt(i));
    }
    return sb.toString();
  }

  ///
  /// * "công ty quảng cáo" -> "Công ty quảng cáo"
  /// * "CÔNG TY QUẢNG CÁO" -> "Công ty quảng cáo"'
  static String capitalize(String s, {bool allWords = false}) {
    if (allWords) {
      var words = s.split(' ');
      var capitalized = [];
      for (var w in words) {
        capitalized.add(capitalize(w));
      }
      return capitalized.join(' ');
    } else {
      return s.substring(0, 1).toUpperCase() + s.substring(1).toLowerCase();
    }
  }

  /// [separators]: danh sách separators để split
  /// Example: 'How many times' -> 'howManyTimes'
  /// Example: 'How_many times version  _2' -> 'howManyTimesVersion2'
  static String camelCase(
    String s, {
    List<String> separators = const [' ', '_', '-'],
  }) {
    final List<String> words = splitBySeparators(s, separators: separators);

    final List<String> list = [];
    for (String w in words) {
      if (w.isNotEmpty) {
        if (words.indexOf(w) == 0) {
          list.add(w.toLowerCase());
          continue;
        }
        list.add(capitalize(w));
      }
    }

    return list.join();
  }

  /// [separators]: danh sách separators để split
  /// Example: 'How many times' -> 'HowManyTimes'
  /// Example: 'How_many times version  _2' -> 'HowManyTimesVersion2'
  static String upperCamelCase(
    String s, {
    List<String> separators = const [' ', '_', '-'],
  }) {
    final List<String> words = splitBySeparators(s, separators: separators);

    final List<String> list = [];
    for (String w in words) {
      if (w.isNotEmpty) {
        list.add(capitalize(w));
      }
    }

    return list.join();
  }

  /// [separators]: danh sách separators để split
  /// Example: 'How many times' -> 'how_many_times'
  /// Example: 'How_many times version  _2' -> 'how_many_times_version_2'
  static String lowerUnderscore(
    String s, {
    List<String> separators = const [' ', '_', '-'],
  }) {
    final List<String> words = splitBySeparators(s, separators: separators);

    final List<String> list = [];
    for (String w in words) {
      if (w.isNotEmpty) {
        list.add(w.toLowerCase());
      }
    }

    return list.join('_');
  }

  static List<String> splitBySeparators(
    String s, {
    required List<String> separators,
  }) {
    /// Chuyển tất cả kí tự 'separators' trong chuỗi về '_'
    String text = s;
    const String underscoreCharacter = '_';

    for (String separator in separators) {
      text = text.replaceAll(separator, underscoreCharacter);
    }

    final List<String> words = text.split(underscoreCharacter);

    return words;
  }

  static List<String> chunk(String s, int chunkSize) {
    var chunked = <String>[];
    for (var i = 0; i < s.length; i += chunkSize) {
      var end = (i + chunkSize < s.length) ? i + chunkSize : s.length;
      chunked.add(s.substring(i, end));
    }
    return chunked;
  }

  static bool isIPv4(String s) =>
      RegExp(r'^(?:(?:^|\.)(?:2(?:5[0-5]|[0-4]\d)|1?\d?\d)){4}$').hasMatch(s);

  static bool isIPv6(String s) => RegExp(
          r'^((([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}:[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){5}:([0-9A-Fa-f]{1,4}:)?[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){4}:([0-9A-Fa-f]{1,4}:){0,2}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){3}:([0-9A-Fa-f]{1,4}:){0,3}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){2}:([0-9A-Fa-f]{1,4}:){0,4}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|(([0-9A-Fa-f]{1,4}:){0,5}:((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|(::([0-9A-Fa-f]{1,4}:){0,5}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|([0-9A-Fa-f]{1,4}::([0-9A-Fa-f]{1,4}:){0,5}[0-9A-Fa-f]{1,4})|(::([0-9A-Fa-f]{1,4}:){0,6}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){1,7}:))$')
      .hasMatch(s);

  static bool isEmail(String s) => RegExp(emailPattern).hasMatch(s);

  /// Extract the first email from string [s].
  /// The value [s] can't be null.
  static String? extractEmail(String s) {
    // if (s == null) {
    //   throw ArgumentError('input must not be null');
    // }
    final RegExp exp = RegExp(containEmailPattern);
    final String? email = exp.stringMatch(s);
    return email;
  }

  /// Whether the string [s] is contain a email address.
  static bool isContainEmail(String s) {
    final RegExp exp = RegExp(containEmailPattern);
    return exp.hasMatch(s);
  }

  static String removeVietnameseMark(String s, [bool toLower = false]) {
    String key = toLower ? s.toLowerCase() : s;
    return removeDiacritics(key);
  }

  /// Trim a string at [startAt]
  static String? trimUnicode(String input, int startAt, [prefix = "..."]) {
    // if (input == null) return null;

    if (input != "") {
      if (input.runes.length >= startAt) {
        return String.fromCharCodes(input.runes, 0, startAt) + prefix;
      } else {
        return input;
      }
    } else {
      return "";
    }
  }

  static String? extractPhoneNumber(String s,
      [Map<String, String> replace = const {"o": "0"}]) {
    String input = s;
    if (replace.isNotEmpty) {
      for (var itm in replace.keys) {
        input = input.replaceAll(itm, replace[itm]!);
      }
    }

    return RegExp(phoneNumberPattern).firstMatch(s)?.group(1) ?? null;
  }

  /// Get the first phone number from text [s] base on Regex [pattern].
  /// try to replace character from [replace] before try to regex
  ///
  /// If [pattern] is null. The default pattern is use.
  static String? getPhoneNumberFromText(
    String s, {
    Map<String, String>? replace,
    String? pattern,
  }) {
    String input = s;
    if (replace != null && replace.isNotEmpty) {
      for (var itm in replace.keys) {
        input = input.replaceAll(itm, replace[itm]!);
      }
    }
    return RegExp(pattern ?? phoneNumberPattern)
            .firstMatch(input)
            ?.group(1)
            ?.trim() ??
        null;
  }

  static bool isBool(String value) {
    // if (value == null) {
    //   return false;
    // }
    return (value == 'true' || value == 'false');
  }

  static bool isNumber(String value) {
    // if (value == null) {
    //   return false;
    // }
    return num.tryParse(value) is num;
  }

  static bool isInt(String value) {
    // if (value == null) {
    //   return false;
    // }

    return int.tryParse(value) is int;
  }

  static bool isDouble(String value) {
    // if (value == null) {
    //   return false;
    // }
    return double.tryParse(value) is double;
  }

  static bool isNull(dynamic value) => value == null;

  static bool isNumericOnly(String value) {
    // if (value == null) {
    //   return false;
    // }
    return RegExp(r'^\d+$').hasMatch(value);
  }

  static num? tryToNum(String value, {separate = ',', decimalPlace = '.'}) {
    String temp = value.replaceAll(separate, '');
    temp = temp.replaceAll(decimalPlace, '.');
    return num.tryParse(temp);
  }

  /// Return input if [input] is not null or empty, return [nullValue] if [input] is null
  static stringIfNullOrEmpty(String? input, String nullValue) {
    if (input != null && input.isNotEmpty) {
      return input;
    }
    return nullValue;
  }

  /// Repeat string [input] [n] times with [separator]
  ///
  /// Example:
  /// ```dart
  /// print(StringUtils.repeat('hello', 3, ':')); // hello:hello:hello
  /// ```
  static String repeat(String input, int n, [String separator = '']) {
    if (n < 1) {
      throw ArgumentError('The value of n must greater than 0');
    }

    String output = '';
    if (n == 1) {
      return input;
    }

    for (int i = 1; i <= n; i++) {
      output += separator + input;
    }

    return output;
  }

  /// Get the first character String on each word in Strings.
  ///
  /// Ex: The blue sky => Tbs
  static String getInitials({required String string, int? limitTo}) {
    final buffer = StringBuffer();
    final split = string.split(' ');
    for (var i = 0; i < (limitTo ?? split.length); i++) {
      buffer.write(split[i][0]);
    }

    return buffer.toString();
  }
}
