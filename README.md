# tmt_flutter_utils
tmt_fltuter_utils is a Flutter package with Utils class and provides some useful extension method.


# Installation
Add this line to your pubspec.yaml
```dart
      tmt_flutter_utils:
        git:
          url: https://tfs.tpos.dev/TMT01Collection/TMT%20Flutter%20Gallery/_git/tmt_flutter_utils
          ref: 1.1.9
    
```

Import package
```dart
   import 'package:tmt_flutter_utils/tmt_flutter_utils.dart';
```



# Extension method.
## String
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

input.extractEmail();
input.encryptMd5();
input.encodeToBase64();
input.decodeFromBase64();
input.removeVietnameseMark(toLower: false);
input.removeDiacritics(toLower: false);
input.chunk(10);
input.hideNumber(start: 5, end: 10, replacement: '*');
input.trimUnicode();
input.extractPhoneNumber();
input.parseJson();
input.toInt();
input.toDouble();
input.toDoubleOrNull();
input.valueIfNullOrEmpty();
input.repeat();
input.urlEncode
input.urlDecode
input.hasOnlyEmojis;
input.capitalize();

/// Get first charactor of word.
'The blue sky'.getInitials(); // Return 'Tbs'
'THE TECH COMPANY'.capitalize(false); // Return 'The tech company
'THE TECH COMPANY'.capitalize(true): // Return 'The Tech Company
'http://tmtco.asia'.urlEncode; // Returns 'http%3A%2F%2Ftmtco.asia'
'http%3A%2F%2Ftmtco.asia'.urlDecode; // Return http://tmtco.asia

```
## Num
## Datetime