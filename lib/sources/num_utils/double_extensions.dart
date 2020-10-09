import 'package:flutter/material.dart';

extension DoubleExtensions on double {
  double getValueOrDefault([double defaultValue = 0.0]) {
    if (this == null) {
      return defaultValue;
    }
    return this;
  }
}
