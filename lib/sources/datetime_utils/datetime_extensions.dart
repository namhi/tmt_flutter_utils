import 'package:flutter/material.dart' as material;
import 'package:intl/intl.dart';

import 'datetime_until.dart';
import 'package:timeago/timeago.dart' as timeAgo;

extension DateTimeExtensions on DateTime {
  String toDayOfWeek(String locate) {
    var dayOfWeek = this.weekday;
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
    return DateTime(year, month, day, 0, 0, 0);
  }
}
