import 'package:flutter/material.dart' as material;
import 'flutter_datetime_util.dart';

extension FlutterDateTimeExtensions on DateTime {
  DateTime changeTime(material.TimeOfDay timeOfDay) =>
      FlutterDateUtils.changeTime(this, timeOfDay);

  /// Returns a [DateTime] with the added number of days and time set to
  /// midnight.
  DateTime addDaysToDate(int days) =>
      material.DateUtils.addDaysToDate(this, days);

  /// Returns true if the two [DateTime] objects have the same day, month, and
  /// year, or are both null.
  bool isSameDayWith(DateTime dateB) =>
      material.DateUtils.isSameDay(this, dateB);

  /// Returns true if the two [DateTime] objects have the same month and
  /// year, or are both null.
  bool isSameMonthWith(DateTime dateB) =>
      material.DateUtils.isSameMonth(this, dateB);
}
