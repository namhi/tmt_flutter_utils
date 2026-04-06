import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tmt_flutter_utils/tmt_flutter_utils.dart';

void main() {
  group('WidgetExtensions', () {
    group('padding', () {
      test('should wrap widget with Padding.all when all is provided', () {
        const widget = Text('Test');
        const padded = widget.padding(all: 16);

        expect(padded, isA<Padding>());
        expect(
          (padded as Padding).padding,
          const EdgeInsets.all(16),
        );
      });

      test('should wrap widget with Padding.only when individual values provided', () {
        const widget = Text('Test');
        const padded = widget.padding(left: 8, top: 16, right: 8, bottom: 16);

        expect(padded, isA<Padding>());
        expect(
          (padded as Padding).padding,
          const EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 16),
        );
      });

      test('should set key on Padding widget when provided', () {
        const widget = Text('Test');
        const key = Key('test-key');
        const padded = widget.padding(
          left: 8,
          top: 16,
          right: 8,
          bottom: 16,
          key: key,
        );

        expect((padded as Padding).key, key);
      });

      test('should preserve child widget', () {
        const widget = Text('Test');
        const padded = widget.padding(all: 16);

        expect((padded as Padding).child, widget);
      });
    });

    group('paddingLeft', () {
      test('should wrap widget with left padding', () {
        const widget = Text('Test');
        const padded = widget.paddingLeft(value: 16);

        expect(padded, isA<Padding>());
        expect(
          (padded as Padding).padding,
          const EdgeInsets.only(left: 16),
        );
      });

      test('should set key when provided', () {
        const widget = Text('Test');
        const key = Key('test-key');
        const padded = widget.paddingLeft(value: 16, key: key);

        expect((padded as Padding).key, key);
      });
    });

    group('paddingTop', () {
      test('should wrap widget with top padding', () {
        const widget = Text('Test');
        const padded = widget.paddingTop(value: 16);

        expect(padded, isA<Padding>());
        expect(
          (padded as Padding).padding,
          const EdgeInsets.only(top: 16),
        );
      });

      test('should set key when provided', () {
        const widget = Text('Test');
        const key = Key('test-key');
        const padded = widget.paddingTop(value: 16, key: key);

        expect((padded as Padding).key, key);
      });
    });

    group('paddingRight', () {
      test('should wrap widget with right padding', () {
        const widget = Text('Test');
        const padded = widget.paddingRight(value: 16);

        expect(padded, isA<Padding>());
        expect(
          (padded as Padding).padding,
          const EdgeInsets.only(right: 16),
        );
      });

      test('should set key when provided', () {
        const widget = Text('Test');
        const key = Key('test-key');
        const padded = widget.paddingRight(value: 16, key: key);

        expect((padded as Padding).key, key);
      });
    });

    group('paddingBottom', () {
      test('should wrap widget with bottom padding', () {
        const widget = Text('Test');
        const padded = widget.paddingBottom(value: 16);

        expect(padded, isA<Padding>());
        expect(
          (padded as Padding).padding,
          const EdgeInsets.only(bottom: 16),
        );
      });

      test('should set key when provided', () {
        const widget = Text('Test');
        const key = Key('test-key');
        const padded = widget.paddingBottom(value: 16, key: key);

        expect((padded as Padding).key, key);
      });
    });

    group('sliverToBox', () {
      test('should wrap widget with SliverToBoxAdapter', () {
        const widget = Text('Test');
        const sliver = widget.sliverToBox();

        expect(sliver, isA<SliverToBoxAdapter>());
        expect((sliver as SliverToBoxAdapter).child, widget);
      });

      test('should set key when provided', () {
        const widget = Text('Test');
        const key = Key('test-key');
        const sliver = widget.sliverToBox(key: key);

        expect((sliver as SliverToBoxAdapter).key, key);
      });
    });
  });

  group('TextEditingControllerEx', () {
    group('selectAll', () {
      test('should select all text in controller', () {
        final controller = TextEditingController(text: 'Hello World');
        controller.selectAll();

        expect(controller.selection.baseOffset, 0);
        expect(controller.selection.extentOffset, 11); // 'Hello World'.length
      });

      test('should select all text for empty string', () {
        final controller = TextEditingController(text: '');
        controller.selectAll();

        expect(controller.selection.baseOffset, 0);
        expect(controller.selection.extentOffset, 0);
      });

      test('should select all text for single character', () {
        final controller = TextEditingController(text: 'A');
        controller.selectAll();

        expect(controller.selection.baseOffset, 0);
        expect(controller.selection.extentOffset, 1);
      });
    });

    group('select', () {
      test('should select text with specified offsets', () {
        final controller = TextEditingController(text: 'Hello World');
        controller.select(baseOffset: 0, extentOffset: 5);

        expect(controller.selection.baseOffset, 0);
        expect(controller.selection.extentOffset, 5);
      });

      test('should select text with custom affinity', () {
        final controller = TextEditingController(text: 'Hello World');
        controller.select(
          baseOffset: 0,
          extentOffset: 5,
          affinity: TextAffinity.upstream,
        );

        expect(controller.selection.affinity, TextAffinity.upstream);
      });

      test('should select text with directional selection', () {
        final controller = TextEditingController(text: 'Hello World');
        controller.select(
          baseOffset: 0,
          extentOffset: 5,
          isDirectional: true,
        );

        expect(controller.selection.isDirectional, true);
      });

      test('should select reversed range', () {
        final controller = TextEditingController(text: 'Hello World');
        controller.select(baseOffset: 5, extentOffset: 0);

        expect(controller.selection.baseOffset, 5);
        expect(controller.selection.extentOffset, 0);
      });

      test('should select entire text using offsets', () {
        final controller = TextEditingController(text: 'Hello World');
        controller.select(baseOffset: 0, extentOffset: 11);

        expect(controller.selection.baseOffset, 0);
        expect(controller.selection.extentOffset, 11);
      });
    });
  });
}
