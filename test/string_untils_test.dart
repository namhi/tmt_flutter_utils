import 'package:flutter_test/flutter_test.dart';
import 'package:tmt_flutter_utils/sources/string_utils/string_utils.dart';
import 'package:tmt_flutter_utils/tmt_flutter_utils.dart';

void main() {
  test('Extract Email when string is contain email', () {
    String? result1 =
        StringUtils.extractEmail('Chuỗi này chứa kinh@tmtsofts.com');
    String? result2 =
        StringUtils.extractEmail('Chuỗi này chứa nam.nvdlkjf@tmtsofts.com');
    expect(result2, 'nam.nvdlkjf@tmtsofts.com');
    expect(result1, 'kinh@tmtsofts.com');
  });
  test('Extract email when string is null', () {});
  test('Extract email when string is empty', () {
    final String s = '';
    final String? result = StringUtils.extractEmail(s);
    expect(result, null);
  });

  // Case 1. String is contain valid phone number
  test('Test extractPhoneNumber when String contain valid phone number', () {
    String s = 'Toi ne 012345678';
    final String? result = StringUtils.extractPhoneNumber(s);
    expect(result, '012345678');
  });
  // Case 1. String is phonenumber
  test('Test extractPhoneNumber when String contain valid phone number', () {
    String s = '012345678';
    final String? result = StringUtils.extractPhoneNumber(s);
    expect(result, '012345678');
  });

  test(
      'Test extractPhoneNumber return null when String is not contain valid phone number',
      () {
    String s = 'This string is not contain phone number';
    final String? result = StringUtils.extractPhoneNumber(s);
    expect(result, null);
  });

  test(
      'Test extractPhoneNumber return null when String is contain a not valid phone number',
      () {
    String s = 'This string is not contain phone number 090807545';
    final String? result = StringUtils.extractPhoneNumber(s);
    expect(result, null);
  });

  test('Test convert String to number by LanguageCode', () {
    List<_ValueResult> _data = [
      _ValueResult(value: '12345', result: 12345),
      _ValueResult(value: '12345.6', result: 12345.6),
      _ValueResult(value: '12345,6', result: 12345.6),
      _ValueResult(value: '12.345,6', result: 12345.6),
      _ValueResult(value: '12,345.6', result: 12345.6),
    ];

    for (final itm in _data) {
      final result = StringUtils.tryToNum(
        itm.value,
        separate: '.',
        decimalPlace: ',',
      );
      print(result);
    }
  });

  test('Get phone number from text', () {
    final input = 'Sục nơ 39 0984017429';
    final result = StringUtils.getPhoneNumberFromText(input,
        pattern:
            r'(?:\b|[^0-9])((o|0|84|\+84)(\s?)([2-9]|1[0-9])((\d|o)(\s+|\.)?){8})(?:\b|[^0-9])');

    expect(result, '0984017429');
  });
}

class _ValueResult {
  _ValueResult({required this.value, required this.result});
  String value;
  num result;
}
