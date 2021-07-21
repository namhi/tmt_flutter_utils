import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Padding padding(
      {double? all,
      double? left,
      double? top,
      double? right,
      double? bottom,
      Key? key}) {
    if (all != null) {
      return Padding(padding: EdgeInsets.all(all));
    }
    return Padding(
      key: key,
      padding: EdgeInsets.only(
          left: left!, top: top!, right: right!, bottom: bottom!),
      child: this,
    );
  }

  Widget sliverToBox({Key? key}) => SliverToBoxAdapter(child: this, key: key);
}

extension TextEditingControllerEx on TextEditingController {
  /// Select all text from textfield.
  void selectAll() {
    this.selection =
        TextSelection(baseOffset: 0, extentOffset: this.text.length);
  }

  /// Select text from TextField with TextSelection.
  void select({
    required int baseOffset,
    required int extentOffset,
    TextAffinity affinity = TextAffinity.downstream,
    bool isDirectional = false,
  }) {
    this.selection = TextSelection(
      baseOffset: baseOffset,
      extentOffset: extentOffset,
      affinity: affinity,
      isDirectional: isDirectional,
    );
  }
}
