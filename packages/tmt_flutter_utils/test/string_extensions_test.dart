import 'package:flutter_test/flutter_test.dart';
import 'package:tmt_dart_utils/tmt_dart_extensions.dart';

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
            entry.number!.toStringFormat(entry.format, locate: entry.locate);
        expect(result, entry.trueValue);
      } else {}
    }
  });

  test('Test isPhoneNumber list', () {
    final Map<String, bool> testValues = {
      '012345678': true,
      '0379566994': true,
      '0903545466': true,
      '0863545466': true,
      '0963545466': true,
      '09abc09394': false,
    };

    for (final String itm in testValues.keys) {
      print('test $itm');
      bool result = itm.isPhoneNumber;
      expect(result, testValues[itm]);
    }
  });
}

class _TestEntry {
  num? number;
  String? format;
  String? trueValue;

  String? locate;
  _TestEntry({this.number, this.format, this.trueValue, this.locate});
}
