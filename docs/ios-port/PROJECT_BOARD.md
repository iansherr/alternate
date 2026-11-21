# Alternate iOS + KMP — project board (source of truth until GitHub Projects is available)

## Project status
**Planning / No implementation authorized.** Fork Issues currently disabled; enable in repository Settings → General → Features → Issues before creating real GitHub issue cards. This branch is documentation-only and upstream `main` remains unchanged.

## Columns
- **Backlog** — described but not ready to claim
- **Ready** — dependencies landed; exact-head baseline checked and work unowned
- **Claimed / In progress** — one owner/branch; log timestamp, PR and SHA
- **Review / Verification** — tests and all expected checks evaluated; not yet landed
- **Blocked** — record dependency, reason and unblock criterion
- **Landed** — relevant behavior on authoritative target main, acceptance proven
- **Deferred** — explicitly outside MVP with explanation

## Required fields per card
Stable ticket ID, GitHub issue URL, title, milestone, priority, risk, owner, dependency IDs, status, branch, PR URL, head SHA, base SHA, required and observed checks, last update, handoff/next action, upstream acceptance eligibility.

## Milestone allocation
| Milestone | Workstream | Exit |
|---|---|---|
| M0 | P0 Discovery/governance | Design, privacy, compatibility and approvals complete |
| M1 | KMP Shared core | Android parity + multiplatform compile and model/database tests |
| M2 | iOS application | Local directory, CRUD, lock and import/export operational |
| M3 | iOS caller ID | Offline native Caller Directory verified on physical iPhone |
| M4 | Quality/release | CI, negative/security tests, accessibility and beta readiness |
| M5 | Upstream handoff | Bounded PRs or consciously retained fork delta |
| Later | Optional | Separately approved enhancements |

## Full planned queue

| ID | Milestone | Priority | Status | Dependencies | GitHub issue |
|---|---|---|---|---|---|
| P0-01 | Discovery & governance | critical | Backlog | — | _Pending Issues enablement_ |
| P0-02 | Discovery & governance | critical | Backlog | — | _Pending Issues enablement_ |
| P0-03 | Discovery & governance | critical | Backlog | P0-02 | _Pending Issues enablement_ |
| P0-04 | Discovery & governance | critical | Backlog | P0-01, P0-02 | _Pending Issues enablement_ |
| P0-05 | Discovery & governance | critical | Backlog | P0-02, P0-03, P0-04 | _Pending Issues enablement_ |
| P0-06 | Discovery & governance | high | Backlog | P0-05 | _Pending Issues enablement_ |
| KMP-01 | Kotlin shared core | critical | Backlog | P0-01, P0-04, P0-05 | _Pending Issues enablement_ |
| KMP-02 | Kotlin shared core | critical | Backlog | KMP-01 | _Pending Issues enablement_ |
| KMP-03 | Kotlin shared core | critical | Backlog | KMP-02 | _Pending Issues enablement_ |
| KMP-04 | Kotlin shared core | high | Backlog | KMP-02 | _Pending Issues enablement_ |
| KMP-05 | Kotlin shared core | critical | Backlog | KMP-01, KMP-02, P0-01 | _Pending Issues enablement_ |
| KMP-06 | Kotlin shared core | critical | Backlog | KMP-03, KMP-05 | _Pending Issues enablement_ |
| KMP-07 | Kotlin shared core | high | Backlog | KMP-01, P0-03 | _Pending Issues enablement_ |
| KMP-08 | Kotlin shared core | high | Backlog | KMP-02, KMP-04 | _Pending Issues enablement_ |
| KMP-09 | Kotlin shared core | high | Backlog | P0-04, KMP-01, KMP-06 | _Pending Issues enablement_ |
| IOS-01 | iOS application | critical | Backlog | KMP-01, P0-03, P0-04 | _Pending Issues enablement_ |
| IOS-02 | iOS application | critical | Backlog | IOS-01, KMP-06, KMP-09 | _Pending Issues enablement_ |
| IOS-03 | iOS application | critical | Backlog | IOS-02, KMP-06 | _Pending Issues enablement_ |
| IOS-04 | iOS application | high | Backlog | IOS-03, KMP-04, KMP-08 | _Pending Issues enablement_ |
| IOS-05 | iOS application | critical | Backlog | IOS-01, KMP-07, P0-03 | _Pending Issues enablement_ |
| IOS-06 | iOS application | high | Backlog | IOS-02, P0-02, P0-03 | _Pending Issues enablement_ |
| CID-01 | iOS caller ID | critical | Backlog | KMP-03, KMP-06, P0-03, IOS-01 | _Pending Issues enablement_ |
| CID-02 | iOS caller ID | critical | Backlog | CID-01, IOS-01 | _Pending Issues enablement_ |
| CID-03 | iOS caller ID | critical | Backlog | CID-01, CID-02, IOS-03 | _Pending Issues enablement_ |
| CID-04 | iOS caller ID | critical | Backlog | CID-02, CID-03, IOS-05 | _Pending Issues enablement_ |
| CID-05 | iOS caller ID | medium | Backlog | CID-04, IOS-06 | _Pending Issues enablement_ |
| QA-01 | Quality/release | critical | Backlog | KMP-01, IOS-01 | _Pending Issues enablement_ |
| QA-02 | Quality/release | critical | Backlog | KMP-05, KMP-06, CID-03 | _Pending Issues enablement_ |
| QA-03 | Quality/release | high | Backlog | IOS-04, IOS-05, CID-04, P0-03 | _Pending Issues enablement_ |
| QA-04 | Quality/release | high | Backlog | IOS-03, IOS-06 | _Pending Issues enablement_ |
| QA-05 | Quality/release | high | Backlog | QA-01, QA-02, QA-03, QA-04 | _Pending Issues enablement_ |
| QA-06 | Quality/release | critical | Backlog | QA-05, P0-05 | _Pending Issues enablement_ |
| OPT-01 | Optional later | optional | Deferred | QA-03 | _Pending Issues enablement_ |
| OPT-02 | Optional later | optional | Deferred | CID-04 | _Pending Issues enablement_ |
| OPT-03 | Optional later | optional | Deferred | IOS-03 | _Pending Issues enablement_ |

## Sequencing / lane discipline
1. Planning gate: P0-01 through P0-06, including maintainer-facing proposal as **draft only** and iOS feasibility decision.
2. Shared-core first: KMP-01; models + utils in constrained carriers; Room/schema then repository; optional UI/photo/settings extraction in separate branches.
3. Independent UI/app lane may start when KMP-01 and relevant contracts land; iOS contacts CRUD must precede binding index reload to edits.
4. Native Call Directory index contract and Swift extension are independent carriers; require real-device testing for final acceptance.
5. Release lane includes positive + negative tests, Android upgrades, security, signing and exact-head checks.
6. Optional tracks not eligible for MVP unless formally promoted and ticket acceptance renegotiated.
7. On any upstream divergence, refresh baseline, inventory new PR/issues and rebase/cherry-pick proven isolated changes; **never squash or close a dependency before tracking what behavior landed**.

## Definition of ready
No unowned conflicting work; dependency behavior landed; source/current main SHA validated; boundaries and excluded files clear; test/acceptance plan feasible; specific implementing agent claimed branch+ticket.

## Definition of done
Code **landed** on appropriate target branch and required test evidence attached; app behavior verified, safety invariants preserved, migration parity checked where affected; no stale labels or lost work; remaining issues left with exact handoff. An open green PR never qualifies.

## Operating guidance for agent handoffs
Each issue/PR must include: objective; constraints; exact upstream/fork base SHA; branch/head SHA; owned paths; non-owned paths; deps and merge order; tests run and outputs; user-facing behavior proof; blockers; next eligible action.
