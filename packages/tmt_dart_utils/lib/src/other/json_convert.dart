typedef ConvertJsonToObject = Function(Map<String, dynamic> json);

class JsonConvertGlobal {
  static late Map<Type, ConvertJsonToObject> configs;
  static T deserialize<T>(Map<String, dynamic> json) {
    if (configs[T] != null) {
      ConvertJsonToObject fun = configs[T]!;
      T result = fun(json);
      return result;
    }
    throw Exception('Convert from json to object type of $T is not config.');
  }
}

class JsonConvert<T> {
  JsonConvert({this.configs});
  final Map<Type, ConvertJsonToObject>? configs;

  // ignore: avoid_shadowing_type_parameters
  T deserialize<T>(Map<String, dynamic> json) {
    if (configs![T] != null) {
      ConvertJsonToObject fun = configs![T]!;
      T result = fun(json);
      return result;
    }
    throw Exception('Convert from json to object type of $T is not config.');
  }
}
