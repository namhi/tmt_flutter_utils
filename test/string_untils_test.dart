import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tmt_flutter_untils/sources/string_utils/string_utils.dart';

void main() {
  test('Extract Email when string is contain email', () {
    String result1 =
        StringUtils.extractEmail('Chuỗi này chứa kinh@tmtsofts.com');
    String result2 =
        StringUtils.extractEmail('Chuỗi này chứa nam.nvdlkjf@tmtsofts.com');
    expect(result2, 'nam.nvdlkjf@tmtsofts.com');
    expect(result1, 'kinh@tmtsofts.com');
  });
  test('Extract email when string is null', () {});
  test('Extract email when string is empty', () {
    final String s = '';
    final String result = StringUtils.extractEmail(s);
    expect(result, null);
  });
}
