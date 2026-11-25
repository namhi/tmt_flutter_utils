---
type: bug-report
skill: mb-fix
status: FIXED
branch: fix/getinitials-empty-part
date: 2026-11-25
severity: MEDIUM
bug_type: CODE_LOGIC
report_mode: full
confidence_source: derived
---

# Bug Report: string.getInitials() throws RangeError when a part contains empty string

**Status:** FIXED
**Severity:** MEDIUM
**Priority:** P2
**Type:** CODE_LOGIC

> ADO source: [Work item 131404](https://tfs.tpos.dev/MainCollection/SuperApp/_workitems/edit/131404) — "«[tmt_flutter_utils] string.getInitial() throw an exception when a part contain empty string»". Type is User Story, nature is a bug. Title says `getInitial()`; the actual API is `getInitials()` (`StringUtils.getInitials` + `String.getInitials()` extension).

## Bug Description

`StringUtils.getInitials` (and the `String.getInitials()` extension) throws `RangeError` whenever the split on `' '` produces an empty part — i.e. input with consecutive spaces, a leading space, or a trailing space. Empty input (`''`) crashes the same way. A third trigger at the same line: `limitTo` larger than the word count indexes past the end of the split list.

## Expected Behavior

`getInitials` returns the first character of each word and ignores empty parts — no exception:

- `'The  blue  sky'.getInitials()` → `'Tbs'` (double spaces skipped)
- `''.getInitials()` → `''`
- `'Hello '.getInitials()` → `'H'` (trailing space ignored)
- `getInitials(string: 'Hello', limitTo: 5)` → `'H'` (limitTo clamped to available words)

This matches the file's established safe-fallback convention (`reverse` empty guard, `capitalize` empty guard from the 2026-11-04 fix, `camelCase`/`upperCamelCase` `w.isNotEmpty` filters) and learning 20261104-001: tests must assert desired behavior, not codify crashes.

## Actual Behavior

`RangeError` thrown from the indexing at `string_utils.dart:349`.

## Steps to Reproduce

1. Call `'The blue  sky'.getInitials()` (consecutive spaces → empty part), or `' Hello'`, or `'Hello '`
2. Or call `StringUtils.getInitials(string: '')`
3. Or call `StringUtils.getInitials(string: 'Hello', limitTo: 5)`
4. Observe `RangeError` — `Invalid value: Not in inclusive range 0..0: 0` (empty part indexed `[0]`) or `Invalid value: Only valid value is 0: 1` (list index overflow)

## Screenshots/Logs

ADO item carries no stack trace and no attachments (relations: parent link only — "no attachments — continuing"). Empirical evidence instead:

- `packages/tmt_dart_utils/test/string/string_utils_test.dart:495` asserts `expect(() => StringUtils.getInitials(string: ''), throwsRangeError)` — **passes today** (verified 2026-11-25 run: 7/7 getInitials tests green), empirically confirming the crash
- Same codification at `string_extensions_test.dart:537` (`throwsA(isA<RangeError>())`)

## Affected Area

- **Feature:** `tmt_dart_utils` string utilities
- **Screens:** N/A (pure utility package)
- **Files:** `packages/tmt_dart_utils/lib/src/string/string_utils.dart` (crash site :349), `packages/tmt_dart_utils/lib/src/string/string_extensions.dart` (:215 pass-through entry), both string test files

## Environment

- **Device:** N/A (package-level bug, platform-independent)
- **OS Version:** N/A
- **App Version:** present since commit b4e45c6 "Add getInitials" (pre-existing)

## Root Cause Analysis

### Root Cause
`StringUtils.getInitials` at `string_utils.dart:349` writes `split[i][0]` for every iteration up to `limitTo ?? split.length` without filtering empty parts or clamping `limitTo` — so any empty part from `split(' ')` (consecutive/leading/trailing space, or empty input → `['']`) is indexed as `''[0]`, and an over-large `limitTo` indexes past the list end; both throw RangeError.

### Execution Path
1. App calls `'The blue  sky'.getInitials()` → `string_extensions.dart:215`
2. Pass-through to `StringUtils.getInitials(string: 'The blue  sky')` → `string_utils.dart:345`
3. `string.split(' ')` → `['The', 'blue', '', 'sky']` (empty part kept) → `string_utils.dart:347`
4. Loop reaches `i = 2`, `split[2]` is `''`, `''[0]` → RangeError → `string_utils.dart:349`

### Evidence
- Crash site read directly: `string_utils.dart:345-353` — unguarded `split[i][0]`
- Empirical: codified-crash tests pass today (run 2026-11-25, 7/7 green) — `string_utils_test.dart:495`, `string_extensions_test.dart:537`
- Git history: `git log -L 345,353` → introduced by b4e45c6 "Add getInitials" (path then `lib/sources/string_utils/string_utils.dart`), logic unchanged since — PRE-EXISTING
- Sibling precedent: same file fixed for the identical class of bug on 2026-11-04 (`capitalize('')` RangeError → entry guard, commit ae119db on master); `camelCase`/`upperCamelCase` already filter with `if (w.isNotEmpty)` (`string_utils.dart:92,115,134`) — `getInitials` is the outlier
- Learning applied: `20261104-001` (tests must assert desired behavior, not codify crashes) — the two `throwsRangeError` tests must flip with the fix

### Differential Diagnosis (Step 3.5.1)

| # | Hypothesis | Evidence FOR | Evidence AGAINST | Ruled out? | Confidence |
|---|-----------|-------------|-----------------|-----------|------------|
| 1 | Empty part from consecutive/leading/trailing spaces → `''[0]` RangeError | `string_utils.dart:347-349`: `split(' ')` keeps empties, `split[i][0]` unguarded | — | No | HIGH |
| 2 | Empty input string → `split` → `['']` → same crash | Test `string_utils_test.dart:495` asserts the throw and passes today (empirical) | — | No | HIGH |
| 3 | `limitTo` > word count → `split[i]` list index out of range | Loop bound `limitTo ?? split.length` at `string_utils.dart:348` never clamps to `split.length` when `limitTo` is larger | — | No (same crash line, adjacent trigger) | HIGH |
| 4 | Crash in the extension layer / null input | — | `string_extensions.dart:215` is a pure pass-through; param is required non-null `String` | Yes | — |

**Selected root cause:** #1 — one unguarded indexing site (`:349`) with three trigger families (empty part, empty input, limitTo overflow); the ADO report describes trigger #1.
**Why others ruled out:** #4 denied by code (pass-through, non-nullable); #2/#3 are not separate causes but sibling triggers of the same site — the fix must cover them for the report to be complete.

### Bug Type
- [x] Edge case not handled

### Bug Origin
- PRE-EXISTING (present unchanged since b4e45c6, 2020-era; not introduced by recent branch work — current branch is master, branch diff empty)

### Root Cause Confidence Score: 10/10 → HIGH ✅

| # | Factor | Pts | Status | Note |
|---|--------|-----|--------|------|
| 1 | Execution path traced end-to-end | 2 | ✅ | extension → static → `split(' ')` → `split[i][0]` → throw |
| 2 | File:line evidence provided | 2 | ✅ | `string_utils.dart:349` |
| 3 | Git blame / history confirms timing | 1 | ✅ | `git log -L` → b4e45c6 "Add getInitials" |
| 4 | Error log / stack trace matches | 1 | ✅ | ADO had no stack; empirical substitute: codified-crash tests pass today (exact failure mode confirmed by suite run 2026-11-25); red test at Step 5.1 will give the exact message |
| 5 | Differential Diagnosis completed | 2 | ✅ | 4 hypotheses above, #4 ruled out with code evidence |
| 6 | Reproducible (logically or device) | 2 | ✅ | deterministic pure function; empirically confirmed via passing throws-tests |

**Score:** 10/10 → HIGH
**Gate action:** proceed (gate passed).

### Related Files
- `packages/tmt_dart_utils/lib/src/string/string_utils.dart` — crash site (`getInitials`, :345-353)
- `packages/tmt_dart_utils/lib/src/string/string_extensions.dart` — public `String.getInitials()` entry (:215)
- `packages/tmt_dart_utils/test/string/string_utils_test.dart` — :479-496 getInitials group; :495 codifies the crash
- `packages/tmt_dart_utils/test/string/string_extensions_test.dart` — :527-539 getInitials group; :537 codifies the crash

## Fix Plan

### Fix Options (presented 2026-11-25)

| # | Option | Benefits | Trade-offs | Risk/blast radius | Effort |
|---|--------|----------|------------|-------------------|--------|
| A | Filter empty words + clamp limitTo (`split(' ').where(isNotEmpty)`, cap count at words.length) | Fixes all three trigger families at once; matches `camelCase` `w.isNotEmpty` convention; `''` → `''` consistent with capitalize fix; limits behavior change to inputs that previously crashed | Rewrites loop bound (touch limitTo semantics — overflow now clamps instead of crashing) | LOW — only previously-crashing inputs change behavior | human ~20 min / CC ~5 min (Completeness: 9/10) |
| B | Skip empty parts in the loop (`if (split[i].isEmpty) continue;`), keep bound as-is | Smallest diff; fixes the reported trigger + empty input | `limitTo` > word count still crashes (same line, adjacent trigger left reachable) | LOW | human ~10 min / CC ~2 min (Completeness: 7/10) |
| C | Safe sibling `tryGetInitials`, keep `getInitials` throwing | Zero behavior change to existing API | Leaves the footgun; reported expectation unmet unless callers migrate; API growth | MEDIUM | human ~30 min / CC ~5 min (Completeness: 5/10) |

**Selected:** Option A (user-confirmed 2026-11-25, reply "A")
**Rejected alternatives:** B (leaves `limitTo` > word count crashing at the same line); C (leaves the crash reachable, unmet expectation, API growth)
**Rationale:** A fixes all three trigger families in one pass, matches the file's `camelCase` `w.isNotEmpty` convention, and keeps `''` → `''` consistent with the capitalize fix.
**Branch decision (D1):** `fix/getinitials-empty-part` off master (recommended default — D1 unanswered, mirrors `fix/capitalize-empty-string` precedent).

### Root Cause (recap)
`string_utils.dart:349` indexes `split[i][0]` unguarded — empty parts (double/leading/trailing space, empty input) throw `''[0]` RangeError; `limitTo` > word count throws list-index RangeError at the same line.

### Fix Strategy
Option A: filter empty words before iterating (`split(' ').where((w) => w.isNotEmpty)`), clamp the iteration count to `words.length` when `limitTo` is given. Empty input naturally yields `''`. Behavior changes only for inputs that previously crashed.

### Root Cause → Fix Traceability
| Root cause | Fix addresses it how? |
|-----------|----------------------|
| Empty part indexed as `''[0]` at `string_utils.dart:349` | `where((w) => w.isNotEmpty)` removes empty parts before the loop — same convention as `camelCase` (`:92,115,134`) |
| Empty input → `['']` → crash | Filter reduces to an empty list → loop no-op → returns `''` |
| `limitTo` > word count indexes past list end | Count clamped: `limitTo` effective value is `min(limitTo, words.length)` |

### Changes Required

#### Files to Modify
1. `[ ]` `packages/tmt_dart_utils/lib/src/string/string_utils.dart` — `getInitials`: filter empty words + clamp `limitTo` + doc example
2. `[ ]` `packages/tmt_dart_utils/test/string/string_utils_test.dart` — flip :495 (`throwsRangeError` → `''`), add double-space / trailing-space / `limitTo`-overflow tests
3. `[ ]` `packages/tmt_dart_utils/test/string/string_extensions_test.dart` — flip :537 (`throwsA(RangeError)` → `''`), add double-space extension test

#### New Files (if any)
None.

### Impact Analysis
- **Other code depending on changed code:** `string_extensions.dart:215` (pass-through, benefits); no other callers of `getInitials` in-repo (grep verified 2026-11-25)
- **Risk of breaking other features:** LOW
- **Need to update tests:** Yes — `string_utils_test.dart:495` and `string_extensions_test.dart:537` currently codify the crash and MUST flip in the same change (learning 20261104-001)

### Risk Assessment
- **Risk Level:** LOW
- **Breaking Changes:** No — the only behavior changes are for inputs that previously threw RangeError; no caller can depend on a crash (the codified asserts were documenting the accident, per 20261104-001)
- **Affected Features:** `tmt_dart_utils` string API (`getInitials`, `String.getInitials()`)

### Testing Strategy
- [ ] Red tests before fix: `''` → `''`, `'The blue  sky'` → `'Tbs'`, `'Hello '` → `'H'`, `limitTo: 5` on `'Hello'` → `'H'` — all must fail with RangeError from `:349`
- [ ] Green after fix: same tests pass; existing positive tests unchanged and green
- [ ] Regression: full `tmt_dart_utils` suite (capitalize guards from the 2026-11-04 fix included in-run)

### Estimated Effort
- **Human:** ~20 min
- **CC+AI:** ~5 min

## Fix Implementation

**Implemented 2026-11-25 on branch `fix/getinitials-empty-part` (Option A):**

1. `packages/tmt_dart_utils/lib/src/string/string_utils.dart:342-363` — `getInitials` rewritten: `split(' ').where((w) => w.isNotEmpty)` removes empty parts; count clamped to `words.length` (`if (limit < count) count = limit`) and floored at 0 (preserves current `''` result for negative `limitTo`); doc examples added. Same `w.isNotEmpty` convention as `camelCase` (:92,115,134).
2. `packages/tmt_dart_utils/test/string/string_utils_test.dart:494-509` — flipped the crash-asserting `''` test to `expect(StringUtils.getInitials(string: ''), '')`; added consecutive-spaces, leading/trailing-spaces, `limitTo`-clamp tests.
3. `packages/tmt_dart_utils/test/string/string_extensions_test.dart:536-543` — flipped `''.getInitials()` crash test to `expect(..., '')`; added consecutive-spaces extension test.

### Red → Green proof
- **Red (before fix):** 6 failures, all at the documented site — 5× `RangeError (index): Invalid value: Valid value range is empty: 0` (`''[0]` on empty parts: empty input, consecutive spaces, leading/trailing spaces) and 1× `RangeError (length): Invalid value: Only valid value is 0: 1` (`split[1]` past list end on `limitTo` overflow). Failure modes match the Root Cause Mechanism exactly.
- **Green (after fix):** all 6 pass; full package suite 500/500 green.

## Verification

### Root Cause Addressed
- [x] Fix directly addresses the documented root cause (unguarded `split[i][0]` at old :349 → empty parts filtered, count clamped)
- [x] Removing the fix would re-introduce the RangeError for the same reason

### Static Analysis (MANDATORY)
- [x] Step 5.3 ladder: leg 1 unavailable (no melos CLI + no `.fvm/flutter_sdk` link) → leg 2: changed package `tmt_dart_utils` + dependent `tmt_flutter_utils` — **analyze: 0 errors**; 6 pre-existing infos (`avoid_init_to_null`, untouched test lines). No new warnings.

### Manual Testing
- [x] N/A — package-level bug; red unit tests reproduced it deterministically (no NOT_REPRODUCIBLE_IN_TEST escape needed)

### Automated Testing
- [x] Reproducing tests red→green: `''` → `''`, `'The blue  sky'` → `'Tbs'` (static + extension), `' Hello '` → `'H'`, `limitTo: 5` → `'H'`
- [x] Full `tmt_dart_utils` suite: `fvm flutter test --coverage` → **500/500 pass** (batched single invocation; the 4 pre-existing failures adjudicated in the 2026-11-04 report were since fixed by commit cfb2595 "repair test suite")

### Regression-Risk Gate (Step 5.5)

**Leg 1 — old bugs in changed area:**
| Source | Guard test | Re-run | Result |
|--------|-----------|--------|--------|
| fix-reports/2026-11-04 capitalize fix (changed files overlap: `string_utils.dart` + both test files) | `string_utils_test.dart:115` `capitalize('')` → `''`; `string_extensions_test.dart:560` `''.capitalize()` → `''` | Included in the batched 500/500 suite run | PASS |
| learning 20261104-001 (documentation-only, no runnable guard) | guard: none | n/a — principle lesson, no test to re-run | n/a |

**Leg 2 — changed-code coverage** (`coverage/lcov.info` from the ONE suite run):
- `string_utils.dart` added executable lines: 9 records expected, 8 hit (`DA` counts 2–10: :352 filter, :353, :355/:356 clamp branches, :357 buffer, :358/:359 loop, :362 return), 1 not instrumented (:354 `??` assignment — no DA record, verified no `DA:0` in range). Doc-comment lines (344-349) not executable.
- Coverage gap: none — all three trigger paths (filter, clamp, empty-input no-op) executed by the new tests.

### Regression Check (evidence-backed)
- [x] Old fixed bugs in the changed area re-verified — capitalize guard tests green in the batched run (table above)
- [x] Changed-code coverage gap checked — per-line hits recorded above, no gap
- [x] Files that depend on changed code still work — `tmt_flutter_utils` (path-depends on `tmt_dart_utils`) analyze clean; 500/500 package suite green
- [x] No new warnings or errors in affected features — 0 errors, 6 pre-existing infos

### Verification Result
- [x] PASS - Bug is fixed, no regressions
