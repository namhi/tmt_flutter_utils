import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Kiểm tra chuyển đổi giờ quốc tế và ngược lại', () {
    String testDate = '2020-10-14T10:07:42.93+07:00';
    DateTime date = DateTime.parse(testDate);
    print(date);
    DateTime date2 = date.toLocal();
    print(date2);

    print(date.toIso8601String());
    print(date2.toUtc().toIso8601String());
  });
}
