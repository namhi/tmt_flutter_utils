---
id: 20261104-002
created: 2026-11-04T10:54:12.415473Z
category: bugfix
tags: string-utils,testing,mb-fix
skill: mb-fix
---

Empty-input guards in split/join pipelines preserve empty segments — derive test expectations from pipeline semantics

## What
An empty-input guard that returns `''` inside a split/join pipeline preserves empty segments — `capitalize('a  b', allWords: true)` returns `'A  B'` (double space kept), not `'A B'`. Fix expectations must follow the transformation semantics, not assumed whitespace normalization.

## Why
During the fix for the capitalize RangeError (`packages/tmt_dart_utils/lib/src/string/string_utils.dart:64`), the investigation artifact predicted `'A B'` for the consecutive-space case. The first green run failed with `Expected: 'A B' / Actual: 'A  B'` — the guard returns `''` for the empty word and `join(' ')` keeps it. The fix was correct; the expected value was an assumption.

## How to apply
When writing the green-side expectation for an edge-case test, derive it from the pipeline's actual semantics (split → transform → join): a transform that returns `''` for empty segments cannot collapse separators. If collapsing IS desired, that's a separate feature — don't smuggle it into a bugfix.

## Detection
A green-run failure where Actual differs from Expected only in whitespace/empty segments usually means the expectation assumed normalization the code never promised.