library tmt_flutter_utils;

import 'package:intl/intl.dart';
import 'datetime_range.dart';
import 'datetime_range_type.dart';

DateTime getFirstDateOfWeek(DateTime date) {
  final int dateOfWeek = date.weekday;
  DateTime dateResult = date.add(Duration(days: -(dateOfWeek - 1)));
  return DateTime(dateResult.year, dateResult.month, dateResult.day, 0, 0, 0);
}

DateTime getLastDateOfWeek(DateTime date) {
  final int dateOfWeek = date.weekday;
  var lastDate = date.add(Duration(days: (7 - dateOfWeek)));
  return DateTime(
      lastDate.year, lastDate.month, lastDate.day, 23, 59, 59, 999, 999);
}

DateTime getFirstDateOfMonth(DateTime date) {
  return DateTime(date.year, date.month, 1, 0, 0, 0);
}

DateTime getLastDateOfMonth(DateTime date) {
  var lastDate = new DateTime(date.year, date.month + 1, 0);
  return DateTime(
      lastDate.year, lastDate.month, lastDate.day, 23, 59, 59, 999, 999);
}

DateTimeRange getTimeRangeToday([DateTime? date]) {
  var now = date ?? DateTime.now();
  return DateTimeRange(
      name: "Hôm nay",
      type: DateTimeRangeType.DAY,
      startDate: DateTime(now.year, now.month, now.day, 0, 0, 0),
      endDate: DateTime(now.year, now.month, now.day, 23, 59, 59, 999, 999));
}

DateTimeRange getTimeRangeYesterday([DateTime? date]) {
  var now = date ?? DateTime.now();
  return DateTimeRange(
      name: "Hôm qua",
      type: DateTimeRangeType.DAY,
      startDate: DateTime(now.year, now.month, now.day - 1, 0, 0, 0),
      endDate:
          DateTime(now.year, now.month, now.day - 1, 23, 59, 59, 999, 999));
}

DateTimeRange getTimeRangeLast7Day([DateTime? date]) {
  var now = date ?? DateTime.now();
  return DateTimeRange(
      name: "7 ngày qua",
      type: DateTimeRangeType.DAY,
      startDate: DateTime(now.year, now.month, now.day - 6, 0, 0, 0),
      endDate: DateTime(now.year, now.month, now.day, 23, 59, 59, 999, 999));
}

DateTimeRange getTimeRangeLast28Day([DateTime? date]) {
  var now = date ?? DateTime.now();
  return DateTimeRange(
      name: "28 ngày qua",
      type: DateTimeRangeType.DAY,
      startDate: DateTime(now.year, now.month, now.day - 27, 0, 0, 0),
      endDate: DateTime(now.year, now.month, now.day, 23, 59, 59, 999, 999));
}

DateTimeRange getTimeRangeLast30Day([DateTime? date]) {
  var now = date ?? DateTime.now();
  return DateTimeRange(
      name: "30 ngày qua",
      type: DateTimeRangeType.DAY,
      startDate: DateTime(now.year, now.month, now.day - 29, 0, 0, 0),
      endDate: DateTime(now.year, now.month, now.day, 23, 59, 59, 999, 999));
}

DateTimeRange getTimeRangeLast90Day([DateTime? date]) {
  var now = date ?? DateTime.now();
  return DateTimeRange(
      name: "90 ngày qua",
      type: DateTimeRangeType.DAY,
      startDate: DateTime(now.year, now.month, now.day - 89, 0, 0, 0),
      endDate: DateTime(now.year, now.month, now.day, 23, 59, 59, 999, 999));
}

DateTimeRange getTimeRangeThisWeek([DateTime? date]) {
  var now = date ?? DateTime.now();
  return DateTimeRange(
      name: "Tuần này",
      type: DateTimeRangeType.WEEK,
      startDate: getFirstDateOfWeek(now),
      endDate: getLastDateOfWeek(now));
}

DateTimeRange getTimeRangeLastWeek([DateTime? date]) {
  var now = date ?? DateTime.now();
  return DateTimeRange(
      name: "Tuần trước",
      type: DateTimeRangeType.WEEK,
      startDate: getFirstDateOfWeek(now.add(const Duration(days: -7))),
      endDate: getLastDateOfWeek(now.add(const Duration(days: -7))));
}

DateTimeRange getTimeRangeThisMonth([DateTime? date]) {
  var now = date ?? DateTime.now();
  return DateTimeRange(
      name: "Tháng này",
      type: DateTimeRangeType.MONTH,
      startDate: getFirstDateOfMonth(now),
      endDate: getLastDateOfMonth(now));
}

DateTimeRange getTimeRangeCustomMonth([DateTime? date]) {
  var now = date ?? DateTime.now();
  var today = getTimeRangeToday(now);
  return DateTimeRange(
      name: "Tùy chọn tháng",
      type: DateTimeRangeType.MONTH,
      startDate: today.startDate,
      endDate: today.endDate);
}

DateTimeRange getTimeRangeCustomDay([DateTime? date]) {
  var now = date ?? DateTime.now();
  var today = getTimeRangeToday(now);
  return DateTimeRange(
      name: "Tùy chọn ngày",
      type: DateTimeRangeType.DAY,
      startDate: today.startDate,
      endDate: today.endDate);
}

DateTimeRange getTimeRangeLastMonth([DateTime? date]) {
  var now = date ?? DateTime.now();
  return DateTimeRange(
      name: "Tháng trước",
      type: DateTimeRangeType.MONTH,
      startDate: DateTime(now.year, now.month - 1, 1, 0, 0, 0),
      endDate: getFirstDateOfMonth(now).add(const Duration(microseconds: -1)));
}

DateTimeRange getTimeRangeThisYear([DateTime? date]) {
  var now = date ?? DateTime.now();
  return DateTimeRange(
      name: "Năm nay",
      type: DateTimeRangeType.YEAR,
      startDate: DateTime(now.year, 1, 1, 0, 0, 0),
      endDate: DateTime(now.year, 12, 31, 23, 59, 59, 999, 999));
}

DateTimeRange getTimeRangeLastYear([DateTime? date]) {
  var now = date ?? DateTime.now();
  return DateTimeRange(
      name: "Năm trước",
      type: DateTimeRangeType.YEAR,
      startDate: DateTime(now.year - 1, 1, 1, 0, 0, 0),
      endDate: DateTime(now.year - 1, 12, 31, 23, 59, 59, 999, 999));
}

String datetimeToStringSort(DateTime date, [DateTime? toDay]) {
  var now = toDay ?? DateTime.now();
  if (date.year == now.year && date.month == now.month) {
    return DateFormat("dd").format(date);
  } else if (date.year == now.year) {
    return DateFormat("dd/MM").format(date);
  } else {
    return DateFormat("dd/MM/yyyy").format(date);
  }
}

class DartDateUtils {
  DartDateUtils._internal();
  static DateTime changeDate(DateTime current, DateTime changeDate) {
    return current.copyWith(
        year: changeDate.year, month: changeDate.month, day: changeDate.day);
  }

  static DateTime addDaysToDateTime(DateTime source, int days) {
    return source.add(Duration(days: days));
  }

  static DateTime addHoursToDateTime(DateTime source, int hours) {
    return source.add(Duration(hours: hours));
  }

  static DateTime addMinutesToDateTime(DateTime source, int minutes) {
    return source.add(Duration(minutes: minutes));
  }
}
