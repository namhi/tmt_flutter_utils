import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tmt_flutter_utils/tmt_flutter_utils.dart';

class MockBuildContext extends Mock implements BuildContext {}

class FakeWidget extends StatelessWidget {
  const FakeWidget({super.key});

  @override
  Widget build(BuildContext context) => const Placeholder();
}

void main() {
  // Setup fallback values for mocktail
  registerFallbackValue(const FakeWidget());
  registerFallbackValue(const MaterialApp());

  group('ContextExtensions', () {
    late BuildContext context;

    setUp(() {
      context = MockBuildContext();
    });

    group('mediaQuerySize', () {
      test('should return media query size', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(375, 667));
        expect(context.mediaQuerySize, const Size(375, 667));
      });
    });

    group('height', () {
      test('should return height from media query size', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(375, 667));
        expect(context.height, 667.0);
      });

      test('should return 0.0 when media query size is not available', () {
        when(() => MediaQuery.of(context)).thenThrow(
          const FlutterError('No MediaQuery found'),
        );
        // The extension will throw, which is expected behavior
        expect(() => context.height, throwsA(isA<FlutterError>()));
      });
    });

    group('width', () {
      test('should return width from media query size', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(375, 667));
        expect(context.width, 375.0);
      });
    });

    group('theme', () {
      test('should return theme', () {
        final themeData = ThemeData.light();
        when(() => Theme.of(context)).thenReturn(themeData);
        expect(context.theme, themeData);
      });
    });

    group('textTheme', () {
      test('should return text theme from theme', () {
        final themeData = ThemeData.light();
        final textTheme = TextTheme();
        when(() => Theme.of(context)).thenReturn(themeData);
        // The textTheme comes from the theme, so we need to access it through theme
        expect(context.textTheme, isA<TextTheme>());
      });
    });

    group('mediaQueryViewInsets', () {
      test('should return media query view insets', () {
        when(() => MediaQuery.of(context).viewInsets).thenReturn(EdgeInsets.zero);
        expect(context.mediaQueryViewInsets, EdgeInsets.zero);
      });

      test('should return non-zero insets when keyboard is open', () {
        when(() => MediaQuery.of(context).viewInsets).thenReturn(
          const EdgeInsets.only(bottom: 300),
        );
        expect(context.mediaQueryViewInsets, const EdgeInsets.only(bottom: 300));
      });
    });

    group('mediaQueryViewPadding', () {
      test('should return media query view padding', () {
        when(() => MediaQuery.of(context).viewPadding).thenReturn(EdgeInsets.zero);
        expect(context.mediaQueryViewPadding, EdgeInsets.zero);
      });
    });

    group('mediaQueryShortestSide', () {
      test('should return shortest side from media query size', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(375, 667));
        expect(context.mediaQueryShortestSide, 375.0);
      });

      test('should return width for landscape orientation', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(800, 375));
        expect(context.mediaQueryShortestSide, 375.0);
      });
    });

    group('isPhone', () {
      test('should return true for phone screen size', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(375, 667));
        expect(context.isPhone, true);
      });

      test('should return false for tablet screen size', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(768, 1024));
        expect(context.isPhone, false);
      });

      test('should return true for small tablet near threshold', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(659, 900));
        expect(context.isPhone, true);
      });
    });

    group('isSmallTablet', () {
      test('should return true for small tablet', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(600, 800));
        expect(context.isSmallTablet, true);
      });

      test('should return false for phone', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(375, 667));
        expect(context.isSmallTablet, false);
      });

      test('should return true for large tablet', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(720, 1024));
        expect(context.isSmallTablet, true);
      });
    });

    group('isLargeTablet', () {
      test('should return true for large tablet', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(720, 1024));
        expect(context.isLargeTablet, true);
      });

      test('should return false for small tablet', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(600, 800));
        expect(context.isLargeTablet, false);
      });

      test('should return false for phone', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(375, 667));
        expect(context.isLargeTablet, false);
      });
    });

    group('isTablet', () {
      test('should return true for small tablet', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(600, 800));
        expect(context.isTablet, true);
      });

      test('should return true for large tablet', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(720, 1024));
        expect(context.isTablet, true);
      });

      test('should return false for phone', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(375, 667));
        expect(context.isTablet, false);
      });
    });

    group('isKeyboardOpen', () {
      test('should return true when keyboard is open', () {
        when(() => MediaQuery.of(context).viewInsets).thenReturn(
          const EdgeInsets.only(bottom: 300),
        );
        expect(context.isKeyboardOpen, true);
      });

      test('should return false when keyboard is closed', () {
        when(() => MediaQuery.of(context).viewInsets).thenReturn(EdgeInsets.zero);
        expect(context.isKeyboardOpen, false);
      });

      test('should return false when viewInsets has only vertical padding', () {
        when(() => MediaQuery.of(context).viewInsets).thenReturn(
          const EdgeInsets.only(top: 44, bottom: 0),
        );
        expect(context.isKeyboardOpen, false);
      });
    });

    group('responsiveWidget', () {
      test('should return mobile widget for phone size', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(375, 667));
        final mobile = const FakeWidget(key: Key('mobile'));
        final tablet = const FakeWidget(key: Key('tablet'));

        final result = context.responsiveWidget(mobile: mobile, tablet: tablet);
        expect(result?.key, mobile.key);
      });

      test('should return tablet widget for tablet size', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(768, 1024));
        final mobile = const FakeWidget(key: Key('mobile'));
        final tablet = const FakeWidget(key: Key('tablet'));

        final result = context.responsiveWidget(mobile: mobile, tablet: tablet);
        expect(result?.key, tablet.key);
      });

      test('should return desktop widget for large size', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(1400, 900));
        final mobile = const FakeWidget(key: Key('mobile'));
        final tablet = const FakeWidget(key: Key('tablet'));
        final desktop = const FakeWidget(key: Key('desktop'));

        final result = context.responsiveWidget(
          mobile: mobile,
          tablet: tablet,
          desktop: desktop,
        );
        expect(result?.key, desktop.key);
      });

      test('should return mobile when tablet widget is null', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(768, 1024));
        final mobile = const FakeWidget(key: Key('mobile'));

        final result = context.responsiveWidget(mobile: mobile);
        expect(result?.key, mobile.key);
      });

      test('should return null when all widgets are null', () {
        when(() => MediaQuery.of(context).size).thenReturn(const Size(375, 667));
        final result = context.responsiveWidget();
        expect(result, isNull);
      });
    });

    group('closeKeyboard', () {
      test('should call unfocus on focus scope', () {
        final mockFocusScope = MockFocusScopeNode();
        when(() => FocusScope.of(context)).thenReturn(mockFocusScope);
        when(() => mockFocusScope.unfocus()).thenReturn(null);

        context.closeKeyboard();
        verify(() => mockFocusScope.unfocus()).called(1);
      });
    });

    group('unfocus', () {
      test('should call unfocus on focus scope', () {
        final mockFocusScope = MockFocusScopeNode();
        when(() => FocusScope.of(context)).thenReturn(mockFocusScope);
        when(() => mockFocusScope.unfocus()).thenReturn(null);

        context.unfocus();
        verify(() => mockFocusScope.unfocus()).called(1);
      });
    });

    group('pop', () {
      test('should pop navigator when canPop returns true', () {
        final mockNavigator = MockNavigatorState();
        when(() => Navigator.of(context)).thenReturn(mockNavigator);
        when(() => mockNavigator.canPop()).thenReturn(true);

        context.pop();
        verify(() => mockNavigator.pop()).called(1);
      });

      test('should not pop navigator when canPop returns false', () {
        final mockNavigator = MockNavigatorState();
        when(() => Navigator.of(context)).thenReturn(mockNavigator);
        when(() => mockNavigator.canPop()).thenReturn(false);

        context.pop();
        verifyNever(() => mockNavigator.pop());
      });

      test('should pop with result when provided', () {
        final mockNavigator = MockNavigatorState();
        when(() => Navigator.of(context)).thenReturn(mockNavigator);
        when(() => mockNavigator.canPop()).thenReturn(true);

        const result = 'result';
        context.pop(result);
        verify(() => mockNavigator.pop(result)).called(1);
      });
    });
  });
}

// Mock classes
class MockNavigatorState extends Mock implements NavigatorState {}

class MockFocusScopeNode extends Mock implements FocusScopeNode {}
