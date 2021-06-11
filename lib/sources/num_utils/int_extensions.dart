import 'dart:math';

import 'package:flutter/material.dart';

extension IntExtensions on int {
  Color toColor() {
    return Color(this);
  }

  int getValueOrDefault([int defaultValue = 0]) {
    if (this == null) {
      return defaultValue;
    }
    return this;
  }

  Duration get hour => Duration(hours: this);
  Duration get minute => Duration(minutes: this);
  Duration get second => Duration(seconds: this);

  /// Returns text representation of a provided bytes value
  /// e.g 1Kb, 12MB, 2GB)...
  String byteSizeToString([int fractionDigits = 2]) {
    if (this <= 0) return '0 B';
    final multiple = (log(this) / log(1024)).floor();
    return (this / pow(1024, multiple)).toStringAsFixed(fractionDigits) +
        ' ' +
        ['B', 'kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'][multiple];
  }
}
