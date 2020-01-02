extension StringExtensions on String {
  bool isNullOrEmply() {
    return (this == null || this.isEmpty);
  }

  bool isNotNullOrEmpty() {
    return (this != null && this.isNotEmpty);
  }
}
