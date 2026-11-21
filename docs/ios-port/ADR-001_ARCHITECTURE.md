# ADR-001: An additive shared core, with native iOS Caller ID

**Status: proposed, not accepted (2026-11-21).** Owner review and implementation verification needed. Covers [P0-04](https://github.com/iansherr/alternate/issues/5), [P0-07](https://github.com/iansherr/alternate/issues/37), [KMP-01](https://github.com/iansherr/alternate/issues/8) and [IOS-01](https://github.com/iansherr/alternate/issues/17).

## Context
Alternate 3.2.0 is a working Android app in one `:app` Gradle module using AndroidX Compose Material 3 Expressive, Room, DataStore and Android-only caller integrations. The user prefers meaningful upstream contribution and low fork maintenance over rebuilding an unrelated app. An iOS version must remain offline and separate from Apple Contacts. iOS cannot replicate Android's system overlay or unrestricted native Phone call log.

## Candidate comparison
| Criterion | A: KMP shared domain/data + native SwiftUI | B: KMP domain/data + shared Compose UI | C: independent native iOS with VCF/API contract |
|---|---|---|---|
| Reuse | Good data/domain reuse | Maximum theoretical reuse | Minimal code, good data portability |
| iOS-specific UI quality | Natural/native | Requires careful platform adaptation | Natural/native |
| Android regression risk | Moderate, contained by adapters | Higher due to UI extraction | Lowest initially |
| KMP tooling requirements | Yes | Yes + Compose compatibility | No |
| Engineering effort | Moderate | Potentially largest | Smallest iOS start, duplicated maintenance |
| Upstream contribution | Pure code + tests may be attractive | Broad architectural change may be hard to review | Limited reusable upstream work |
| Design risk | Swift/Kotlin interoperability & Room drivers | Material 3 Expressive, AndroidX Navigation/LocalContext, avatars | Diverging business rules and data models |

## Provisional decision
1. **Prefer A for feasibility:** isolate cross-platform *pure* models, number parsing/search, domain use cases and appropriate Room contracts incrementally. A SwiftUI host can consume the shared core if UI reuse under B stalls. Never port Android caller overlay.
2. **Retain B as an optimization:** attempt one iOS Compose list/card only after matching Kotlin/Compose versions are validated. No broad UI migration before objective evidence.
3. **Retain C as fallback:** if KMP tooling blocks or forces Android degradation, build an independent native iOS contacts proof using vCard, while continuing useful isolated upstream PRs.
4. **Keep the Android app in `:app` using its existing AGP plugin.** Introduce KMP as an *additional* library module, targeting Android + iosArm64 + iosSimulatorArm64, with the new AGP 9 KMP Android library plugin. Do not apply KMP to `com.android.application`.
5. **Use native Swift for iOS Call Directory**, with App Group index written atomically from the main app. The extension reads no Kotlin/Room vault directly, no network, and no access to full contact fields.

## Version hazard
At current `main`, Kotlin 2.4.21, AGP 9.5.1 and Gradle 9.9.1 are **outside the currently published Kotlin 2.4.21 fully-tested maximum AGP 9.3.1 and Gradle 9.7.0**. This is not definitive incompatibility; it is a measured test blocker. Do not solve with sweeping version changes. Pin a reproducible KMP-compatible tuple after a real build.

## Reversible experiment order
A. Android baseline on *unchanged* upstream exact head, including upgrade/migration fixture.
B. Independent iOS native Call Directory one-number test on signed iPhone. This does not require a running Compose/Room KMP app and tests the key product risk first.
C. Additional KMP module compiles pure model on Android/iOS simulator; compile + unit tests on both.
D. Test Room iOS driver and one realistic contact multi-number roundtrip; ensure Android v5 compatibility.
E. Render either shared Compose UI or native SwiftUI contact view, chosen on evidence.

**Stop signal:** Android data loss, inability to reproduce legacy upgrade path, invasive version downgrade, iOS extension entitlement block, persistent caller label leaks, or disproportionate upstream maintenance footprint. Explicitly revisit product architecture rather than continuing by inertia.

## Acceptance
- [ ] Reproduce Android baseline tests with verified exact-head logs.
- [ ] Confirm documented Kotlin + AGP + Gradle + Xcode combination on real toolchain.
- [ ] Obtain actual iOS signed device caller-ID evidence.
- [ ] One KMP data/model test passes on both targets.
- [ ] Owner approves shared UI or SwiftUI decision and upstream maintenance strategy.

## Spike evidence (November 21, 2026)
- [Draft additive KMP proof PR #46](https://github.com/iansherr/alternate/pull/46), head at first iOS compile `a4dd9853be16b61ce0c1ea8515e344776afeab99`, introduces a new `:shared-core` KMP Android+iOS library without modifying existing Android source.
- The macOS 26 / Xcode **26.4.1** job [run #44917159244](https://github.com/iansherr/alternate/actions/runs/44917159244) reported `:shared-core:compileKotlinIosSimulatorArm64` **BUILD SUCCESSFUL**, verifying Kotlin/Native iOS-simulator compilation on the existing toolchain.
- This **does not** validate a working iOS application, Room on iOS, or OS caller identification. Android build and KMP test coverage remain separate acceptance requirements.
- Important: the published Kotlin-AGP/Gradle version support table is conservative; actual simulator compilation succeeding is more useful than treating the version mismatch as an absolute blocker. Keep warning but distinguish *supported range* from *observed run*.
