import 'package:tmt_dart_utils/tmt_dart_utils.dart';

extension MapEx on Map<String, dynamic>? {
  /// Convert Object type of Map<String,dynamic> to Object has type of T using function
  /// [convert]
  T? toObject<T>(T Function(Map<String, dynamic>? json) convert) {
    if (this == null) return null;
    final Map<String, dynamic> inputMap = this!;
    return convert(inputMap);
  }

  /// Convert List<Map<String,dynamic>> to List<T>
  List<T>? toListOfObject<T>(T Function(Map<String, dynamic> json) convert) {
    if (this == null) {
      return null;
    }
    return (this as List).map((e) => convert(e)).toList();
  }
}

class TestClass {
  final double value = 0;
  void main() {
    value.toStringFormat('###');
  }
}
