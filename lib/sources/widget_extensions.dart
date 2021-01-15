import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget padding(
      {double all, double left, double top, double right, double bottom}) {
    if (all != null) {
      return Padding(padding: EdgeInsets.all(all));
    }
    return Padding(
      padding:
          EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
    );
  }
}
