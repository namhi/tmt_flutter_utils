extension BoolExtensions on bool {
  String toCustomString(String trueValue, String falseValue) {
    return this ? trueValue : falseValue;
  }
}

extension BoolExtensionNullable on bool? {
  String toCustomString(String trueValue, String falseValue, String nullValue) {
    if (this == null) {
      return nullValue;
    }
    return this == true ? trueValue : falseValue;
  }
}

void main() {
  final bool? value = true;
  print(value.toCustomString('Yes', 'No', 'Unknown'));
}
