# Feasibility results — Alternate Android + KMP + native iOS extension

**Verified 2026-11-21.** This document distinguishes passing build evidence from work that remains unproven. All test PRs are fork-local, **draft and unmerged**. Neither fork `main` nor upstream `main` has been changed by these tests.

## Exact-head results
| Carrier | Verified exact head | GitHub Actions evidence | What passed |
|---|---|---|---|
| [PR #44 — Android CI](https://github.com/iansherr/alternate/pull/44) | `7c58e85403e1be3db352c31dfb80e44496e1e4e2` | [run #44916393798](https://github.com/iansherr/alternate/actions/runs/44916393798) **success** | Existing `:app:testDebugUnitTest`, `:app:assembleDebug`, JDK21/Gradle9.9.1/Android preview 37.0 |
| [PR #46 — additive KMP module](https://github.com/iansherr/alternate/pull/46) | `e386acfded5a640d82a5a8455d13c07ec0e9ccb6` | [run #44917550243](https://github.com/iansherr/alternate/actions/runs/44917550243) **success** | Existing app tests/debug build, new `:shared-core:assemble` + actual `:shared-core:testAndroidHostTest`, macOS26/Xcode26.4.1 iOS simulator Kotlin main + test-source compilation |
| [PR #47 — native iOS extension](https://github.com/iansherr/alternate/pull/47) | `d4a84dd3ac94bed4fc33de297fe258842abb5497` | [run #44917949518](https://github.com/iansherr/alternate/actions/runs/44917949518) **success** | SwiftUI host + CallKit `CXCallDirectoryProvider` compile, `CallerIdExtension.appex` embedded in unsigned simulator app, correct `com.apple.callkit.call-directory` extension point verified |

## Why these results matter
1. Alternate's currently pinned Kotlin 2.4.21, AGP 9.5.1 and Gradle 9.9.1 *actually compile* with the new AGP9 KMP library plugin and iOS simulator target, despite published fully supported/fully tested matrices being narrower. That resolves the immediate risk of a Gradle/plugin hard blocker for an **additive, pure Kotlin shared module**.
2. Existing Android source, Room schema 5, legacy MMKV conversion, caller popup, package ID and release signing were **not modified** by either proof.
3. Native Apple Call Directory extension can compile and package independently of KMP, supporting the planned separation of the OS integration from the private contact directory.

## What is **not** proven
- Room KMP persistence on iOS, `ContactDao` migration, v2.x MMKV data migration on a real Android upgrade path, SQLCipher/file protection or database backup security.
- Compose Multiplatform UI parity, SwiftUI/Kotlin integration, full user interaction, VCF import/export or accidental-call/share safety.
- **Actual native incoming call identification.** The Swift probe contains only one fictional `+1-202-555-0124` number and runs CI as an **unsigned simulator build**; it does not receive real calls, has no private directory, user permissions or App Group index.
- Apple Developer signing, App Group entitlements, actual iPhone extension enablement, extension reload after add/delete, iOS Phone Recents and caller-label precedence.
- Upstream maintainer acceptance of KMP or iOS code.

## Next decision gate
- Owner reviews and decides whether the shared business core is accepted as preferred architecture, with **SwiftUI versus Compose still open**.
- Obtain Mac/Xcode signing and an actual test iPhone with a controlled inbound calling line to prove one iPhone caller-ID mapping without Apple Contacts.
- Validate minimal App Group opt-in number+alias index, atomic snapshot/reload/deletion/privacy rules before using real directory data.
- Run Android device migration fixtures before moving Room or upgrade code.
- Open upstream discussion/PRs **only after explicit owner authorization**. Preserve all code carriers and exact-head evidence.

## Workstream source links
[Roadmap #1](https://github.com/iansherr/alternate/issues/1) · [KMP-01 #8](https://github.com/iansherr/alternate/issues/8) · [iPhone capability preflight #38](https://github.com/iansherr/alternate/issues/38) · [Caller Directory #24](https://github.com/iansherr/alternate/issues/24) · [Architecture ADR](ADR-001_ARCHITECTURE.md).
