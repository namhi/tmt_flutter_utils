extension DoubleExtensions on double? {
  double valueOrDefault([double defaultValue = 0.0]) {
    return this ?? defaultValue;
  }
}
