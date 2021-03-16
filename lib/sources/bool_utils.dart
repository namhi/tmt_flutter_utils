extension BoolExtensions on bool {
  String toCustomString(String trueValue, String falseValue,
      [String? nullValue]) {
    return this ? trueValue : falseValue;
  }

  bool getValue() {
    return this;
  }
}
