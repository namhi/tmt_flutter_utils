import 'dart:io';

import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  Size get mediaQuerySize => MediaQuery.of(this).size;
  double get height => mediaQuerySize.height;
  double get width => mediaQuerySize.width;

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;

  EdgeInsets get mediaQueryViewInsets => MediaQuery.of(this).viewInsets;
  EdgeInsets get mediaQueryViewPadding => MediaQuery.of(this).viewPadding;
  double get mediaQueryShortestSide => mediaQuerySize.shortestSide;

  bool get isPhone => mediaQueryShortestSide < 660;
  bool get isTablet => mediaQueryShortestSide >= 720;
  bool get isKeyboardOpen => MediaQuery.of(this).viewInsets.bottom != 0;

  /// Get widget of T base on  media query size
  T responsiveWidget<T>({T mobile, T tablet, T desktop}) {
    double width = mediaQuerySize.shortestSide;
    if (Platform.isWindows) {
      width = mediaQuerySize.width;
    }

    if (width >= 1200 && desktop != null) {
      return desktop;
    }
    if (width >= 600 && tablet != null) {
      return tablet;
    }
    return mobile;
  }
}
