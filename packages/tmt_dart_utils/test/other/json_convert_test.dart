import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_utils.dart';

class TestModel {
  final String name;
  TestModel(this.name);
}

void main() {
  group('JsonConvertGlobal', () {
    setUp(() {
      // Reset configs before each test
      JsonConvertGlobal.configs = {};
    });

    test('should deserialize json when config is registered', () {
      JsonConvertGlobal.configs = {
        TestModel: (json) => TestModel(json['name'] as String)
      };

      final json = {'name': 'Test'};
      final result = JsonConvertGlobal.deserialize<TestModel>(json);
      expect(result, isA<TestModel>());
      expect(result.name, 'Test');
    });

    test('should throw exception when config is not registered', () {
      JsonConvertGlobal.configs = {};

      final json = {'name': 'Test'};
      expect(() => JsonConvertGlobal.deserialize<TestModel>(json), throwsException);
    });

    test('should throw exception with type name in message', () {
      JsonConvertGlobal.configs = {};

      final json = {'name': 'Test'};
      expect(
        () => JsonConvertGlobal.deserialize<TestModel>(json),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('JsonConvert', () {
    test('should deserialize json when config is registered', () {
      final configs = {
        TestModel: (json) => TestModel(json['name'] as String)
      };

      final converter = JsonConvert(configs: configs);
      final json = {'name': 'Test'};
      final result = converter.deserialize<TestModel>(json);
      expect(result, isA<TestModel>());
      expect(result.name, 'Test');
    });

    test('should throw exception when config is not registered', () {
      final configs = {
        TestModel: (json) => TestModel(json['name'] as String)
      };

      final converter = JsonConvert(configs: configs);
      final json = {'name': 'Test'};
      expect(() => converter.deserialize<String>(json), throwsException);
    });
  });
}
