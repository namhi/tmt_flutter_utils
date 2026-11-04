---
id: 20261104-001
created: 2026-11-04T10:39:04.176219Z
category: bugfix
tags: string-utils,testing,mb-investigate
skill: mb-investigate
---

# Tests must assert desired behavior, not codify existing crashes

## What
When writing tests for utility edge cases, assert the DESIRED behavior — never write a `throws*` assertion for an avoidable crash just because the code currently throws.

## Why
`string_utils_test.dart:115` asserts `expect(() => StringUtils.capitalize(''), throwsRangeError)`, enshrining a bug as intended API contract. The crash itself is `substring(0, 1)` on empty input at `packages/tmt_dart_utils/lib/src/string/string_utils.dart:73`, present unchanged since commit e57a763 (2020-09-26). The test then actively blocks the fix — changing `capitalize` to return `''` would turn the suite red.

## How to apply
For each edge case, decide what the correct output IS (empty string, fallback value, documented exception), assert that, and file a separate bug for any mismatch between current and correct behavior. Precedent in the same file: `reverse` guards empty input (string_utils.dart:51) and `tryRemoveDiacritics` falls back safely (string_utils.dart:205).

## Detection
Grep test suites for `throwsRangeError|throwsA|throwsException` and check each one: is the throw a designed contract (e.g. ArgumentError on invalid n in `repeat`) or an accident being documented (RangeError from unchecked indexing)?