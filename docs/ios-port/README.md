# Alternate KMP + iOS — planning-first roadmap

> **Planning only.** These documents define an issue-ready backlog and project tracker for `iansherr/alternate`. No app code was changed. Do not start implementation before the planning gate is approved.
>
> Created 2026-11-21 against fork/upstream `main` at `a434f408fd693332948e67183620797a6019ab8e` (Alternate Android 3.2.0). Fork Issues was disabled when this roadmap was prepared. Convert the tickets in [ISSUE_BACKLOG.md](ISSUE_BACKLOG.md) to GitHub Issues after enabling it; link them in [PROJECT_BOARD.md](PROJECT_BOARD.md).

## Purpose
Offer a fully offline, open-source secondary iPhone address book whose contacts **do not enter Apple Contacts**, and which identifies opted-in incoming callers using native iOS Call Directory. Pursue Android stability and meaningful, modest upstream contributions before broad porting. Kotlin Multiplatform + Compose Multiplatform and Room KMP are candidates subject to feasibility validation, **not** a pre-approved rewrite.

## Unnegotiable constraints
1. No unrequested writes to Apple Contacts, no remote caller-ID lookup or network dependency, and no Android-style system-wide overlay on iOS. Explicit consent for minimal OS caller ID mapping.
2. Android parity is a release gate: preserve package ID, signing/update path, existing Room schema and v2.x migrations, app lock, overlays, call-screening/directory services, and API behavior.
3. Protect user data, especially name/number index accessible to iOS extension. App Group caller index holds only normalized phone number plus intentionally chosen visible alias; no notes, addresses, emails, photos, auth keys or full vault. Account for locked phone/reboot and OS caller history.
4. PRs must be independently reviewable, avoid duplicate carriers and destructive squash, and include exact SHA and test results. An open green PR is *not* landed. Branches and unretired work are never thrown away without provenance.
5. Do not contact upstream or publish new upstream issues/PRs without explicit user approval. Avoid overlap with upstream [#39](https://github.com/BioHazard786/Alternate/issues/39) and [#40](https://github.com/BioHazard786/Alternate/issues/40).

## Scope and acceptance
### MVP (must all hold)
- Add/import/edit/delete and browse a local iPhone directory; searchable names and multiple numbers, groups/favorites as supported by shared model.
- Apple Contacts remains unchanged and unneeded for core use.
- A real iPhone identifies an incoming test number through iOS's native Call Directory while the main application is locked or not running; an unknown caller remains unknown.
- Opt-in per index and clear disablement; changes/deletions synchronize without persistent stale identifiers after reload verification.
- Lock/Face ID and deliberate outgoing dialing; explicit disclosure that OS caller labels/Phone Recents can remain visible, and iOS cannot prevent all accidental callbacks.
- VCF round trip with safe file handling; no uploads, analytics or hidden sync.
- Existing Android build/upgrade/migration/privacy behavior verified, and iOS signed device build and reproducible CI evidence.

### Not MVP
- Native iOS full call log access, Android-style live floating incoming overlay, remote Live Caller ID provider, call recording, automatic cloud sync, complete CRM, upstream #39 profiles and #40 backups/multi-format requests.

## Milestone exit gates
| Milestone | Goal | Exit |
|---|---|---|
| M0 Planning gate | Design and contributor alignment | All issues complete, dependency order checked, upstream proposal and risks approved; no code started |
| M1 Shared core | Gradual KMP extraction | Android baseline and migration pass; shared models/Room/domain compile and tests pass |
| M2 iOS contacts | iPhone app independent of Apple Contacts | Simulator+real device app with CRUD, import/export, security and navigation |
| M3 Native identification | iOS Call Directory integration | One real-device incoming call identified; add/edit/remove/disable verified; threat model and tests |
| M4 Quality/beta | Stable release candidate | Both platforms pass CI and privacy/accessibility/release checklists |
| M5 Upstream handoff | Independent contribution streams | Maintainer-approved bounded PRs or explicit retained fork strategy; no orphaned changes |

## Ticket conventions
- [ISSUE_BACKLOG.md](ISSUE_BACKLOG.md) is canonical detailed issue descriptions with exact IDs, dependencies, boundaries, acceptance and verification. Do not assume issue numbers until created.
- [PROJECT_BOARD.md](PROJECT_BOARD.md) contains project fields, priority and sequencing. Update URL/issue-number mapping after tickets are created.
- [UPSTREAM_PROPOSAL.md](UPSTREAM_PROPOSAL.md) is **draft only**, for approval before outreach.
- [issues.json](issues.json) contains a machine-readable copy for bulk issue creation once Issues is enabled.

## Planning gate
No implementation, prototype changes to app code, or upstream posts until: Issues enabled; roadmap children posted; board links populated; P0-01/P0-04/P0-03 design choices accepted; maintainer contact plan approved. Changes before then are limited to planning documents.