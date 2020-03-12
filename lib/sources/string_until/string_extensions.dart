import 'package:flutter/foundation.dart';

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
}
