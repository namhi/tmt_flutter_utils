library tmt_flutter_utils;

import 'package:flutter/material.dart' as material;

class FlutterDateUtils {
  FlutterDateUtils._internal();
  static DateTime changeTime(DateTime current, material.TimeOfDay timeOfDay) {
    return current.copyWith(
        hour: timeOfDay.hour,
        minute: timeOfDay.minute,
        second: 0,
        millisecond: 0);
  }
}
