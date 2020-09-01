/// Chuyển dổi enum sang String
/// Ví dụ Type.Sring => String
String convertEnumToString(Object value) {
  return value.toString().replaceAll("${value.runtimeType.toString()}.", "");
}
