---
type: bug-report
skill: mb-fix
status: FIXED
branch: fix/capitalize-empty-string
date: 2026-11-04
severity: MEDIUM
bug_type: CODE_LOGIC
---

# Bug Report: StringUtils.capitalize throws RangeError on empty string

**Status:** INVESTIGATION_CONSUMED
**Severity:** MEDIUM
**Priority:** P2
**Type:** CODE_LOGIC

## Bug Description

`StringUtils.capitalize('')` throws `RangeError (end): Invalid value: Only valid value is 0: 1` (stack frame `#2 StringUtils.capitalize (...string_utils.dart:73)`). The same crash is reachable via the `String.capitalize()` extension and via `capitalize(s, allWords: true)` on inputs with consecutive spaces (empty word from `split(' ')` fed to the unguarded recursion at `string_utils.dart:69`).

## Expected Behavior

`capitalize()` handles empty input safely and returns `''` — no exception.

## Actual Behavior

`RangeError.checkValidRange` throws from `String.substring` before any capitalization happens.

## Steps to Reproduce

1. Call `StringUtils.capitalize('')` — directly or via `''.capitalize()` (`string_extensions.dart:221-222`)
2. Observe `RangeError (end): Invalid value: Only valid value is 0: 1`
3. Secondary trigger: `StringUtils.capitalize('a  b', allWords: true)` — double space → empty word → recursive `capitalize('')` → same crash

## Screenshots/Logs

```
RangeError (end): Invalid value: Only valid value is 0: 1
#0 RangeError.checkValidRange
#1 String.substring
#2 StringUtils.capitalize (tmt_dart_utils/src/string/string_utils.dart:73)
```

## Affected Area

- **Feature:** `tmt_dart_utils` string utilities
- **Screens:** N/A (pure utility package)
- **Files:** `packages/tmt_dart_utils/lib/src/string/string_utils.dart`, `packages/tmt_dart_utils/lib/src/string/string_extensions.dart`, `packages/tmt_dart_utils/test/string/string_utils_test.dart`

## Environment

- **Device:** N/A (package-level bug, platform-independent)
- **OS Version:** N/A
- **App Version:** tmt_dart_utils — present in every published version since 2020

## Root Cause Analysis

> Consumed from: `.mb_dev_ai/tasks/2026-11-04/task_fix-string-utils-capitalize-throws-RangeError-on-empty-string/2026-11-04-investigation_capitalize-empty-string-rangeerror.md`

### Root Cause
`StringUtils.capitalize` crashes on empty input because `string_utils.dart:73` calls `s.substring(0, 1)` without an `isEmpty` guard, and Dart's `substring` rejects `end=1` when the string length is 0.

### Mechanism
`capitalize('')` → `''` has length 0 → `substring(0, 1)` requires `end ≤ length` → RangeError. The same crash is reachable internally via `capitalize(s, allWords: true)` on any input containing consecutive spaces: `split(' ')` produces empty words, and the recursive `capitalize(w)` call at line 69 has no emptiness filter (unlike `camelCase`/`upperCamelCase`, which do filter). The library already established the "safe fallback" convention with `tryRemoveDiacritics` (`string_utils.dart:205`) and the empty-guard in `reverse` (`string_utils.dart:51`) — `capitalize` is the outlier.

### Execution Path
1. App calls `StringUtils.capitalize('')` or `''.capitalize()` → `string_extensions.dart:222`
2. Pass-through to `StringUtils.capitalize(s, allWords: false)` → `string_utils.dart:64`
3. `allWords == false` → else branch → `string_utils.dart:73`
4. `s.substring(0, 1)` on length-0 string → valid end range `0..0` → `1` invalid → throw

### Evidence
- Crash site read directly: `string_utils.dart:73`
- RangeError message uniquely matches `substring(0,1)` on length-0 input
- `git log -L 64,75` → introduced e57a763 (2020-09-26), unchanged since (PRE-EXISTING)
- Existing test `string_utils_test.dart:115` empirically asserts the throw (`throwsRangeError`) — codified by PR #3
- Differential diagnosis (3 hypotheses, 2 ruled out with evidence) in the investigation artifact

### Bug Type
- [x] Edge case not handled

### Bug Origin
- PRE-EXISTING (buggy lines predate recent branch changes — present unchanged since e57a763, 2020-09-26)

### Root Cause Confidence Score: 10/10 → HIGH ✅

| # | Factor | Pts | Status | Note |
|---|--------|-----|--------|------|
| 1 | Execution path traced end-to-end | 2 | ✅ | extension → `capitalize` → `substring(0,1)` → throw |
| 2 | File:line evidence provided | 2 | ✅ | `string_utils.dart:73` |
| 3 | Git blame / history confirms timing | 1 | ✅ | `git log -L` → e57a763 (2020-09-26) |
| 4 | Error log / stack trace matches | 1 | ✅ | exact message match |
| 5 | Differential Diagnosis completed | 2 | ✅ | 3 hypotheses in investigation |
| 6 | Reproducible (logically or device) | 2 | ✅ | existing test asserts the throw |

**Score:** 10/10 → HIGH
**Gate action:** proceed (gate passed).

### Related Files
- `packages/tmt_dart_utils/lib/src/string/string_utils.dart` — crash site (line 73)
- `packages/tmt_dart_utils/lib/src/string/string_extensions.dart` — public `String.capitalize()` entry (lines 221-222)
- `packages/tmt_dart_utils/test/string/string_utils_test.dart` — line 115 codifies the crash; must flip with the fix

## Fix Plan

### Fix Options (presented 2026-11-04)

| # | Option | Benefits | Trade-offs | Risk/blast radius | Effort |
|---|--------|----------|------------|-------------------|--------|
| A | Empty-string guard at function entry + flip test at line 115 | One guard covers both trigger paths (direct call + `allWords` recursion); matches file conventions (`reverse` line 51, `tryRemoveDiacritics` line 205) | Touches doc comment + test | LOW — behavior changes only for input that previously crashed | human ~15 min / CC ~2 min (Completeness: 8/10) |
| B | Ternary guard on the else branch only | Smallest diff; indirectly protects `allWords` path via recursion | Guard buried in expression, less readable | LOW | human ~10 min / CC ~1 min (Completeness: 8/10) |
| C | New `tryCapitalize` sibling (keep `capitalize` throwing) | Zero behavior change to `capitalize` | Leaves the footgun; reported expectation unmet unless callers migrate; grows API | MEDIUM | human ~30 min / CC ~3 min (Completeness: 5/10) |

**Selected:** Option A (user-confirmed 2026-11-04, D2)
**Rejected alternatives:** B (equivalent coverage but guard buried in expression, less readable); C (leaves the crash reachable, unmet expectation, API growth)
**Rationale:** A covers both trigger paths with one guard, matches the file's existing empty-guard convention (`reverse` line 51), and directly satisfies the reported expectation.
**Branch decision (D1):** `fix/capitalize-empty-string` off master, PR for review.

### Root Cause (recap)
`string_utils.dart:73` calls `s.substring(0, 1)` with no `isEmpty` guard → RangeError on any empty-string input (direct, extension, or `allWords` recursion).

### Fix Strategy
Entry guard (Option A): `if (s.isEmpty) return s;` before the `allWords` branch — covers direct calls and the unguarded recursion (recursive calls re-enter the guard). Flip the crash-asserting test, add coverage for the consecutive-space trigger path and the extension form.

### Root Cause → Fix Traceability
| Root cause | Fix addresses it how? |
|-----------|----------------------|
| `substring(0, 1)` unguarded at `string_utils.dart:73` | `isEmpty` guard at function entry (`string_utils.dart:64`) returns `s` unchanged |
| `allWords` recursion at `string_utils.dart:69` feeds empty words to `capitalize` | Same entry guard — recursive `capitalize('')` returns `''` and joins as an empty word |

### Changes Required

#### Files to Modify
1. `[ ]` `packages/tmt_dart_utils/lib/src/string/string_utils.dart` — add `isEmpty` entry guard + doc comment example
2. `[ ]` `packages/tmt_dart_utils/test/string/string_utils_test.dart` — flip line 115 (`throwsRangeError` → `''`), add consecutive-space `allWords` test
3. `[ ]` `packages/tmt_dart_utils/test/string/string_extensions_test.dart` — add `''.capitalize()` empty-input test

### Impact Analysis
- **Other code depending on changed code:** `string_extensions.dart:221-222` (pass-through, benefits); `camelCase`/`upperCamelCase` (already `isNotEmpty`-guarded, unaffected)
- **Risk of breaking other features:** LOW
- **Need to update tests:** Yes — `string_utils_test.dart:115` currently asserts the crash and MUST flip in the same change

### Risk Assessment
- **Risk Level:** LOW
- **Breaking Changes:** No — the only behavior change is for input that previously crashed; no caller can depend on a RangeError
- **Affected Features:** `tmt_dart_utils` string API (`capitalize`, `String.capitalize()`)

### Testing Strategy
- [x] Unit test for the fix (red→green: flipped empty-input test)
- [x] Edge cases: `allWords` with consecutive spaces; `''.capitalize()` extension
- [x] Regression: full string test suite after fix

### Estimated Effort
- **Human:** ~15 min
- **CC+AI:** ~2 min

## Fix Implementation

**Implemented 2026-11-04 on branch `fix/capitalize-empty-string` (Option A):**

1. `packages/tmt_dart_utils/lib/src/string/string_utils.dart:64-70` — added `if (s.isEmpty) return s;` entry guard before the `allWords` branch + doc example `"" -> ""` + "Returns [s] unchanged when empty."
2. `packages/tmt_dart_utils/test/string/string_utils_test.dart` — flipped the crash-asserting test to `expect(StringUtils.capitalize(''), '')`; added consecutive-space test.
3. `packages/tmt_dart_utils/test/string/string_extensions_test.dart` — added `''.capitalize()` → `''` test.

### Red → Green proof
- **Red (before fix):** 3 tests failed with exactly `RangeError (end): Invalid value: Only valid value is 0: 1` at `string_utils.dart:73`, including the `allWords` recursion path (frame `:69`) and the extension path (`string_extensions.dart:222`) — failure mode matches the documented root-cause mechanism.
- **Green (after fix):** all 3 pass; string suites at +220 with 1 failure (see adjudication below).

### Expectation correction during green phase
The investigation artifact predicted `capitalize('a  b', allWords: true)` → `'A B'`. Actual correct semantics with the guard: `split(' ')` keeps the empty word, the guard returns `''` for it, and `join(' ')` preserves spacing → `'A  B'`. Capitalization is a case-transformer, not a whitespace normalizer — the test was corrected to assert spacing preservation, not the fix weakened to match the assumption.

### Pre-existing failures adjudicated unrelated (candidates for follow-up bugs)
| Failure | Location | Nature |
|---------|----------|--------|
| `datetime_util_test.dart` fails to load (4 analyze errors) | `test/datetime/datetime_util_test.dart:151,152,171,182` | `weekday`/`day`/`month` accessed on `DateTime?` — compile error, pre-existing |
| `num_utils_test.dart` fails to load (syntax error) | `test/num/num_utils_test.dart:191` | `););` typo — compile error, pre-existing |
| `isBase64` undefined getter | `test/test_base64_check.dart:2,4` | missing import/extension — compile error, pre-existing |
| `repeat(0)` throws but test expects graceful handling | `string_utils.dart:325` vs `string_extensions_test.dart:515` | designed `ArgumentError` (`if (n < 1) throw` at `string_utils.dart:319`) contradicts test — same codified-contract pattern as this bug; NOT fixed here (scope discipline) |

## Verification

### Root Cause Addressed
- [x] Fix directly addresses the documented root cause (missing empty guard at `string_utils.dart:73`)
- [x] Removing the fix would re-introduce the RangeError for the same reason

### Static Analysis (MANDATORY)
- [x] `dart analyze` (package-level; no melos.yaml) — **0 errors in changed files**; 7 pre-existing errors remain in unrelated test files (table above), 40 pre-existing infos. None introduced by the fix.

### Manual Testing
- [x] N/A — package-level bug; the red unit tests reproduced it deterministically (no NOT_REPRODUCIBLE_IN_TEST escape needed)

### Automated Testing
- [x] Reproducing tests red→green: `capitalize('')`, `capitalize('a  b', allWords: true)`, `''.capitalize()`
- [x] String suites: +220 pass, 1 failure — adjudicated pre-existing (`repeat(0)` contract mismatch, table above)
- [x] Full-package analyze: no new issues from this diff

### Regression Check
- [x] `camelCase`/`upperCamelCase` suites still pass (already `isNotEmpty`-guarded call sites unaffected)
- [x] All other capitalize behavior unchanged (existing tests untouched and green)

### Verification Result
- [x] PASS - Bug is fixed, no regressions from this change
