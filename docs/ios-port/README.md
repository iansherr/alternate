# Alternate KMP + iOS — planning-first roadmap

**Status: planning-only; no application code changes.** Revised 2026-11-21. The issue tracker is live; this planning branch and its project index contain the canonical dependency plan. Fork and upstream main are both at `a434f408fd693332948e67183620797a6019ab8e`.

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
- **Optional later:** 3 issues

GitHub Issues are enabled. A native GitHub Projects board has **not** been created through the available connector; the [project board Markdown](PROJECT_BOARD.md) is the current project list.