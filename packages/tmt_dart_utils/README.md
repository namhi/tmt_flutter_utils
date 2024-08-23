<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

tmt_dart_utils is a dart package with Utils class and provides some useful extension method.

## Getting started

Add using pub

```bash
dart pub add tmt_dart_utils
```

Or add this line to your pubspec.yaml

```dart
      tmt_dart_utils: ^1.2.4
```

Import package

```dart
   import 'package:tmt_flutter_utils/tmt_flutter_utils.dart';
```

# Extension Method

```dart
String input = 'some text';
// Returns true if string is bool value (True/False)
input.isBool //return bool

// True if
input.isNumber // Return bool
input.isInt // Return bool
input.isDouble // Return bool
input.isNumericOnly // Return bool
input.isLowerCase // Return bool
input.isUpperCase // Return bool
input.isAscii // Return bool
input.isEmail // Return bool
input.isUrl // Return bool
input.isCapitalized // Return bool
input.isContainEmail
input.isPhoneNumber
input.isBase64
input.isIpv4
input.isIpv6


input.encryptMd5();
input.encodeToBase64();
input.decodeFromBase64();
input.trimUnicode();
input.extractPhoneNumber();
input.parseJson();
input.toInt();
input.toDouble();
input.toDoubleOrNull();
input.valueIfNullOrEmpty();


'The blue sky'.getInitials(); // Return 'Tbs'
'THE TECH COMPANY'.capitalize(false); // Return 'The tech company
'THE TECH COMPANY'.capitalize(true): // Return 'The Tech Company
'http://google.com'.urlEncode; // Returns 'http%3A%2F%2Fgoogle.com'
'http%3A%2F%2Fgoogle.com'.urlDecode; // Return http://google.com
'🧐🥳   '.hasOnlyEmojis(ignoreWhitespace:true); // Return true
'🧐🥳   '.hasOnlyEmojis(ignoreWhitespace:false); // Return false
'🧐🥳   some other text'.hasOnlyEmojis(); // Return false
'hello'.reapeat(3); // hellohellohello
'hello'.reapead(3, separator: ' ');//hello hello hello
'012345678'.hideNumber(start: 7, end: 10, replacement: '*'); // 090807***
'abcdefghijk'.trunk(4); // => [abcd,efgh,ijk]
'Đây là tiếng việt'.removeDiacritics(); // => 'Day la tieng viet'
'Đây là tiếng VIỆT'.removeDiacritics(toLower: true); // 'day la tieng viet'
'This strings contains email is info@namnv.com'.extractEmail(); // info@namnv.com
```
