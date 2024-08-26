import 'dart:async';
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

  /// Return true if screen current is phone.
  bool get isPhone => mediaQueryShortestSide < 660;
  bool get isSmallTablet => mediaQueryShortestSide >= 600;
  bool get isLargeTablet => mediaQueryShortestSide >= 720;

  /// Return true if screen current is tablet.
  bool get isTablet => isSmallTablet || isLargeTablet;
  bool get isKeyboardOpen => MediaQuery.of(this).viewInsets.bottom != 0;

  /// Get widget of T base on  media query size
  /// Return [mobile], [desktop] and [tablet]
  /// Return default mobile if one of theme is null.
  T? responsiveWidget<T>({T? mobile, T? tablet, T? desktop}) {
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

  /// Return widget of T base on current Platform is [ios], [android]. All other
  /// return [other] if param is not null, other wise return android.
  T? responsivePlatform<T>({T? ios, T? android, required T other}) {
    if (Platform.isIOS && ios != null) {
      return ios;
    }
    if (Platform.isAndroid && android != null) {
      return android;
    }
    if (other != null) {
      return other;
    } else {
      return android;
    }
  }

  /// Call FocusScope.of(context).requestFocus(FocusNode()) to close a keyboard
  void closeKeyboard() {
    unfocus();
  }

  /// Un focus all field on screen.
  void unfocus() {
    FocusScope.of(this).unfocus();
  }

  void pop<T extends Object?>([T? result]) {
    if (Navigator.of(this).canPop()) {
      Navigator.of(this).pop<T>(result);
    }
  }

  Future<T?> materialPush<T extends Object?>(Widget page) async =>
      await Navigator.of(this).push<T>(
        MaterialPageRoute<T>(
          builder: (context) => page,
        ),
      );

  Future<T?> pushNamed<T extends Object?>(String routeName,
          [Object? arguments]) =>
      Navigator.of(this).pushNamed<T>(
        routeName,
        arguments: arguments,
      );
}
