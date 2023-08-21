import 'package:flutter/material.dart' as material;
import 'package:intl/intl.dart';

import 'datetime_util.dart';
import 'package:timeago/timeago.dart' as timeAgo;

extension DateTimeExtensions on DateTime {
  String toDayOfWeek(String locate) {
    String dayOfWeekString = "";
    switch (this.weekday) {
      case 1:
        switch (locate) {
          case "vi-VN":
            dayOfWeekString = "Thứ hai";
            break;
          case "en-US":
            dayOfWeekString = "Monday";
            break;
          default:
            dayOfWeekString = "Monday";
        }
        break;
      case 2:
        switch (locate) {
          case "vi-VN":
            dayOfWeekString = "Thứ ba";
            break;
          case "en-US":
            dayOfWeekString = "Tuesday";
            break;
          default:
            dayOfWeekString = "Tuesday";
        }
        break;
      case 3:
        switch (locate) {
          case "vi-VN":
            dayOfWeekString = "Thứ tư";
            break;
          case "en-US":
            dayOfWeekString = "Wednesday";
            break;
          default:
            dayOfWeekString = "Wednesday";
        }
        break;
      case 4:
        switch (locate) {
          case "vi-VN":
            dayOfWeekString = "Thứ năm";
            break;
          case "en-US":
            dayOfWeekString = "Thursday";
            break;
          default:
            dayOfWeekString = "Thursday";
        }
        break;
      case 5:
        switch (locate) {
          case "vi-VN":
            dayOfWeekString = "Thứ sáu";
            break;
          case "en-US":
            dayOfWeekString = "Friday";
            break;
          default:
            dayOfWeekString = "Friday";
        }
        break;
      case 6:
        switch (locate) {
          case "vi-VN":
            dayOfWeekString = "Thứ bảy";
            break;
          case "en-US":
            dayOfWeekString = "Saturday";
            break;
          default:
            dayOfWeekString = "Saturday";
        }
        break;
      case 7:
        switch (locate) {
          case "vi-VN":
            dayOfWeekString = "Chủ nhật";
            break;
          case "en-US":
            dayOfWeekString = "Sunday";
            break;
          default:
            dayOfWeekString = "Sunday";
        }
        break;
    }
    return dayOfWeekString;
  }

  /// Trả về kiểu ngắn gọn của ngày tháng. Ví dụ
  /// 23 cho ngày 23/tháng hiện tại/năm hiện tại
  /// 22/11 cho ngày 22/11/năm hiện tại
  /// 22/11/2018 cho ngày 22/11/2018
  ///
  String toStringSort() {
    return datetimeToStringSort(this);
  }

  String toStringFormat(String format) {
    return DateFormat(format).format(this);
  }

  DateTime changeDate(DateTime input) => DateUtils.changeDate(this, input);
  DateTime changeTime(material.TimeOfDay timeOfDay) =>
      DateUtils.changeTime(this, timeOfDay);

  String toTimeAgo(String local) {
    return timeAgo.format(this, locale: local);
  }

  DateTime clearTime() {
    return this.copyWith(
        hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  }

  DateTime setLastDay() {
    return this.copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);
  }

  /// Returns a [DateTime] with the added number of days and time set to
  /// midnight.
  DateTime addDaysToDate(int days) =>
      material.DateUtils.addDaysToDate(this, days);

  /// Returns a [DateTime] with the added number of days.
  DateTime addDays(int days) => DateUtils.addDaysToDateTime(this, days);

  /// Returns a [DateTime] with the added number of hours.
  DateTime addHours(int hours) => DateUtils.addHoursToDateTime(this, hours);

  /// Returns a [DateTime] with the added number of minutes.
  DateTime addMinutes(int minutes) =>
      DateUtils.addMinutesToDateTime(this, minutes);

  /// Returns true if the two [DateTime] objects have the same day, month, and
  /// year, or are both null.
  bool isSameDayWith(DateTime dateB) =>
      material.DateUtils.isSameDay(this, dateB);

  /// Returns true if the two [DateTime] objects have the same month and
  /// year, or are both null.
  bool isSameMonthWith(DateTime dateB) =>
      material.DateUtils.isSameMonth(this, dateB);
}
