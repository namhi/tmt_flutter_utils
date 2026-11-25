---
id: 20261125-001
created: 2026-11-25T11:26:18.894334Z
category: bugfix
tags: string-utils,edge-case,mb-fix
skill: mb-fix
---

Fixing an edge-case crash in a utils file: sweep sibling functions for the same unguarded pattern in the same pass [confidence: 9]

## What
When fixing an unguarded edge-case crash in a utils file, sweep sibling functions in the same file for the identical pattern and fix all occurrences in that pass.

## Why
`capitalize('')` RangeError was root-caused and fixed on 2026-11-04 (commit ae119db, `packages/tmt_dart_utils/lib/src/string/string_utils.dart`), but `getInitials` ~300 lines down the same file kept crashing on the same class of bug — `split[i][0]` unguarded at (pre-fix) :349, empty parts from `split(' ')`. It only got fixed when ADO 131404 (filed 2025-04-21, state Active) forced a second fix pass on 2026-11-25 (`string_utils.dart:345-363`). Two fix cycles for one pattern; the first pass even added the `if (s.isEmpty) return s;` guard convention that the sibling should have inherited.

## How to apply
After the red test passes on the target function, `grep -n` the file for the pattern class (unguarded `[0]`/`substring` indexing, `split` results consumed raw) and check each hit: if a sibling shares the crash, fold its fix into the same branch + report, or file an explicit follow-up with file:line. Tests codifying the crash (`throwsRangeError` on avoidable accidents, learning 20261104-001) are the cheap detection signal — grep the test suite too.

## Detection
During any string/list utils fix, run: `grep -n "split(\|\[0\]\|substring(" <utils-file>.dart` and for each unguarded hit ask "does any input make this throw?"