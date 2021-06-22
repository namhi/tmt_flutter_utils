extension MapEx on Map<String, dynamic>? {
  T? toObject<T>(T Function(Map<String, dynamic>? json) convert) {
    if (this == null) return null;
    final Map<String, dynamic> inputMap = this!;
    return convert(inputMap);
  }

  List<T>? toListOfObject<T>(T Function(Map<String, dynamic> json) convert) {
    if (this == null) {
      return null;
    }
    return (this as List).map((e) => convert(e)).toList();
  }
}
