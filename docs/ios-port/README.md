# Alternate KMP + iOS — planning-first roadmap

**Status: planning backlog and separately gated draft feasibility PRs; no code has landed on main.** Revised 2026-11-21. The issue tracker is live; this planning branch and its project index contain the canonical dependency plan. Fork and upstream main are both at `a434f408fd693332948e67183620797a6019ab8e`.

- [Master roadmap #1](https://github.com/iansherr/alternate/issues/1)
- [Whole-plan reassessment](REASSESSMENT_2026-11-21.md)
- [Full issue backlog](ISSUE_BACKLOG.md)
- [Project board and milestones](PROJECT_BOARD.md)
- [Machine-readable issue index](issues.json)
- [Draft upstream proposal — NOT SENT](UPSTREAM_PROPOSAL.md)

## Product mission
Open-source, privacy-first **secondary address book for iPhone** that recognizes incoming phone numbers from its own local contacts while not writing those contacts into Apple Contacts. Protect against accidental calling/sharing of other people's addresses and notes, within documented iOS Phone-app limits.

## Architecture (conditional)
**Prefer Kotlin Multiplatform shared business logic.** Do not assume full Compose UI reuse until measured against Alternative A (shared Kotlin + SwiftUI), B (shared Kotlin + Compose Multiplatform), and C (minimal separate Swift app with stable import/export). Android 3.2.0 is the working upstream product; preserve its package identity, Room migrations, MMKV upgrade, native overlays and behavior. KMP work must be staged and reversibly landed.

## Security / privacy contracts
- Offline, no external lookup or account requirement, no silent Apple Contacts sync.
- iOS uses Swift Call Directory. Full contact records stay within app storage; only a consented minimal caller `number + chosen label` projection is supplied to the OS extension. OS display history is not within app control.
- **Isolation is not encryption.** Audit Room SQLite, file protection, backups, WAL/temp and App Group before making privacy claims; see [SEC-01](https://github.com/iansherr/alternate/issues/39).
- Accidental outbound calls, vCard/addresses disclosure and other share surfaces require explicit UX tests; see [UX-01](https://github.com/iansherr/alternate/issues/40).
- Correct number ownership, international normalization and collision behavior must be proven, not guessed.

## Governance
No code implementation or upstream posts before approval of Gate A. No unverified claims about real-device caller ID. No duplication of upstream [#39](https://github.com/BioHazard786/Alternate/issues/39) or [#40](https://github.com/BioHazard786/Alternate/issues/40). Every task records source SHA, ownership, dependency, tests, head SHA and whether behavior **landed** (not just passed CI).

## Decision gates
1. **A — Planning review:** all 42 tickets and dependencies accounted for, architecture/security/device risk reviewed, explicit authorization to experiment.
2. **B — Two small spikes:** proof of cross-platform model/database feasibility and independent one-number iPhone caller-ID; if a spike fails, revise architecture before a broad migration.
3. **C — Incremental implementation:** shared domain/data, iOS app, caller ID, with Android unaffected on each intermediate PR.
4. **D — Real-device product acceptance:** full privacy, accidental-dial/share UX, data integrity and OS caller index verified.
5. **E — Upstream/release:** approved contributor PR sequence, packaging, security/maintenance ownership and release plan.

## Ticket counts
- **Discovery & governance:** 9 issues
- **Kotlin shared core:** 10 issues
- **iOS application:** 7 issues
- **iOS caller ID:** 6 issues
- **Quality/release:** 7 issues
- **Optional later:** 5 issues

GitHub Issues are enabled. A native GitHub Projects board has **not** been created through the available connector; the [project board Markdown](PROJECT_BOARD.md) is the current project list.
## Feasibility evidence (read before claiming code)
- [Verified exact-head build proofs — Android, KMP, Call Directory](FEASIBILITY_RESULTS_2026-11-21.md): the initial Android/KMP/Swift packaging probes (#44, #46, #47) passed; stacked #50 adds the opt-in caller-ID index and is independently tested, with no signed real-device proof.
- [Exact-head Android source/baseline audit](BASELINE_AUDIT.md): Kotlin 2.4.21 + AGP 9.5.1 + Gradle 9.9.1 outside published fully-tested matrix, Android app ID/schema and migration fixtures, ordinary Room vs encryption, and `android:allowBackup=true`. **Static only; runtime tests not yet verified.**
- [ADR-001 architecture options](ADR-001_ARCHITECTURE.md): proposed additive KMP shared library, SwiftUI/Compose decision and reversible fallback.
- [Native iPhone Call Directory spike contract](IOS_CALL_DIRECTORY_SPIKE.md): signing prerequisites, OS privacy limitations and physical-device pass/fail matrix.
- [Draft fork-local Android baseline CI PR #44](https://github.com/iansherr/alternate/pull/44): read-only tests/debug build; passed at exact head and remains unmerged.

These files are planning evidence and should not be construed as proven Android/iOS functional acceptance. Source code and fork main remain unchanged.

## Real-device acceptance handoff
- [Signed iPhone caller ID test and privacy matrix](REAL_DEVICE_HANDOFF.md) — required for real native Phone identification; no physical call verified.

## Further bounded work (2026-11-21)
- [Draft stacked PR #50](https://github.com/iansherr/alternate/pull/50) builds on native Call Directory PR #47 to add an explicitly consented minimal App Group number-and-alias index, a protected atomic snapshot and validation/disable tests. Not integrated with a full address book. Swift unit tests and unsigned iOS packaging passed at [run #44936063500](https://github.com/iansherr/alternate/actions/runs/44936063500); physical-device acceptance remains gated.
- [Issue #48 — iOS ContactProvider research](https://github.com/iansherr/alternate/issues/48) is optional. It may expose provider contacts to other iOS apps, so it must not silently replace Call Directory.
- [Issue #49 — macOS Messages aliases](https://github.com/iansherr/alternate/issues/49) is optional. No documented native Call Directory-equivalent Messages lookup extension was verified; any system Contacts publication must be informed opt-in.
- The source of truth is 44 child issues and one [roadmap #1](https://github.com/iansherr/alternate/issues/1), all without an automatic merge or upstream submission.
