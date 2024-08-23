import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as time_ago;
import 'package:tmt_dart_utils/tmt_dart_utils.dart';

extension DartDateTimeExtensions on DateTime {
  String toDayOfWeek(String locate) {
    String dayOfWeekString = "";
    switch (weekday) {
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

  String toStringFormat(String format) {
    return DateFormat(format).format(this);
  }

  String toTimeAgo(String local) {
    return time_ago.format(this, locale: local);
  }

  DateTime clearTime() {
    return copyWith(
        hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  }

  DateTime setLastDay() {
    return copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);
  }

  /// Returns a [DateTime] with the added number of hours.
  DateTime addHours(int hours) => DartDateUtils.addHoursToDateTime(this, hours);

  /// Returns a [DateTime] with the added number of days.
  DateTime addDays(int days) => DartDateUtils.addDaysToDateTime(this, days);

  /// Returns a [DateTime] with the added number of minutes.
  DateTime addMinutes(int minutes) =>
      DartDateUtils.addMinutesToDateTime(this, minutes);
}
