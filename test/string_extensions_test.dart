import 'package:flutter_test/flutter_test.dart';
import 'package:tmt_flutter_untils/tmt_flutter_extensions.dart';

void main() {
  test('toStringFormat ', () {
    final List<_TestEntry> _tests = <_TestEntry>[
      _TestEntry(number: 1, format: '###,###,###', trueValue: '1'),
      _TestEntry(number: 1.0, format: '###,###,###', trueValue: '1'),
      _TestEntry(number: 1000, format: '###,###,###', trueValue: '1,000'),
      _TestEntry(number: 1000.01, format: '###,###,###', trueValue: '1,000'),
      _TestEntry(
          number: 1000.01, format: '###,###,###.##', trueValue: '1,000.01'),
      // Ngôn ngữ tiếng Việt
      _TestEntry(
          number: 1000.01,
          format: '###,###,###.##',
          trueValue: '1.000,01',
          locate: 'vi-VN'),
      _TestEntry(
          number: 1000.01,
          format: '###,###,###.##',
          trueValue: '1.000,01',
          locate: 'vi_VN'),
      // Ngôn ngữ tiếng anh
      _TestEntry(
          number: 1000.01,
          format: '###,###,###.##',
          trueValue: '1,000.01',
          locate: 'en-US'),
    ];

    for (_TestEntry entry in _tests) {
      if (entry.number != null) {
        final String result =
            entry.number.toStringFormat(entry.format, locate: entry.locate);
        expect(result, entry.trueValue);
      } else {
        final String result =
            entry.number.toStringFormat(entry.format, locate: entry.locate);
      }
    }
  });
}

class _TestEntry {
  num number;
  String format;
  String trueValue;

  String locate;
  _TestEntry({this.number, this.format, this.trueValue, this.locate});
}
