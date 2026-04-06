import 'package:flutter_test/flutter_test.dart';
import 'package:tmt_flutter_utils/tmt_flutter_utils.dart';

class TestModel {
  final String name;
  final int value;
  TestModel({required this.name, required this.value});

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      name: json['name'] as String,
      value: json['value'] as int,
    );
  }
}

void main() {
  group('MapExtensions', () {
    group('toObject', () {
      test('should convert map to object using convert function', () {
        final map = {'name': 'Test', 'value': 42};

        final result = map.toObject<TestModel>((json) => TestModel.fromJson(json));

        expect(result, isA<TestModel>());
        expect(result?.name, 'Test');
        expect(result?.value, 42);
      });

      test('should return null when map is null', () {
        Map<String, dynamic>? map = null;

        final result = map.toObject<TestModel>((json) => TestModel.fromJson(json));

        expect(result, isNull);
      });

      test('should handle empty map', () {
        final map = <String, dynamic>{};

        final result = map.toObject<TestModel>((json) => TestModel.fromJson(json));

        expect(result, isA<TestModel>());
        expect(result?.name, ''); // Default string value
        expect(result?.value, 0); // Default int value
      });

      test('should pass through all map data to convert function', () {
        final map = {
          'name': 'Complex Test',
          'value': 999,
          'extra': 'ignored',
        };

        final result = map.toObject<TestModel>((json) => TestModel.fromJson(json));

        expect(result?.name, 'Complex Test');
        expect(result?.value, 999);
      });
    });

    group('toListOfObject', () {
      test('should convert list of maps to list of objects', () {
        final maps = [
          {'name': 'Item 1', 'value': 1},
          {'name': 'Item 2', 'value': 2},
          {'name': 'Item 3', 'value': 3},
        ];

        final result = maps.toListOfObject<TestModel>((json) => TestModel.fromJson(json));

        expect(result, isA<List<TestModel>>());
        expect(result, hasLength(3));
        expect(result?[0].name, 'Item 1');
        expect(result?[0].value, 1);
        expect(result?[1].name, 'Item 2');
        expect(result?[1].value, 2);
        expect(result?[2].name, 'Item 3');
        expect(result?[2].value, 3);
      });

      test('should return null when map is null', () {
        List<Map<String, dynamic>>? maps = null;

        final result = maps.toListOfObject<TestModel>((json) => TestModel.fromJson(json));

        expect(result, isNull);
      });

      test('should handle empty list', () {
        final maps = <Map<String, dynamic>>[];

        final result = maps.toListOfObject<TestModel>((json) => TestModel.fromJson(json));

        expect(result, isA<List<TestModel>>());
        expect(result, isEmpty);
      });

      test('should handle list with single item', () {
        final maps = [
          {'name': 'Single', 'value': 42},
        ];

        final result = maps.toListOfObject<TestModel>((json) => TestModel.fromJson(json));

        expect(result, hasLength(1));
        expect(result?[0].name, 'Single');
        expect(result?[0].value, 42);
      });
    });
  });
}
