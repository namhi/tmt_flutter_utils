import 'package:flutter_test/flutter_test.dart';
import 'package:tmt_flutter_untils/sources/datetime_utils/datetime_until.dart';

main() {
  test("getFirstDateOfWeekTest", () {
    var date = new DateTime(2019, 12, 21);
    var firstDate = getFirstDateOfWeek(date);
    print(firstDate);
    expect(firstDate, equals(new DateTime(2019, 12, 16, 0, 0, 0)));
  });
  test("getLastDateOfWeekTest", () {
    var date = new DateTime(2019, 12, 21);
    var lastDate = getLastDateOfWeek(date);
    print(lastDate);
    expect(lastDate, equals(new DateTime(2019, 12, 22, 23, 59, 59, 999, 999)));
  });

  test("getFirstDateOfMonthTest", () {
    var date = new DateTime(2019, 12, 21);
    var result = getFirstDateOfMonth(date);
    print(result);
    expect(result, equals(new DateTime(2019, 12, 1, 0, 0, 0)));
  });
  test("getLastDateOfMonthTest", () {
    var date = new DateTime(2019, 12, 21);
    var result = getLastDateOfMonth(date);
    print(result);
    expect(result, equals(new DateTime(2019, 12, 31, 23, 59, 59, 999, 999)));
  });

  test("getTimeRangeTodayTest", () {
    var date = new DateTime(2019, 12, 21);
    var result = getTimeRangeToday(date);
    print(result);
    expect(result.name, equals("Hôm nay"));
    expect(result.startDate, equals(new DateTime(2019, 12, 21, 0, 0, 0)));
    expect(result.endDate,
        equals(new DateTime(2019, 12, 21, 23, 59, 59, 999, 999)));
  });
  test("getTimeRangeYesterdayTest", () {
    var date = new DateTime(2019, 12, 21);
    var result = getTimeRangeYesterday(date);
    print(result);
    expect(result.name, equals("Hôm qua"));
    expect(result.startDate, equals(new DateTime(2019, 12, 20, 0, 0, 0)));
    expect(result.endDate,
        equals(new DateTime(2019, 12, 20, 23, 59, 59, 999, 999)));
  });
  test("getTimeRangeLast7DayTest", () {
    var date = new DateTime(2019, 12, 21);
    var result = getTimeRangeLast7Day(date);
    print(result);
    expect(result.name, equals("7 ngày qua"));
    expect(result.startDate, equals(new DateTime(2019, 12, 15, 0, 0, 0)));
    expect(result.endDate,
        equals(new DateTime(2019, 12, 21, 23, 59, 59, 999, 999)));
  });
  test("getTimeRangeLast28DayTest", () {
    var date = new DateTime(2019, 12, 21);
    var result = getTimeRangeLast28Day(date);
    print(result);
    expect(result.name, equals("28 ngày qua"));
    expect(result.startDate, equals(new DateTime(2019, 11, 24, 0, 0, 0)));
    expect(result.endDate,
        equals(new DateTime(2019, 12, 21, 23, 59, 59, 999, 999)));
  });

  test("getTimeRangeLast30DayTest", () {
    var date = new DateTime(2019, 12, 21);
    var result = getTimeRangeLast30Day(date);
    print(result);
    expect(result.name, equals("30 ngày qua"));
    expect(result.startDate, equals(new DateTime(2019, 11, 22, 0, 0, 0)));
    expect(result.endDate,
        equals(new DateTime(2019, 12, 21, 23, 59, 59, 999, 999)));
  });
  test("getTimeRangeLast90DayTest", () {
    var date = new DateTime(2019, 12, 21);
    var result = getTimeRangeLast90Day(date);
    print(result);
    expect(result.name, equals("90 ngày qua"));
    expect(result.startDate, equals(new DateTime(2019, 9, 23, 0, 0, 0)));
    expect(result.endDate,
        equals(new DateTime(2019, 12, 21, 23, 59, 59, 999, 999)));
  });

  test("getTimeRangeThisWeekTest", () {
    var date = new DateTime(2019, 12, 21);
    var result = getTimeRangeThisWeek(date);
    print(result);
    expect(result.name, equals("Tuần này"));
    expect(result.startDate, equals(new DateTime(2019, 12, 16, 0, 0, 0)));
    expect(result.endDate,
        equals(new DateTime(2019, 12, 22, 23, 59, 59, 999, 999)));
  });
  test("getTimeRangeLastWeekTest", () {
    var date = new DateTime(2019, 12, 21);
    var result = getTimeRangeLastWeek(date);
    print(result);
    expect(result.name, equals("Tuần trước"));
    expect(result.startDate, equals(new DateTime(2019, 12, 9, 0, 0, 0)));
    expect(result.endDate,
        equals(new DateTime(2019, 12, 15, 23, 59, 59, 999, 999)));
  });
  test("getTimeRangeThisMonthTest", () {
    var date = new DateTime(2019, 12, 21);
    var result = getTimeRangeThisMonth(date);
    print(result);
    expect(result.name, equals("Tháng này"));
    expect(result.startDate, equals(new DateTime(2019, 12, 1, 0, 0, 0)));
    expect(result.endDate,
        equals(new DateTime(2019, 12, 31, 23, 59, 59, 999, 999)));
  });

  test("getTimeRangeLastMonthTest", () {
    var date = new DateTime(2019, 12, 21);
    var result = getTimeRangeLastMonth(date);
    print(result);
    expect(result.name, equals("Tháng trước"));
    expect(result.startDate, equals(new DateTime(2019, 11, 1, 0, 0, 0)));
    expect(result.endDate,
        equals(new DateTime(2019, 11, 30, 23, 59, 59, 999, 999)));
  });
  test("getTimeRangeThisYearTest", () {
    var date = new DateTime(2019, 12, 21);
    var result = getTimeRangeThisYear(date);
    print(result);
    expect(result.name, equals("Năm nay"));
    expect(result.startDate, equals(new DateTime(2019, 1, 1, 0, 0, 0)));
    expect(result.endDate,
        equals(new DateTime(2019, 12, 31, 23, 59, 59, 999, 999)));
  });

  test("getTimeRangeLastYearTest", () {
    var date = new DateTime(2019, 12, 21);
    var result = getTimeRangeLastYear(date);
    print(result);
    expect(result.name, equals("Năm trước"));
    expect(result.startDate, equals(new DateTime(2018, 1, 1, 0, 0, 0)));
    expect(result.endDate,
        equals(new DateTime(2018, 12, 31, 23, 59, 59, 999, 999)));
  });

  test("datetimeToStringSortTest", () {
    // 21
    var now = new DateTime(2019, 12, 21);
    var testValue = [
      [new DateTime(2019, 12, 21), "21"],
      [new DateTime(2019, 11, 21), "21/11"],
      [new DateTime(2018, 12, 21), "21/12/2018"],
    ];

    for (var itm in testValue) {
      var result = datetimeToStringSort(itm[0], now);
      print(result);
      expect(result, equals(itm[1]));
    }
  });
}
