import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tmt_flutter_untils/sources/string_utils/string_utils.dart';

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
    String s = 'Toi ne 0908075455';
    final String? result = StringUtils.extractPhoneNumber(s);
    expect(result, '0908075455');
  });
  // Case 1. String is phonenumber
  test('Test extractPhoneNumber when String contain valid phone number', () {
    String s = '0908075455';
    final String? result = StringUtils.extractPhoneNumber(s);
    expect(result, '0908075455');
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
}
