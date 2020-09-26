import 'dart:convert';

class StringUtils {
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

  static List<String> chunk(String s, int chunkSize) {
    var chunked = <String>[];
    for (var i = 0; i < s.length; i += chunkSize) {
      var end = (i + chunkSize < s.length) ? i + chunkSize : s.length;
      chunked.add(s.substring(i, end));
    }
    return chunked;
  }
}
