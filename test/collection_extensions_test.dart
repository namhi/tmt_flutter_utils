import 'package:flutter_test/flutter_test.dart';
import 'package:tmt_flutter_untils/tmt_flutter_extensions.dart';

class TestObject {
  TestObject({required this.value, required this.name});
  final int value;
  final String name;
}

void main() {
  test('Test sumBy when list is null', () {
    List<TestObject>? list;
    list = [TestObject(value: 10, name: 'hahaa')];
    num value = list.sumBy((f) => f.value);
    print(value);
    expect(value, 10);
  });
  test('Test sumBy when list is has one object', () {
    final List<TestObject> list = [TestObject(value: 10, name: 'hahaa')];
    num value = list.sumBy((f) => f.value);
    print(value);
    expect(value, 10);
  });

  test('Test sumBy when list is has many object', () {
    final List<TestObject> list = [
      TestObject(value: 10, name: 'hahaa'),
      TestObject(value: 11, name: 'hahi')
    ];
    num value = list.sumBy((f) => f.value);
    print(value);
    expect(value, 21);
  });

  test('Test sumByInt when list is has many object', () {
    final List<TestObject> list = [
      TestObject(value: 10, name: 'hahaa'),
      TestObject(value: 11, name: 'hahi')
    ];
    int value = list.sumByInt((f) => f.value);
    print(value);
    expect(value, 21);
  });

  test('Test getLenthOrDefault when list is null', () {
    final List<TestObject> list = [
      TestObject(value: 10, name: 'hahaa'),
      TestObject(value: 11, name: 'hahi')
    ];

    // final List<TestObject>? list = null;
    int value = list.lengthOrDefault();
    int value2 = list.length;
    print(value);
    print(value2);
    //expect(value, 21);
  });
}
