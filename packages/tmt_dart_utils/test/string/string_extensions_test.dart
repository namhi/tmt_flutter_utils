import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_extensions.dart';

void main() {
  group('StringNullExtensionsEx', () {
    group('isNullOrEmpty', () {
      test('should return true for null', () {
        String? value = null;
        expect(value.isNullOrEmpty, true);
      });

      test('should return true for empty string', () {
        String? value = '';
        expect(value.isNullOrEmpty, true);
      });

      test('should return false for non-empty string', () {
        String? value = 'hello';
        expect(value.isNullOrEmpty, false);
      });
    });

    group('isNotNullOrEmpty', () {
      test('should return false for null', () {
        String? value = null;
        expect(value.isNotNullOrEmpty, false);
      });

      test('should return false for empty string', () {
        String? value = '';
        expect(value.isNotNullOrEmpty, false);
      });

      test('should return true for non-empty string', () {
        String? value = 'hello';
        expect(value.isNotNullOrEmpty, true);
      });
    });

    group('valueOrEmpty', () {
      test('should return empty string for null', () {
        String? value = null;
        expect(value.valueOrEmpty, '');
      });

      test('should return original string for non-null', () {
        String? value = 'hello';
        expect(value.valueOrEmpty, 'hello');
      });
    });

    group('getOrElse', () {
      test('should return default value for null', () {
        String? value = null;
        expect(value.getOrElse('default'), 'default');
      });

      test('should return original value for non-null', () {
        String? value = 'hello';
        expect(value.getOrElse('default'), 'hello');
      });
    });

    group('isNullOrBlank', () {
      test('should return true for null', () {
        String? value = null;
        expect(value.isNullOrBlank, true);
      });

      test('should return true for empty string', () {
        String? value = '';
        expect(value.isNullOrBlank, true);
      });

      test('should return false for non-empty string', () {
        String? value = 'hello';
        expect(value.isNullOrBlank, false);
      });
    });

    group('valueIfNullOrEmpty', () {
      test('should return default value for null', () {
        String? value = null;
        expect(value.valueIfNullOrEmpty('default'), 'default');
      });

      test('should return default value for empty string', () {
        String? value = '';
        expect(value.valueIfNullOrEmpty('default'), 'default');
      });

      test('should return original value for non-empty string', () {
        String? value = 'hello';
        expect(value.valueIfNullOrEmpty('default'), 'hello');
      });
    });
  });

  group('StringExtensions', () {
    group('isBool', () {
      test('should return true for true', () {
        expect('true'.isBool, true);
      });

      test('should return true for false', () {
        expect('false'.isBool, true);
      });

      test('should return false for other strings', () {
        expect('hello'.isBool, false);
        expect('123'.isBool, false);
      });
    });

    group('isNumber', () {
      test('should return true for integer', () {
        expect('123'.isNumber, true);
      });

      test('should return true for double', () {
        expect('123.45'.isNumber, true);
      });

      test('should return true for negative numbers', () {
        expect('-123'.isNumber, true);
        expect('-123.45'.isNumber, true);
      });

      test('should return false for non-numeric strings', () {
        expect('hello'.isNumber, false);
        expect('12a3'.isNumber, false);
      });
    });

    group('isInt', () {
      test('should return true for integers', () {
        expect('123'.isInt, true);
        expect('-123'.isInt, true);
      });

      test('should return false for doubles', () {
        expect('123.45'.isInt, false);
      });

      test('should return false for non-numeric strings', () {
        expect('hello'.isInt, false);
      });
    });

    group('isDouble', () {
      test('should return true for doubles', () {
        expect('123.45'.isDouble, true);
        expect('-123.45'.isDouble, true);
      });

      test('should return true for integers (can be parsed as double)', () {
        expect('123'.isDouble, true); // 123.0 is a valid double
      });

      test('should return false for non-numeric strings', () {
        expect('hello'.isDouble, false);
      });
    });

    group('isNumericOnly', () {
      test('should return true for numeric strings', () {
        expect('123456'.isNumericOnly, true);
      });

      test('should return false for strings with letters', () {
        expect('123abc'.isNumericOnly, false);
        expect('abc123'.isNumericOnly, false);
      });

      test('should return false for negative numbers', () {
        expect('-123'.isNumericOnly, false);
      });

      test('should return false for decimals', () {
        expect('123.45'.isNumericOnly, false);
      });
    });

    group('isLowerCase', () {
      test('should return true for lowercase string', () {
        expect('hello'.isLowerCase, true);
      });

      test('should return false for uppercase string', () {
        expect('HELLO'.isLowerCase, false);
      });

      test('should return false for mixed case', () {
        expect('Hello'.isLowerCase, false);
      });
    });

    group('isUpperCase', () {
      test('should return true for uppercase string', () {
        expect('HELLO'.isUpperCase, true);
      });

      test('should return false for lowercase string', () {
        expect('hello'.isUpperCase, false);
      });

      test('should return false for mixed case', () {
        expect('Hello'.isUpperCase, false);
      });
    });

    group('isAscii', () {
      test('should return true for ASCII string', () {
        expect('hello'.isAscii, true);
        expect('Hello123'.isAscii, true);
      });

      test('should return false for non-ASCII string', () {
        // Vietnamese text might be detected as ASCII in some implementations
        expect('こんにちは'.isAscii, false);
      });
    });

    group('isEmail', () {
      test('should return true for valid email', () {
        expect('test@example.com'.isEmail, true);
      });

      test('should return false for invalid email', () {
        expect('invalid'.isEmail, false);
        expect('@example.com'.isEmail, false);
      });

      test('should handle emails with dots correctly', () {
        expect('user.name@example.com'.isEmail, true);
      });
    });

    group('isUrl', () {
      test('should return true for valid URL', () {
        expect('https://example.com'.isUrl, true);
        expect('http://domain.co.uk/path'.isUrl, true);
      });

      test('should return false for invalid URL', () {
        expect('not a url'.isUrl, false);
        expect('example'.isUrl, false);
      });
    });

    group('isCapitalized', () {
      test('should return true for capitalized string', () {
        expect('Hello'.isCapitalized, true);
        expect('Hello World'.isCapitalized, true);
      });

      test('should return false for lowercase', () {
        expect('hello'.isCapitalized, false);
      });

      test('should return false for empty string', () {
        expect(''.isCapitalized, false);
      });
    });

    group('isIpv4', () {
      test('should return true for valid IPv4', () {
        expect('192.168.1.1'.isIpv4, true);
        expect('0.0.0.0'.isIpv4, true);
        expect('255.255.255.255'.isIpv4, true);
      });

      test('should return false for invalid IPv4', () {
        expect('256.1.1.1'.isIpv4, false);
        expect('192.168.1'.isIpv4, false);
        expect('not an ip'.isIpv4, false);
      });
    });

    group('isIpv6', () {
      test('should return true for valid IPv6', () {
        expect('2001:0db8:85a3:0000:0000:8a2e:0370:7334'.isIpv6, true);
        expect('::1'.isIpv6, true);
      });

      test('should return false for invalid IPv6', () {
        expect('not an ipv6'.isIpv6, false);
        expect('192.168.1.1'.isIpv6, false);
      });
    });

    group('encryptMd5', () {
      test('should return MD5 hash', () {
        expect('hello'.encryptMd5(), '5d41402abc4b2a76b9719d911017c592');
      });

      test('should return different hashes for different strings', () {
        expect('hello'.encryptMd5(), isNot(equals('world'.encryptMd5())));
      });
    });

    group('encodeToBase64', () {
      test('should encode string to base64', () {
        expect('hello'.encodeToBase64(), 'aGVsbG8=');
      });

      test('should encode empty string', () {
        expect(''.encodeToBase64(), '');
      });
    });

    group('decodeFromBase64', () {
      test('should decode base64 string', () {
        expect('aGVsbG8='.decodeFromBase64(), 'hello');
      });

      test('should decode empty string', () {
        expect(''.decodeFromBase64(), '');
      });
    });

    group('toDateTime', () {
      test('should parse ISO 8601 string', () {
        final date = '2025-01-15T10:30:00Z'.toDateTime();
        expect(date, DateTime.parse('2025-01-15T10:30:00Z'));
      });

      test('should convert to local when toLocal is true', () {
        final date = '2025-01-15T10:30:00Z'.toDateTime(toLocal: true);
        expect(date.isUtc, false);
      });
    });

    group('removeVietnameseMark', () {
      test('should remove Vietnamese diacritics', () {
        expect('Đây là Tiếng Việt'.removeVietnameseMark(),
            'Day la Tieng Viet');
      });

      test('should convert to lowercase when toLower is true', () {
        expect('ĐÂY LÀ TIẾNG VIỆT'.removeVietnameseMark(toLower: true),
            'day la tieng viet');
      });
    });

    group('removeDiacritics', () {
      test('should remove diacritics', () {
        expect('Đây là Tiếng Việt'.removeDiacritics(), 'Day la Tieng Viet');
      });

      test('should convert to lowercase when toLower is true', () {
        expect('ĐÂY LÀ TIẾNG VIỆT'.removeDiacritics(true), 'day la tieng viet');
      });

      test('should handle non-Vietnamese text', () {
        expect('Hello World'.removeDiacritics(), 'Hello World');
      });
    });

    group('tryRemoveDiacritics', () {
      test('should remove diacritics from Vietnamese text', () {
        expect('Đây là Tiếng Việt'.tryRemoveDiacritics(), 'Day la Tieng Viet');
      });

      test('should return original text if no diacritics', () {
        expect('Hello World'.tryRemoveDiacritics(), 'Hello World');
      });

      test('should convert to lowercase when toLower is true', () {
        expect('ĐÂY LÀ TIẾNG VIỆT'.tryRemoveDiacritics(true),
            'day la tieng viet');
      });

      test('should handle special characters and emojis', () {
        expect('Xin chào 👋'.tryRemoveDiacritics(), 'Xin chao 👋');
      });

      test('should handle empty string', () {
        expect(''.tryRemoveDiacritics(), '');
      });
    });

    group('chunk', () {
      test('should split string into chunks', () {
        expect('abcdefghijk'.chunk(4), ['abcd', 'efgh', 'ijk']);
      });

      test('should handle chunk size larger than string', () {
        expect('hello'.chunk(10), ['hello']);
      });

      test('should handle empty string', () {
        expect(''.chunk(4), []);
      });
    });

    group('hideNumber', () {
      test('should replace characters in range', () {
        // replaceRange(start, end, replacement) replaces from start to end-1
        expect('0908075555'.hideNumber(start: 2, end: 6, replacement: '****'),
            '09****5555');
      });

      test('should handle partial replacement', () {
        expect('ABC'.hideNumber(start: 0, end: 1, replacement: '*'), '*BC');
      });

      test('should return original when end exceeds length', () {
        expect('123'.hideNumber(start: 0, end: 10, replacement: '*'), '123');
      });

      test('should throw when end < start', () {
        expect(() => '12345'.hideNumber(start: 3, end: 1, replacement: '*'),
            throwsA(isA<Exception>()));
      });
    });

    group('trimUnicode', () {
      test('should trim and add prefix', () {
        // Takes first 20 runes and adds prefix
        expect('This is a very long string that needs to be trimmed'
                .trimUnicode(20),
            'This is a very long ...');
      });

      test('should return original if shorter than startAt', () {
        expect('Short'.trimUnicode(20), 'Short');
      });

      test('should use custom prefix', () {
        expect('This is a very long string'.trimUnicode(10, '>>>'),
            'This is a >>>');
      });

      test('should return empty for empty string', () {
        expect(''.trimUnicode(20), '');
      });
    });

    group('parseJson', () {
      test('should parse JSON string', () {
        final result = '{"key": "value"}'.parseJson();
        expect(result, isA<Map>());
        expect(result['key'], 'value');
      });

      test('should parse JSON array', () {
        final result = '[1, 2, 3]'.parseJson();
        expect(result, [1, 2, 3]);
      });
    });

    group('toInt', () {
      test('should convert string to int', () {
        expect('123'.toInt(), 123);
      });

      test('should handle negative numbers', () {
        expect('-123'.toInt(), -123);
      });

      test('should throw for invalid input', () {
        expect(() => 'abc'.toInt(), throwsArgumentError);
      });
    });

    group('toDouble', () {
      test('should convert string to double', () {
        expect('123.45'.toDouble(), 123.45);
      });

      test('should handle negative numbers', () {
        expect('-123.45'.toDouble(), -123.45);
      });

      test('should throw for invalid input', () {
        expect(() => 'abc'.toDouble(), throwsArgumentError);
      });
    });

    group('toDoubleOrNull', () {
      test('should convert string to double', () {
        expect('123.45'.toDoubleOrNull(), 123.45);
      });

      test('should return null for invalid input', () {
        expect('abc'.toDoubleOrNull(), isNull);
      });
    });

    group('tryToNum', () {
      test('should convert string with comma separator to num', () {
        expect('1,234.56'.tryToNum(), 1234.56);
      });

      test('should handle custom separators', () {
        expect('1.234,56'.tryToNum(separate: '.', decimalPlace: ','), 1234.56);
      });

      test('should return null for invalid input', () {
        expect('abc'.tryToNum(), isNull);
      });
    });

    group('repeat', () {
      test('should repeat string n times', () {
        expect('hello'.repeat(3), 'hellohellohello');
      });

      test('should use separator when provided', () {
        expect('hello'.repeat(3, ':'), ':hello:hello:hello');
      });

      test('should handle zero repeats', () {
        expect('hello'.repeat(0), '');
      });
    });

    group('toMap', () {
      test('should convert JSON string to map', () {
        final result = '{"key": "value"}'.toMap();
        expect(result, isA<Map<String, dynamic>>());
        expect(result['key'], 'value');
      });
    });

    group('getInitials', () {
      test('should get first character of each word', () {
        expect('The blue sky'.getInitials(), 'Tbs');
      });

      test('should handle single word', () {
        expect('Hello'.getInitials(), 'H');
      });

      test('should handle empty string', () {
        expect(() => ''.getInitials(), throwsA(isA<RangeError>()));
      });
    });

    group('capitalize', () {
      test('should capitalize first letter', () {
        expect('công ty quảng cáo'.capitalize(), 'Công ty quảng cáo');
      });

      test('should lowercase the rest of the string', () {
        expect('HELLO WORLD'.capitalize(), 'Hello world');
      });

      test('should handle already capitalized string', () {
        // capitalize() lowercases everything after the first character
        expect('Hello World'.capitalize(), 'Hello world');
      });
    });

    group('urlEncode', () {
      test('should encode URL', () {
        expect('hello world'.urlEncode, 'hello%20world');
      });
    });

    group('urlDecode', () {
      test('should decode URL', () {
        expect('hello%20world'.urlDecode, 'hello world');
      });
    });

    group('toCamelCase', () {
      test('should convert to camel case', () {
        expect('Hello World'.toCamelCase(), 'helloWorld');
        expect('hello-world'.toCamelCase(), 'helloWorld');
        expect('hello_world'.toCamelCase(), 'helloWorld');
      });

      test('should handle single word', () {
        expect('Hello'.toCamelCase(), 'hello');
      });

      test('should handle empty string', () {
        expect(''.toCamelCase(), '');
      });
    });

    group('toUpperCamelCase', () {
      test('should convert to upper camel case', () {
        expect('hello world'.toUpperCamelCase(), 'HelloWorld');
        expect('hello-world'.toUpperCamelCase(), 'HelloWorld');
        expect('hello_world'.toUpperCamelCase(), 'HelloWorld');
      });

      test('should handle single word', () {
        expect('hello'.toUpperCamelCase(), 'Hello');
      });

      test('should handle empty string', () {
        expect(''.toUpperCamelCase(), '');
      });
    });

    group('toLowerUnderscore', () {
      test('should convert to lower underscore with space separator', () {
        expect('Hello World'.toLowerUnderscore(), 'hello_world');
      });

      test('should convert to lower underscore with underscore separator', () {
        expect('Hello_World'.toLowerUnderscore(), 'hello_world');
      });

      test('should convert to lower underscore with dash separator', () {
        expect('Hello-World'.toLowerUnderscore(), 'hello_world');
      });

      test('should handle single word without separator', () {
        expect('HelloWorld'.toLowerUnderscore(), 'helloworld');
      });

      test('should handle single word', () {
        expect('Hello'.toLowerUnderscore(), 'hello');
      });

      test('should handle empty string', () {
        expect(''.toLowerUnderscore(), '');
      });
    });

    group('toLowerFirstCharacter', () {
      test('should lowercase first character', () {
        expect('Hello'.toLowerFirstCharacter(), 'hello');
        expect('HELLO'.toLowerFirstCharacter(), 'hELLO');
      });

      test('should handle single character', () {
        expect('H'.toLowerFirstCharacter(), 'h');
      });
    });

    group('validate', () {
      test('should return null when condition passes', () {
        expect('test@email.com'.validate((s) => s.isEmail, 'Invalid email'),
            isNull);
      });

      test('should return message when condition fails', () {
        expect('notemail'.validate((s) => s.isEmail, 'Invalid email'),
            'Invalid email');
      });
    });

    group('isPhoneNumber', () {
      test('should return true for valid phone number', () {
        expect('0908075555'.isPhoneNumber, true);
        expect('+84 908 075 555'.isPhoneNumber, true);
      });

      test('should return false for invalid phone number', () {
        expect('123'.isPhoneNumber, false);
        expect('abc'.isPhoneNumber, false);
      });
    });

    group('isBase64', () {
      test('should return true for valid base64', () {
        expect('SGVsbG8gV29ybGQ='.isBase64, true);
      });

      test('should return false for non-base64', () {
        expect('hello world!'.isBase64, false);
      });
    });

    group('extractEmail', () {
      test('should return null when no email found', () {
        expect('No email here'.extractEmail(), isNull);
      });

      test('should extract first email from string', () {
        // Using containEmailPattern to find emails
        expect('Contact test@example.com'.extractEmail(), 'test@example.com');
      });
    });

    group('isContainEmail', () {
      test('should return true when string contains email', () {
        expect('Contact us at test@example.com'.isContainEmail, true);
      });

      test('should return false when string does not contain email', () {
        expect('No email here'.isContainEmail, false);
      });
    });
  });
}
