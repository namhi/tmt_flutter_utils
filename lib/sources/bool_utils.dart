extension BoolExtensions on bool {
  String toCustomString(String trueValue, String falseValue) {
    return this ? trueValue : falseValue;
  }

  bool getValue() {
    if (this == null) {
      return false;
    }
    return this;
  }
}
