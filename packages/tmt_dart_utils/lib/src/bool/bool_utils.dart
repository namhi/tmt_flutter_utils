extension BoolExtensions on bool {
  String toCustomString(String trueValue, String falseValue) {
    return this ? trueValue : falseValue;
  }

  bool getValue() {
    return this;
  }
}

/// Return String base on bool value
///
/// Ex: Return 'Đúng' if true, return 'Sai' if false, return 'Không xác định' if null.
extension BoolExtensionNullable on bool? {
  String toCustomString(String trueValue, String falseValue, String nullValue) {
    if (this == null) {
      return nullValue;
    }

    return this == true ? trueValue : falseValue;
  }

  /// Get value or default value of bool type.
  /// Default value is false
  bool valueOrDefault([bool defaultValue = false]) =>
      this != null ? this! : defaultValue;
}
