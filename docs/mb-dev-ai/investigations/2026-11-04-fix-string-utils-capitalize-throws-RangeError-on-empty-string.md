---
type: investigation
skill: mb-investigate
status: ROOT_CAUSE_FOUND
branch: master
date: 2026-11-04
severity: MEDIUM
bug_type: CODE_LOGIC
confidence: 10
---

# Investigation: StringUtils.capitalize throws RangeError on empty string

**Status:** ROOT_CAUSE_FOUND
**Severity:** MEDIUM
**Type:** CODE_LOGIC

## Symptom

### Reported Behavior
`RangeError (end): Invalid value: Only valid value is 0: 1` thrown from `StringUtils.capitalize` (stack trace: `tmt_dart_utils/src/string/string_utils.dart:73` → `String.substring` → `RangeError.checkValidRange`).

### Expected Behavior
`capitalize()` should handle empty strings safely without throwing an exception.

### Steps to Reproduce
1. Call `StringUtils.capitalize('')` — directly or via the `String.capitalize()` extension (`string_extensions.dart:221`)
2. Observe `RangeError (end): Invalid value: Only valid value is 0: 1`

Secondary trigger: `StringUtils.capitalize('a  b', allWords: true)` — the double space splits into an empty word, which is recursively passed to `capitalize('')` at `string_utils.dart:69` → same crash.

### Frequency
Always — deterministic for any empty-string input.

### User Impact
Any consuming app that calls `capitalize` (or the extension) on a user-supplied/API-supplied string that can be empty crashes the current flow. The package is published (`tmt_dart_utils`), so the blast radius is every downstream consumer.

## Evidence Files

> No ADO attachments — bug reported inline with stack trace. The stack trace itself is the primary evidence and proves input length: for a length-0 string, `substring`'s valid end range is `0..0` (a single value), which is why Dart prints "Only valid value is 0: 1".

## Investigation Scope

### Affected Area
- **Feature:** `tmt_dart_utils` string utilities
- **Screens:** N/A (pure utility package)
- **Files (suspected):** `packages/tmt_dart_utils/lib/src/string/string_utils.dart`

### Branch Context
Working branch is `master` — no branch diff exists (Step 4.1.3 full-search path). Recent commits only added tests (`8aa67f2 test: Add utility extensions and tests`); no production code changed recently.

### Impact Radius (from code-review-graph)
MCP not configured — manual call-site analysis:
- `capitalize` is called from: the `String.capitalize()` extension (`string_extensions.dart:221-222`), the `allWords` recursion (`string_utils.dart:69`), `camelCase` (`string_utils.dart:93`, guarded by `isNotEmpty`), `upperCamelCase` (`string_utils.dart:112`, guarded by `isNotEmpty`).

## Investigation Trail

### Hypotheses Tested

| # | Hypothesis | Evidence FOR | Evidence AGAINST | Status |
|---|-----------|-------------|-----------------|--------|
| 1 | `capitalize` calls `substring(0, 1)` without an `isEmpty` guard, crashing on empty input | `string_utils.dart:73`; stack trace frame `#2 StringUtils.capitalize (...string_utils.dart:73)`; RangeError message "Only valid value is 0: 1" matches exactly what `substring(0,1)` on a length-0 string produces; existing test `string_utils_test.dart:115` asserts `throwsRangeError` empirically | None | **Confirmed** |
| 2 | The `String.capitalize()` extension wrapper transforms input and causes the error | Extension is a pure pass-through: `StringUtils.capitalize(this, allWords: allWord)` (`string_extensions.dart:221-222`); stack trace points at `StringUtils.capitalize` directly, no extension frame | Pass-through code cannot inject an empty string | Ruled out |
| 3 | `camelCase`/`upperCamelCase` feed empty words into `capitalize`, causing an indirect crash | They DO call `capitalize` per word (`string_utils.dart:93,112`) | Both guard with `if (w.isNotEmpty)` first (`string_utils.dart:88,111`) — cannot pass empty words | Ruled out as a separate cause (the `allWords: true` recursion at line 69 has NO such guard — same root cause, second trigger path) |

**Selected root cause:** #1 — `string_utils.dart:73` indexes `substring(0, 1)` unconditionally; the error message itself proves the input was length 0.

**Why others ruled out:** #2 is a pass-through with no input transformation; #3's call sites are already guarded, and the one unguarded recursion (`allWords`) is the same missing guard, not an independent defect.

### Execution Path Traced
1. Entry point: app calls `StringUtils.capitalize('')` or `''.capitalize()` → `string_extensions.dart:222`
2. Pass-through to `StringUtils.capitalize(s, allWords: false)` → `string_utils.dart:64`
3. `allWords == false` → else branch → `string_utils.dart:73`
4. Failure point: `s.substring(0, 1)` on a length-0 string — valid end range is `0..0`, so `1` is invalid → `RangeError.checkValidRange` throws before `.toUpperCase()` ever runs

### Logs Captured
```
RangeError (end): Invalid value: Only valid value is 0: 1
#0 RangeError.checkValidRange
#1 String.substring
#2 StringUtils.capitalize (tmt_dart_utils/src/string/string_utils.dart:73)
```

### Git History Insights
- `git log -L 64,75` traces the function to its birth commit **e57a763 "add List util" (2020-09-26)** — the `substring(0, 1)` body is byte-identical from day one and survived the package split (`63119ec`). The bug shipped in every published version since 2020.
- `8aa67f2` (recent, PR #3) added the test suite — the test author observed the throw and **codified it as expected behavior**: `expect(() => StringUtils.capitalize(''), throwsRangeError)` (`string_utils_test.dart:114-115`). This is the accidental contract that must be revised alongside the fix.

## Root Cause

### Statement
`StringUtils.capitalize` crashes on empty input because `string_utils.dart:73` calls `s.substring(0, 1)` without an `isEmpty` guard, and Dart's `substring` rejects `end=1` when the string length is 0.

### Mechanism
`capitalize('')` → `''` has length 0 → `substring(0, 1)` requires `end ≤ length` → RangeError. The same crash is reachable internally via `capitalize(s, allWords: true)` on any input containing consecutive spaces: `split(' ')` produces empty words, and the recursive `capitalize(w)` call at line 69 has no emptiness filter (unlike `camelCase`/`upperCamelCase`, which do filter). The library already established the "safe fallback" convention with `tryRemoveDiacritics` (`string_utils.dart:205`) and the empty-guard in `reverse` (`string_utils.dart:51`) — `capitalize` is the outlier.

### Why It Wasn't Caught
No test ever exercised the empty case until PR #3 (2026) — and when it finally did, the test asserted the crash (`throwsRangeError`) instead of flagging it, locking the bug in as documented behavior. Six years of shipping without an empty-input test is the gap.

### Bug Type
- [x] Edge case not handled

### Bug Origin (mandatory — exactly one)

- [ ] REGRESSION
- [x] PRE-EXISTING (buggy lines predate the branch's recent changes — present unchanged since e57a763, 2020-09-26)
- [ ] UNKNOWN

### Confidence Score: 10/10 → HIGH ✅

| # | Factor | Pts | Status | Note |
|---|--------|-----|--------|------|
| 1 | Execution path traced end-to-end | 2 | ✅ | extension → `capitalize` → `substring(0,1)` → throw |
| 2 | File:line evidence provided | 2 | ✅ | `string_utils.dart:73`; crash site read directly |
| 3 | Git blame / history confirms timing | 1 | ✅ | `git log -L` → introduced e57a763 (2020-09-26), unchanged since |
| 4 | Error log / stack trace matches | 1 | ✅ | RangeError message uniquely matches `substring(0,1)` on length-0 input |
| 5 | Differential Diagnosis completed | 2 | ✅ | 3 hypotheses, 2 ruled out with evidence (see Hypotheses Tested) |
| 6 | Reproducible (logically or device) | 2 | ✅ | Deterministic; existing test `string_utils_test.dart:115` already asserts the throw |

**Score calculation:** 10/10 → **10 → HIGH**
**Gate action:** proceed to report (gate passed).

## Suggested Fixes

> **These are suggestions only. No code changes have been made by this skill.**
> **Hand off to `/mb-fix` to implement.**

### Option A: Empty-string guard at function entry (RECOMMENDED)
- **What:** Add `if (s.isEmpty) return s;` at the top of `capitalize` (before the `allWords` branch), update doc comment, and change `string_utils_test.dart:115` from `throwsRangeError` to `expect(StringUtils.capitalize(''), '')`.
- **Where:** `packages/tmt_dart_utils/lib/src/string/string_utils.dart:64-75` + `packages/tmt_dart_utils/test/string/string_utils_test.dart:114-115`
- **Why this approach:** One guard covers both trigger paths (direct call and the `allWords` recursion at line 69, since the recursive call re-enters the guard). Matches the file's existing convention (`reverse` line 51 guards empty input; `tryRemoveDiacritics` line 205 is the safe-fallback precedent). Returning `''` is the only sensible capitalization of `''` — a crash is never a useful contract, and no caller can depend on a throw.
- **Risk:** LOW — behavior change only affects input that previously crashed; the one caveat is the test change (see below).
- **Estimated effort:** human ~15 min / CC ~2 min
- **Note:** the test at `string_utils_test.dart:115` currently asserts the crash — it MUST be updated in the same change or the suite goes red.

### Option B: Guard only the else branch
- **What:** `s.isNotEmpty ? s.substring(0, 1).toUpperCase() + s.substring(1).toLowerCase() : s`
- **Where:** `packages/tmt_dart_utils/lib/src/string/string_utils.dart:73`
- **Why this approach:** Smallest diff. Also indirectly protects the `allWords` path (recursive call hits the guarded else).
- **Risk:** LOW — same behavioral surface as A; slightly less readable, guard buries the invariant.
- **Estimated effort:** human ~10 min / CC ~1 min

### Option C: Add a `tryCapitalize` sibling following `tryRemoveDiacritics`
- **What:** Keep `capitalize` throwing, add `tryCapitalize` that returns the input on error.
- **Where:** `packages/tmt_dart_utils/lib/src/string/string_utils.dart` (new static method)
- **Why this approach:** Zero breaking change for anyone who (unlikely) catches the RangeError deliberately.
- **Risk:** MEDIUM — grows API surface, leaves the footgun in place, and the reported expectation ("capitalize handles empty safely") is unmet unless callers migrate.
- **Estimated effort:** human ~30 min / CC ~3 min

## Impact Radius

### Code That Depends on the Bug Location
- `packages/tmt_dart_utils/lib/src/string/string_extensions.dart:221-222` — `String.capitalize()` extension, pure pass-through; benefits automatically
- `string_utils.dart:69` — `allWords` recursion; currently a second crash path, fixed by the same guard
- `string_utils.dart:93,112` — `camelCase`/`upperCamelCase`; already guarded by `isNotEmpty`, unaffected by the fix

### Regression Risk Areas
- The existing test suite: `string_utils_test.dart:115` asserts `throwsRangeError` and must flip to `''` in the same change
- `camelCase`/`upperCamelCase` tests (lines 150, 186) — should stay green; their inputs are non-empty by construction

### Recommended Test Coverage
- [x] Unit test for `capitalize('')` → `''` (rewrite of existing test at line 114)
- [ ] Unit test for `capitalize('a  b', allWords: true)` → `'A B'` (consecutive-space trigger path, currently uncovered)
- [ ] Unit test for `''.capitalize()` extension form

## Handoff

**Recommended next step:** `/mb-fix` — single-file logic bug, root cause HIGH confidence, fix is a 2-line guard + test flip.

**Consumption contract for downstream skills:**
- `/mb-fix` reads this file's Root Cause section and skips its Phase 1-3, jumping directly to Fix Planning. Implement Option A, including the test change at `string_utils_test.dart:114-115`.
- `/mb-verify` not required pre-fix — confidence is HIGH and the bug is trivially reproducible (existing test already demonstrates it).
- `/mb-plan` not needed — no feature work involved.

## Related Files
- `packages/tmt_dart_utils/lib/src/string/string_utils.dart` — crash site (line 73), all trigger paths
- `packages/tmt_dart_utils/lib/src/string/string_extensions.dart` — public `String.capitalize()` entry point (lines 221-222)
- `packages/tmt_dart_utils/test/string/string_utils_test.dart` — existing suite; line 115 codifies the crash and must be updated with the fix
