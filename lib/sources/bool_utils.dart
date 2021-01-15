extension BoolExtensions on bool {
  String toCustomString(String trueValue, String falseValue,
      [String nullValue]) {
    if (this == null) {
      return nullValue;
    }
    return this ? trueValue : falseValue;
  }

  bool getValue() {
    if (this == null) {
      return false;
    }
    return this;
  }
}
