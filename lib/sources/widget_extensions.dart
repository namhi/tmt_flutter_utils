import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget padding(
      {double all,
      double left,
      double top,
      double right,
      double bottom,
      Key key}) {
    if (all != null) {
      return Padding(padding: EdgeInsets.all(all));
    }
    return Padding(
      key: key,
      padding:
          EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
      child: this,
    );
  }

  Widget sliverToBox({Key key}) => SliverToBoxAdapter(child: this, key: key);
}
