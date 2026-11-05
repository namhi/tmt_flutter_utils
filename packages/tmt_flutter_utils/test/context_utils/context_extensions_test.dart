import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tmt_flutter_utils/tmt_flutter_utils.dart';

void main() {
  group('ContextExtensions', () {
    /// Pumps a MaterialApp with a controlled [MediaQuery] and captures the
    /// BuildContext below it, so [ContextExtensions] read real widget-tree
    /// data instead of a mocked framework.
    Future<BuildContext> pumpContext(
      WidgetTester tester, {
      Size size = const Size(375, 667),
      EdgeInsets viewInsets = EdgeInsets.zero,
      EdgeInsets viewPadding = EdgeInsets.zero,
      Widget? child,
    }) async {
      late BuildContext captured;
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(
              size: size,
              viewInsets: viewInsets,
              viewPadding: viewPadding,
            ),
            child: Builder(
              builder: (context) {
                captured = context;
                return child ?? const SizedBox.shrink(key: Key('home'));
              },
            ),
          ),
        ),
      );
      return captured;
    }

    /// Pumps a bare Builder with NO MediaQuery ancestor.
    Future<BuildContext> pumpWithoutMediaQuery(WidgetTester tester) async {
      late BuildContext captured;
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            captured = context;
            return const SizedBox.shrink();
          },
        ),
      );
      return captured;
    }

    group('mediaQuerySize', () {
      testWidgets('should return media query size', (tester) async {
        final context = await pumpContext(tester, size: const Size(375, 667));
        expect(context.mediaQuerySize, const Size(375, 667));
      });
    });

    group('height', () {
      testWidgets('should return height from media query size', (tester) async {
        final context = await pumpContext(tester, size: const Size(375, 667));
        expect(context.height, 667.0);
      });

      testWidgets('should fall back to the view size when no MediaQuery ancestor exists',
          (tester) async {
        // Modern Flutter: MediaQuery.of falls back to the attached view's size
        // (default test surface is 800x600) instead of throwing.
        final context = await pumpWithoutMediaQuery(tester);
        expect(context.height, 600.0);
      });
    });

    group('width', () {
      testWidgets('should return width from media query size', (tester) async {
        final context = await pumpContext(tester, size: const Size(375, 667));
        expect(context.width, 375.0);
      });
    });

    group('theme', () {
      testWidgets('should return theme', (tester) async {
        final context = await pumpContext(tester);
        expect(context.theme, isA<ThemeData>());
      });
    });

    group('textTheme', () {
      testWidgets('should return text theme from theme', (tester) async {
        final context = await pumpContext(tester);
        expect(context.textTheme, isA<TextTheme>());
      });
    });

    group('mediaQueryViewInsets', () {
      testWidgets('should return media query view insets', (tester) async {
        final context = await pumpContext(tester);
        expect(context.mediaQueryViewInsets, EdgeInsets.zero);
      });

      testWidgets('should return non-zero insets when keyboard is open',
          (tester) async {
        final context = await pumpContext(
          tester,
          viewInsets: const EdgeInsets.only(bottom: 300),
        );
        expect(
          context.mediaQueryViewInsets,
          const EdgeInsets.only(bottom: 300),
        );
      });
    });

    group('mediaQueryViewPadding', () {
      testWidgets('should return media query view padding', (tester) async {
        final context = await pumpContext(
          tester,
          viewPadding: const EdgeInsets.only(top: 24),
        );
        expect(context.mediaQueryViewPadding, const EdgeInsets.only(top: 24));
      });
    });

    group('mediaQueryShortestSide', () {
      testWidgets('should return shortest side from media query size',
          (tester) async {
        final context = await pumpContext(tester, size: const Size(375, 667));
        expect(context.mediaQueryShortestSide, 375.0);
      });

      testWidgets('should return width for landscape orientation',
          (tester) async {
        final context = await pumpContext(tester, size: const Size(800, 375));
        expect(context.mediaQueryShortestSide, 375.0);
      });
    });

    group('isPhone', () {
      testWidgets('should return true for phone screen size', (tester) async {
        final context = await pumpContext(tester, size: const Size(375, 667));
        expect(context.isPhone, isTrue);
      });

      testWidgets('should return false for tablet screen size',
          (tester) async {
        final context = await pumpContext(tester, size: const Size(768, 1024));
        expect(context.isPhone, isFalse);
      });

      testWidgets('should return true for small tablet near threshold',
          (tester) async {
        final context = await pumpContext(tester, size: const Size(659, 900));
        expect(context.isPhone, isTrue);
      });
    });

    group('isSmallTablet', () {
      testWidgets('should return true for small tablet', (tester) async {
        final context = await pumpContext(tester, size: const Size(600, 800));
        expect(context.isSmallTablet, isTrue);
      });

      testWidgets('should return false for phone', (tester) async {
        final context = await pumpContext(tester, size: const Size(375, 667));
        expect(context.isSmallTablet, isFalse);
      });

      testWidgets('should return true for large tablet', (tester) async {
        final context = await pumpContext(tester, size: const Size(720, 1024));
        expect(context.isSmallTablet, isTrue);
      });
    });

    group('isLargeTablet', () {
      testWidgets('should return true for large tablet', (tester) async {
        final context = await pumpContext(tester, size: const Size(720, 1024));
        expect(context.isLargeTablet, isTrue);
      });

      testWidgets('should return false for small tablet', (tester) async {
        final context = await pumpContext(tester, size: const Size(600, 800));
        expect(context.isLargeTablet, isFalse);
      });

      testWidgets('should return false for phone', (tester) async {
        final context = await pumpContext(tester, size: const Size(375, 667));
        expect(context.isLargeTablet, isFalse);
      });
    });

    group('isTablet', () {
      testWidgets('should return true for small tablet', (tester) async {
        final context = await pumpContext(tester, size: const Size(600, 800));
        expect(context.isTablet, isTrue);
      });

      testWidgets('should return true for large tablet', (tester) async {
        final context = await pumpContext(tester, size: const Size(720, 1024));
        expect(context.isTablet, isTrue);
      });

      testWidgets('should return false for phone', (tester) async {
        final context = await pumpContext(tester, size: const Size(375, 667));
        expect(context.isTablet, isFalse);
      });
    });

    group('isKeyboardOpen', () {
      testWidgets('should return true when keyboard is open', (tester) async {
        final context = await pumpContext(
          tester,
          viewInsets: const EdgeInsets.only(bottom: 300),
        );
        expect(context.isKeyboardOpen, isTrue);
      });

      testWidgets('should return false when keyboard is closed',
          (tester) async {
        final context = await pumpContext(tester);
        expect(context.isKeyboardOpen, isFalse);
      });

      testWidgets('should return false when viewInsets has only vertical padding',
          (tester) async {
        final context = await pumpContext(
          tester,
          viewInsets: const EdgeInsets.only(top: 44),
        );
        expect(context.isKeyboardOpen, isFalse);
      });
    });

    group('responsiveWidget', () {
      testWidgets('should return mobile widget for phone size', (tester) async {
        final context = await pumpContext(tester, size: const Size(375, 667));
        const mobile = FakeWidget(key: Key('mobile'));
        const tablet = FakeWidget(key: Key('tablet'));

        final result = context.responsiveWidget(mobile: mobile, tablet: tablet);
        expect(result?.key, mobile.key);
      });

      testWidgets('should return tablet widget for tablet size',
          (tester) async {
        final context = await pumpContext(tester, size: const Size(768, 1024));
        const mobile = FakeWidget(key: Key('mobile'));
        const tablet = FakeWidget(key: Key('tablet'));

        final result = context.responsiveWidget(mobile: mobile, tablet: tablet);
        expect(result?.key, tablet.key);
      });

      testWidgets('should return desktop widget for large size',
          (tester) async {
        // shortestSide must reach the 1200 desktop threshold
        final context = await pumpContext(tester, size: const Size(1400, 1300));
        const mobile = FakeWidget(key: Key('mobile'));
        const tablet = FakeWidget(key: Key('tablet'));
        const desktop = FakeWidget(key: Key('desktop'));

        final result = context.responsiveWidget(
          mobile: mobile,
          tablet: tablet,
          desktop: desktop,
        );
        expect(result?.key, desktop.key);
      });

      testWidgets('should return mobile when tablet widget is null',
          (tester) async {
        final context = await pumpContext(tester, size: const Size(768, 1024));
        const mobile = FakeWidget(key: Key('mobile'));

        final result = context.responsiveWidget(mobile: mobile);
        expect(result?.key, mobile.key);
      });

      testWidgets('should return null when all widgets are null',
          (tester) async {
        final context = await pumpContext(tester, size: const Size(375, 667));
        final result = context.responsiveWidget();
        expect(result, isNull);
      });
    });

    group('closeKeyboard', () {
      testWidgets('should unfocus the focused node', (tester) async {
        final node = FocusNode();
        final context = await pumpContext(
          tester,
          child: Focus(focusNode: node, child: const SizedBox.shrink()),
        );

        node.requestFocus();
        await tester.pump();
        expect(node.hasFocus, isTrue);

        context.closeKeyboard();
        await tester.pump();
        expect(node.hasFocus, isFalse);
      });
    });

    group('unfocus', () {
      testWidgets('should unfocus the focused node', (tester) async {
        final node = FocusNode();
        final context = await pumpContext(
          tester,
          child: Focus(focusNode: node, child: const SizedBox.shrink()),
        );

        node.requestFocus();
        await tester.pump();
        expect(node.hasFocus, isTrue);

        context.unfocus();
        await tester.pump();
        expect(node.hasFocus, isFalse);
      });
    });

    group('pop', () {
      testWidgets('should pop navigator when canPop returns true',
          (tester) async {
        late BuildContext captured;
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                return const SizedBox.shrink(key: Key('home'));
              },
            ),
          ),
        );
        final navigator = tester.state<NavigatorState>(find.byType(Navigator));
        final popped = navigator.push<bool>(
          MaterialPageRoute(
            builder: (context) {
              captured = context;
              return const Scaffold(body: SizedBox.shrink(key: Key('page2')));
            },
          ),
        );
        await tester.pumpAndSettle();
        expect(navigator.canPop(), isTrue);

        captured.pop();
        final result = await popped;
        expect(result, isNull);
        // Let the pop transition finish before asserting the page is gone
        await tester.pumpAndSettle();
        expect(find.byKey(const Key('page2')), findsNothing);
      });

      testWidgets('should not pop navigator when canPop returns false',
          (tester) async {
        final context = await pumpContext(tester);
        final navigator = tester.state<NavigatorState>(find.byType(Navigator));
        expect(navigator.canPop(), isFalse);

        context.pop();
        await tester.pump();
        expect(find.byKey(const Key('home')), findsOneWidget);
      });

      testWidgets('should pop with result when provided', (tester) async {
        late BuildContext captured;
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                return const SizedBox.shrink(key: Key('home'));
              },
            ),
          ),
        );
        final navigator = tester.state<NavigatorState>(find.byType(Navigator));
        final popped = navigator.push<String>(
          MaterialPageRoute(
            builder: (context) {
              captured = context;
              return const Scaffold(body: SizedBox.shrink(key: Key('page2')));
            },
          ),
        );
        await tester.pumpAndSettle();

        captured.pop('result');
        final result = await popped;
        expect(result, 'result');
      });
    });
  });
}

class FakeWidget extends StatelessWidget {
  const FakeWidget({super.key});

  @override
  Widget build(BuildContext context) => const Placeholder();
}
