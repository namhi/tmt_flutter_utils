import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_extensions.dart';

void main() {
  test('isBase64 detects base64 strings', () {
    expect('SGVsbG8gV29ybGQ='.isBase64, isTrue);
    expect('hello world!'.isBase64, isFalse);
    expect('test@example'.isBase64, isFalse);
  });
}
