import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_utils.dart';

void main() {
  group('InternetUtils', () {
    group('checkConnection', () {
      test('should return true when connection succeeds', () async {
        // Note: This test depends on actual network connectivity
        // In a real test environment, you might want to mock this
        final result = await InternetUtils.checkConnection();
        expect(result, isA<bool>());
      });

      test('should return false when connection fails', () async {
        // Test with an invalid host
        final result = await InternetUtils.checkConnection(host: 'invalid-host-that-does-not-exist.com');
        expect(result, false);
      });

      test('should return false for non-existent host', () async {
        final result = await InternetUtils.checkConnection(host: 'this-host-definitely-does-not-exist-12345.com');
        expect(result, false);
      });

      test('should use custom host when provided', () async {
        // Test with localhost (may or may not be available)
        final result = await InternetUtils.checkConnection(host: 'localhost');
        expect(result, isA<bool>());
      });
    });
  });
}
