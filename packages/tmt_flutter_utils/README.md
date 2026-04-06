tmt_flutter_utils is a dart package with Utils class and provides some useful extension method.

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

# Extension Methods

## String Extensions

### Validation Methods
```dart
String input = 'some text';

// Check string types
input.isBool           // Returns true if string is bool value (true/false)
input.isNumber         // Returns true if string is numeric
input.isInt            // Returns true if string is an integer
input.isDouble         // Returns true if string is a double
input.isNumericOnly    // Returns true if string contains only numbers
input.isLowerCase      // Returns true if string is all lowercase
input.isUpperCase      // Returns true if string is all uppercase
input.isAscii          // Returns true if string contains only ASCII characters
input.isEmail          // Returns true if string is valid email format
input.isUrl            // Returns true if string is valid URL format
input.isCapitalized    // Returns true if string is capitalized
input.isContainEmail   // Returns true if string contains an email
input.isPhoneNumber    // Returns true if string is a phone number
input.isBase64         // Returns true if string is base64 encoded
input.isIpv4           // Returns true if string is IPv4 address
input.isIpv6           // Returns true if string is IPv6 address

// Emoji detection
'🧐🥳   '.hasOnlyEmojis(ignoreWhitespace: true)   // Returns true
'🧐🥳   '.hasOnlyEmojis(ignoreWhitespace: false)  // Returns false
'🧐🥳 text'.hasOnlyEmojis()                       // Returns false
```

### String Manipulation
```dart
// Hashing & Encoding
'secret'.encryptMd5()                    // MD5 hash
'data'.encodeToBase64()                  // Encode to base64
'ZGF0YQ=='.decodeFromBase64()            // Decode from base64

// Text processing
'The blue sky'.getInitials()             // Returns 'Tbs'
'THE TECH COMPANY'.capitalize(false)     // Returns 'The tech company'
'THE TECH COMPANY'.capitalize(true)      // Returns 'The Tech Company'
'Đây là tiếng việt'.removeDiacritics()   // Returns 'Day la tieng viet'
'Đây là tiếng VIỆT'.removeDiacritics(toLower: true)  // Returns 'day la tieng viet'

// URL operations
'http://google.com'.urlEncode            // Returns 'http%3A%2F%2Fgoogle.com'
'http%3A%2F%2Fgoogle.com'.urlDecode     // Returns 'http://google.com'

// Repetition & Masking
'hello'.repeat(3)                        // Returns 'hellohellohello'
'hello'.repeat(3, separator: ' ')        // Returns 'hello hello hello'
'012345678'.hideNumber(start: 7, end: 10, replacement: '*')  // Returns '0123456***'

// Chunking & Extraction
'abcdefghijk'.chunk(4)                   // Returns ['abcd','efgh','ijk']
'This has email: test@example.com'.extractEmail()  // Returns 'test@example.com'
'Call me at 123-456-7890'.extractPhoneNumber()  // Returns '123-456-7890'

// Parsing & Conversion
'123'.toInt()                            // Returns 123
'123.45'.toDouble()                      // Returns 123.45
'123.45'.toDoubleOrNull()                // Returns 123.45 (null if fails)
'{"key":"value"}'.parseJson()            // Returns Map
'data'.valueIfNullOrEmpty('default')     // Returns 'data' or 'default' if null/empty
```

### Color from String
```dart
'0xFF4287F5'.toColor()  // Converts string to Color
```

## Color Extensions

```dart
// Get contrasting text color based on background luminance
Color bgColor = Colors.blue;
Color textColor = bgColor.textColor();  // Returns white or black for contrast
```

## DateTime Extensions

```dart
DateTime now = DateTime.now();

// Time manipulation
TimeOfDay time = TimeOfDay(hour: 14, minute: 30);
DateTime changed = now.changeTime(time);  // Changes time portion of DateTime

// Date comparison
DateTime tomorrow = now.addDaysToDate(1);
now.isSameDayWith(tomorrow);              // Returns false
now.isSameMonthWith(tomorrow);            // Returns true

// Add days
DateTime nextWeek = now.addDaysToDate(7);
```

## Widget Extensions

```dart
// Padding shortcuts
Text('Hello')
  .padding(all: 16)
  .paddingLeft(value: 8)
  .paddingTop(value: 8)
  .paddingRight(value: 8)
  .paddingBottom(value: 8);

// Custom padding with specific sides
Text('Hello').padding(left: 8, top: 16, right: 8, bottom: 16);

// Convert to Sliver widget for CustomScrollView
Container(child: Text('Hello')).sliverToBox();
```

## TextEditingController Extensions

```dart
TextEditingController controller = TextEditingController();

// Select all text
controller.selectAll();

// Select specific range
controller.select(baseOffset: 0, extentOffset: 5);
```

## Context Extensions

```dart
// BuildContext shortcuts in widgets
Widget build(BuildContext context) {
  // Screen dimensions
  double width = context.width;
  double height = context.height;
  Size size = context.mediaQuerySize;

  // Theme access
  ThemeData theme = context.theme;
  TextTheme textTheme = context.textTheme;

  // Safe area & insets
  EdgeInsets viewInsets = context.mediaQueryViewInsets;
  EdgeInsets viewPadding = context.mediaQueryViewPadding;

  // Device type detection
  bool isPhone = context.isPhone;      // < 660px shortest side
  bool isTablet = context.isTablet;    // >= 600px shortest side
  bool isSmallTablet = context.isSmallTablet;  // >= 600px
  bool isLargeTablet = context.isLargeTablet;  // >= 720px

  // Keyboard detection
  bool isKeyboardOpen = context.isKeyboardOpen;

  // Responsive widget selection
  Widget responsiveWidget = context.responsiveWidget(
    mobile: Text('Mobile'),
    tablet: Text('Tablet'),
    desktop: Text('Desktop'),
  );

  // Platform-specific widget selection
  Widget platformWidget = context.responsivePlatform(
    ios: Text('iOS'),
    android: Text('Android'),
    other: Text('Other'),
  );

  // Navigation shortcuts
  context.pop();
  await context.materialPush(NextPage());
  await context.pushNamed('/route', args);

  // Keyboard control
  context.closeKeyboard();
  context.unfocus();
}
```
