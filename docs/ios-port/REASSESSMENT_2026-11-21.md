# Alternate iOS port: whole-plan reassessment (2026-11-21)

**Decision:** Keep the fork **planning-only**, choose an *upstream-first, bounded* Kotlin Multiplatform path, but **do not assume a shared Compose UI or even KMP Room is mandatory** until a short, reversible proof of concept. Expand the original 35 tickets by 7 targeted omissions, rather than replacing the existing work.

## Evidence examined
- Current upstream and fork main: `a434f408fd693332948e67183620797a6019ab8e`, Android Alternate 3.2.0, one `:app` module.
- Android source uses Jetpack Compose / Material 3 Expressive, Room (database schema v5), DataStore, platform file/photo/bio APIs and a separate Android caller overlay.
- Repo `AppDatabase.kt` builds a normal Room DB; **no SQLCipher dependency or database encryption verified**. Do not equate private storage with encrypted-at-rest protection.
- Legacy 2.x migration reads prior MMKV data; keep Android upgrade parity.
- Current upstream open issues [#39](https://github.com/BioHazard786/Alternate/issues/39) (profiles) and [#40](https://github.com/BioHazard786/Alternate/issues/40) (backups/extra formats/sorting). Neither is in MVP. No upstream open PRs found at review.
- Apple Call Directory supports offline identification and incremental changes. An iOS extension is distinct from an Android overlay and from a Live Caller ID Lookup server. OS caller labels may appear in Recents and other system surfaces; full erasure and precedence **require device evidence**, not assumptions.
- JetBrains KMP/Compose/Room have iOS support, but Android-specific Compose Material components and Gradle plugin interop are a real migration risk.

## Seven additions / why

| New ticket | Finding | What it prevents |
|---|---|---|
| [P0-07](https://github.com/iansherr/alternate/issues/37) | KMP+Compose is treated as predetermined | Endless UI migration or unnecessary upstream disruption; explicitly compare SwiftUI + shared Kotlin |
| [P0-08](https://github.com/iansherr/alternate/issues/38) | iPhone signing/device availability not a preflight | Reaching the end of a migration without ability to validate actual incoming calls |
| [SEC-01](https://github.com/iansherr/alternate/issues/39) | Existing privacy isolation is not demonstrated encryption at rest | Overstating security and leaking unprotected SQLite/backup/extension data |
| [UX-01](https://github.com/iansherr/alternate/issues/40) | Accidental calls and accidental vCard/address disclosure not independently acceptance-tested | Missing the user problem that motivated this product |
| [CID-06](https://github.com/iansherr/alternate/issues/41) | Label precedence, OS caching, phone-format ambiguity and scalability not proven | Wrong caller labels or misleading promises about de-registration |
| [DATA-01](https://github.com/iansherr/alternate/issues/42) | Migration/import merge ambiguity is not fully specified | Silent loss, duplicate contacts or non-reversible Android/iOS imports |
| [OPS-01](https://github.com/iansherr/alternate/issues/43) | No firm long-term maintenance/fork versus upstream release owner | A permanent second maintenance burden and surprise signing/security obligations |

## Risks requiring explicit go/no-go decisions

### Architecture / scope
1. **Shared core is the default hypothesis; shared UI is conditional.** Compare: (A) KMP models/repository with SwiftUI iOS, (B) Compose Multiplatform iOS, (C) independent Swift iOS with a portable VCF contract. Reject architecture by measurable effort, platform API gaps, actual tests, Android regression risk and upstream appetite.
2. **Start with two independent spikes only after explicit implementation approval**: a tiny shared Kotlin compile + database path, and a one-number Swift Call Directory extension on a real iPhone. Do not tie successful phone identification to having already ported the UI.
3. **No mass refactor.** Keep Android release ID/signing, v2.x migration, existing private directory and app behavior. Review and test each portable extraction independently. Keep source head/provenance intact.

### Product / privacy
4. **Private is not invisible.** Existing app-lock protection does not hide Caller ID labels loaded by iOS. Never advertise complete butt-dial prevention: native Phone Recents and third-party caller lists remain OS-controlled.
5. **Index separation:** Full directory stores notes, addresses and photos. The App Group projection contains only consented phone identifiers and intentionally chosen aliases; does not contain full DB, secrets or encryption keys. Define availability after boot/locked state, storage/backup protection, atomic revision and deletion.
6. **Number identity:** Distinguish raw import string, canonical number, display number, iOS numeric Call Directory key and contact membership. Require deterministic duplicate and ambiguous international-code policy. Display neutral/short aliases where privacy demands.
7. **Import/export:** No uncontrolled sharing of full vCards, addresses or notes; explicit scope and preview for share flows. Import duplicate resolution is deterministic with rollback. Do not silently insert into Apple Contacts.

### iOS platform specifics / quality
8. **Native caller ID versus Android popup:** iOS Call Directory cannot reproduce overlays, cross-app access to Phone Recents or pre-answer custom detail panels. Track unsupported features in parity table.
9. **System labeling conflicts:** iOS Contacts, carrier/Apple business identification and another caller-ID app may affect display. Do not assume precedence. Testing must include enable/disable, revocation, reboot, collision, unknown/withheld numbers and reload failure.
10. **Distribution/testing:** Paid developer/team signing, App Group/extension entitlements, iPhone + second caller, real-device lock and cellular tests are prereqs. Simulator success is not end-to-end proof.
11. **Security claims:** Document Android actual at-rest state and iOS file protection/encryption strategy, encrypted/non-encrypted backups, WAL/temp files, key rotation, PIN storage and sensitive logging.
12. **Accessibility/product parity:** Treat iPhone as a native-feeling private directory. Shared Material 3 is optional if it breaks VoiceOver/gestures/navigation/platform conventions.

### Open source / governance
13. **Upstream is a partner, not a dependency for iOS product success.** Prepare draft outreach, gain owner approval before posting, and keep upstream-suitable PRs small. Do not duplicate upstream profiles/backups features.
14. **Budget maintenance upfront:** Document fork divergence, secure releases, signing, iOS version drift, CVEs, and fallback if upstream accepts shared core but declines iOS. An MIT code license doesn't automatically grant third-party branding rights.
15. **Project artifact limitation:** GitHub Issues are live. The board is a versioned Markdown project view because the currently connected GitHub integration offers no GitHub Projects create/update action. Don't misrepresent it as an actual GitHub Project.

## Revised stage gates
- **Gate A / planning accepted:** all 42 tickets issue-linked; dependency DAG audited; [P0-07](https://github.com/iansherr/alternate/issues/37), [P0-08](https://github.com/iansherr/alternate/issues/38), [SEC-01](https://github.com/iansherr/alternate/issues/39) and [UX-01](https://github.com/iansherr/alternate/issues/40) design choices recorded; upstream communications approved independently; clear scope/stop criteria.
- **Gate B / authorized feasibility experiments:** only minimal demo code is permitted. Require a test device, code signing and small shared-module compilation; results recorded for decision. If either demo fails, downgrade shared UI ambitions instead of launching a sweeping rewrite.
- **Gate C / phased implementation:** land tested shared code in independent carriers, prove Android migration preservation, then iPhone contacts and native Call Directory. All dependencies and current upstream head reevaluated per PR.
- **Gate D / readiness:** real iPhone inbound call identification while app locked, no Apple Contacts writes, safe vCard and accidental dial flows, index change/removal, privacy/security and Android parity evidence.
- **Gate E / upstream/release:** owner-approved upstream proposal; upstream acceptance not assumed; fork-branding/license, release support and data migration obligations documented.

## Important unknowns (not resolved by planning)
- Will Alternate's maintainer accept KMP or just portable utilities?
- Which Compose Material3 Expressive controls compile and behave correctly on the chosen Kotlin/Xcode/Compose versions?
- Which Apple Developer membership, entitlement path and physical test devices are actually available?
- Does offline on-device Room database require additional encryption beyond iOS file protection under the selected threat model?
- How do iOS Call Directory labels behave across collisions with Apple Contacts and other caller-identification sources on the target iOS version?
- What bounded time/maintenance investment is acceptable before stopping or switching to SwiftUI?

**No implementation work, upstream outreach, iOS provisioning or distribution is claimed complete.**