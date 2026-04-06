# Requirement for Add Unit Tests for All Utils and Extensions

## Task Description
Add comprehensive unit tests for all utility and extension files across both `tmt_dart_utils` and `tmt_flutter_utils` packages to ensure code quality, prevent regressions, and document expected behavior.

**Files requiring tests (27 total):**

### tmt_dart_utils package (19 files):
- `bool/bool_utils.dart`
- `collection/collection_extensions.dart`
- `collection/collection_utils.dart`
- `constant.dart`
- `datetime/dart_datetime_extensions.dart`
- `datetime/datetime_range_type.dart`
- `datetime/datetime_range.dart`
- `datetime/datetime_util.dart`
- `enum/enum_until.dart`
- `file/file_extensions.dart`
- `num/double_extensions.dart`
- `num/int_extensions.dart`
- `num/num_extensions.dart`
- `num/num_utils.dart`
- `object/object_extensions.dart`
- `other/internet_utils.dart`
- `other/json_convert.dart`
- `string/string_extensions.dart` (partial tests exist)
- `string/string_utils.dart`

### tmt_flutter_utils package (8 files):
- `color_utils/color_extensions.dart`
- `color_utils/color_utils.dart`
- `context_utils/context_extensions.dart`
- `datetime_utils/flutter_datetime_extensions.dart`
- `datetime_utils/flutter_datetime_util.dart`
- `map_extensions.dart`
- `string_utils.dart` (partial tests exist)
- `widget_extensions.dart`

## Definition of Done

- [ ] All 27 utility and extension files have dedicated unit test files
- [ ] Test files follow naming convention: `<source_file>_test.dart`
- [ ] Test files are organized in the `test/` directory mirroring the `lib/` structure
- [ ] All public functions/methods are tested with:
  - [ ] Positive test cases (happy path)
  - [ ] Negative test cases (error handling, edge cases)
  - [ ] Boundary value testing (null, empty, min/max values)
- [ ] Test coverage is ≥80% for each file (measured by `dart test --coverage`)
- [ ] All tests pass: `dart test` succeeds with no failures
- [ ] No test warnings or skipped tests
- [ ] Tests are documented with clear descriptions of what is being tested

## Test Coverage Standards

### What to test:
1. **Public APIs** - All public functions, methods, and properties
2. **Extension methods** - All extension methods on various types
3. **Edge cases** - Null values, empty collections, boundary values
4. **Error conditions** - Invalid inputs, expected failures
5. **State transformations** - Input → Output verification

### Test structure per file:
```dart
import 'package:test/test.dart';
import 'package:<package_name>/<source_file>.dart';

void main() {
  group('<FileName>', () {
    group('<FeatureName>', () {
      test('should <expected behavior>', () {
        // Arrange
        // Act
        // Assert
      });
    });
  });
}
```

### Testing Decisions

**Flutter-specific utilities approach:**
- Use pseudo-unit tests with mocks for `widget_extensions.dart`, `context_extensions.dart`, `color_utils`
- Mock `BuildContext`, `Widget`, and Flutter framework dependencies using `mocktail`

**Testing dependencies to add:**
- `mocktail` - For mocking objects (null-safe alternative to mockito)
- `fake_async` - For testing time-dependent code (datetime utilities)
- `test` - Already included (Dart test framework)

**Test execution:**
- Configure all tests to run with single `dart test` command
- Ensure compatibility between Dart and Flutter test runners

## Figma Design
N/A - Not applicable for testing task

## BA Document
N/A - Not applicable for testing task

## Rest API Document
N/A - Not applicable for testing task

## Requirement Status
**Approved** - All questions answered, ready for implementation

### Validation Summary
| Category | Status | Notes |
|----------|--------|-------|
| Clarity | ✅ PASS | Task scope is clear |
| Completeness | ✅ PASS | DoD defined, coverage target set |
| Test Approach | ✅ PASS | Pseudo-unit tests with mocks |
| Dependencies | ✅ PASS | mocktail, fake_async to be added |
| Execution | ✅ PASS | Single command configured |
