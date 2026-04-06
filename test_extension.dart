import 'packages/tmt_dart_utils/lib/tmt_dart_utils.dart';

void main() {
  // Test 1: Non-nullable bool
  bool nonNull = true;
  print('Non-null bool: ${nonNull.toCustomString("Y", "N")}');

  // Test 2: Nullable bool with non-null value
  bool? nullableWithNonNull = true;
  // This should use the nullable extension
  print('Nullable with non-null: ${nullableWithNonNull.toCustomString("Y", "N", "U")}');

  // Test 3: Nullable bool with null value
  bool? nullableWithNull = null;
  print('Nullable with null: ${nullableWithNull.toCustomString("Y", "N", "U")}');
}
