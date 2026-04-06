import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_utils.dart';

void main() {
  group('Constants', () {
    group('emailPattern', () {
      test('should match valid email addresses', () {
        expect(RegExp(emailPattern).hasMatch('test@example.com'), true);
        expect(RegExp(emailPattern).hasMatch('user.name@example.co.uk'), true);
      });

      test('should not match invalid email addresses', () {
        expect(RegExp(emailPattern).hasMatch('notanemail'), false);
        expect(RegExp(emailPattern).hasMatch('@example.com'), false);
      });
    });

    group('containEmailPattern', () {
      test('should find email in text', () {
        expect(RegExp(containEmailPattern).hasMatch('Contact us at info@example.com'), true);
      });

      test('should not match when no email present', () {
        expect(RegExp(containEmailPattern).hasMatch('No email here'), false);
      });
    });

    group('base64Pattern', () {
      test('should match valid base64 strings', () {
        expect(RegExp(base64Pattern).hasMatch('SGVsbG8='), true); // "Hello" in base64
        expect(RegExp(base64Pattern).hasMatch('SGVsbG8gV29ybGQ='), true); // "Hello World" in base64
      });

      test('should not match invalid base64 strings', () {
        expect(RegExp(base64Pattern).hasMatch('Hello!'), false);
      });
    });

    group('urlPattern', () {
      test('should match valid URLs', () {
        expect(RegExp(urlPattern).hasMatch('https://www.example.com'), true);
        expect(RegExp(urlPattern).hasMatch('http://example.com'), true);
        expect(RegExp(urlPattern).hasMatch('https://example.com/path?query=value'), true);
      });

      test('should not match invalid URLs', () {
        expect(RegExp(urlPattern).hasMatch('not-a-url'), false);
        expect(RegExp(urlPattern).hasMatch('htp://example.com'), false); // Missing "t"
      });
    });

    group('phoneNumberPattern', () {
      test('should match valid Vietnamese phone numbers', () {
        expect(RegExp(phoneNumberPattern).hasMatch('0901000123'), true);
        expect(RegExp(phoneNumberPattern).hasMatch('0912345678'), true);
        expect(RegExp(phoneNumberPattern).hasMatch('+84 91 234 5678'), true);
      });

      test('should not match invalid phone numbers', () {
        expect(RegExp(phoneNumberPattern).hasMatch('12345'), false); // Too short
        expect(RegExp(phoneNumberPattern).hasMatch('abcd'), false); // Not digits
      });
    });
  });
}
