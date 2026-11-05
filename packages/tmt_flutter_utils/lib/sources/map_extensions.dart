extension MapEx on Map<String, dynamic>? {
  /// Convert Object type of Map<String,dynamic> to Object has type of T using function
  /// [convert]
  T? toObject<T>(T Function(Map<String, dynamic>? json) convert) {
    if (this == null) return null;
    final Map<String, dynamic> inputMap = this!;
    return convert(inputMap);
  }
}

extension ListMapEx on List<Map<String, dynamic>>? {
  /// Convert List<Map<String,dynamic>> to List<T>
  List<T>? toListOfObject<T>(T Function(Map<String, dynamic> json) convert) {
    if (this == null) {
      return null;
    }
    return this!.map((e) => convert(e)).toList();
  }
}
