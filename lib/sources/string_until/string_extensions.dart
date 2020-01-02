extension StringExtensions on String {
  bool isNullOrEmply() {
    return (this == null || this.isEmpty);
  }
}
