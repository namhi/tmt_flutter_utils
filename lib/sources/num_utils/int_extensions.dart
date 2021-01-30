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
}
