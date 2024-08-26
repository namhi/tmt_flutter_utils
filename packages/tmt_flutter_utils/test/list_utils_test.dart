import 'package:flutter_test/flutter_test.dart';
import '../lib/tmt_flutter_utils.dart';

class TestObject {
  TestObject({required this.value, required this.name});
  final int value;
  final String name;
}

void main() {
  // test('Test sumBy when list is null', () {
  //   final List<TestObject>? list;
  //   double value = ListUtils.sumBy<TestObject>(list, (f) => f.value);
  //   print(value);
  // });

  test('Test sumBy when list is has one object', () {
    final List<TestObject> list = [TestObject(value: 10, name: 'hahaa')];
    num value = ListUtils.sumBy<TestObject>(list, (f) => f.value);
    print(value);
    expect(value, 10);
  });

  test('Test sumBy when list is has many object', () {
    final List<TestObject> list = [
      TestObject(value: 10, name: 'hahaa'),
      TestObject(value: 11, name: 'hahi')
    ];
    num value = ListUtils.sumBy<TestObject>(list, (f) => f.value);
    print(value);
    expect(value, 21);
  });

  test('Test sumByInt when list is has many object', () {
    final List<TestObject> list = [
      TestObject(value: 10, name: 'hahaa'),
      TestObject(value: 11, name: 'hahi')
    ];
    int value = ListUtils.sumByInt<TestObject>(list, (f) => f.value);
    print(value);
    expect(value, 21);
  });
}
