# Alternate — maximum hardware-free acceptance matrix

**Purpose:** Run every useful automated check possible on GitHub-hosted Android emulators, iOS simulators, and macOS Swift tests before asking for access to a physical iPhone. An unsigned simulator build cannot demonstrate the native Phone caller-ID outcome.

## Exact scope and branch discipline
- Fork and upstream `main` at `a434f408fd693332948e67183620797a6019ab8e` when hardware-free CI was introduced. Do **not** merge any draft PR merely because its checks are green.
- Respect separate PR carriers and their ancestry:
  - Android CI #44 → emulator CI #53 → v2→v5 fixture #54
  - KMP base #46 → Room iOS persistence #52
  - Swift Call Directory #47 → consented index #50 → simulator and emission tests #51
  - Planning documents #45 are separate. No upstream submissions authorized.
- Avoid combining/retiring the stacks without a reviewed full behavior/fixture lineage. Green open PR ≠ landed.

## Hardware-free checks (live GitHub Actions links)
| Test | PR | What it actually checks | Current evidence and limitation |
|---|---|---|---|
| Existing Android build + unit tests | [#44](https://github.com/iansherr/alternate/pull/44) | Debug APK and Android JVM unit tests on JDK21 | [Run 44916393798](https://github.com/iansherr/alternate/actions/runs/44916393798) green |
| KMP pure Android+iOS compile + native host tests | [#46](https://github.com/iansherr/alternate/pull/46) | Kotlin/Native iOS simulator compile, Android KMP tests and unchanged Android app | [Run 44917550243](https://github.com/iansherr/alternate/actions/runs/44917550243) green; no iOS app |
| Swift native Call Directory host/extension build | [#47](https://github.com/iansherr/alternate/pull/47) | Build/validate embedded `.appex` and extension point | [Run 44917949518](https://github.com/iansherr/alternate/actions/runs/44917949518) green; no live call |
| Consent index validation, revocation snapshot and packaging | [#50](https://github.com/iansherr/alternate/pull/50) | Seven Swift index tests, opt-in, invalid/duplicate input, atomic write, disabled snapshot, unsigned iOS packaging | [Run 44936063500](https://github.com/iansherr/alternate/actions/runs/44936063500) green; App Group entitlement and physical file protection not validated |
| Pure Call Directory emission, simulator install and UI smoke | [#51](https://github.com/iansherr/alternate/pull/51) | Full/incremental ordered Caller ID commands, clear/no-consent behavior, XCUITest UI smoke on simulator | [Actions workflow](https://github.com/iansherr/alternate/actions/workflows/ios-call-directory-probe.yml); exact-head outcome to be recorded from CI |
| Room on iOS, unchanged Android data layer | [#52](https://github.com/iansherr/alternate/pull/52) | Distinct `probe_contacts` Room KMP database, iOS-simulator insert/update/reopen/delete, Android compile/regression | [First run 44968563253](https://github.com/iansherr/alternate/actions/runs/44968563253) green; exact-head XML-report test execution verification added in successor head |
| Android raw-SQL v4→v5 migration on emulator | [#53](https://github.com/iansherr/alternate/pull/53) | Run existing instrumentation test using API35 emulator and immutable pinned runner | [Actions workflow](https://github.com/iansherr/alternate/actions/workflows/android-emulator-migrations.yml); runtime outcome pending at initial record |
| Android raw-SQL v2→v5 migration via full chain | [#54](https://github.com/iansherr/alternate/pull/54) | New synthetic v2 country-code/location fixture, preserves contact and number through v2→3→4→5 | Stacked on #53, result pending |

## Must not be claimed without a physical signed iPhone
1. Actual native Phone incoming caller label display from a controlled calling number, especially if app not running or screen locked.
2. Apple extension enablement, App Group entitlements and data protection after reboot/first unlock on real device; simulator file permissions are not hardware security.
3. Real Call Directory incremental reload/disable, OS-cached historical Recents labels, caller identity precedence, dual SIM/unknown numbers and device-specific resource limits.
4. Face ID, Keychain and device security/backup policies; real iOS Contacts visibility and accidental-dial behavior outside the app.
5. Any Apple Contacts/ContactProvider Messages or macOS Messages lookup claim (deferred #48/#49).

## Future automated tests before implementation rollout
- Shared Kotlin JSON snapshot exported to Swift decoder, including cross-platform adversarial normalization, aliases and schema versioning.
- Deterministic iOS app contact creation/search/edit/delete and import/export using a test database, with App Group caller-index projection and removal paths.
- Stress/data fuzz tests for ambiguous and duplicate phone numbers, malicious vCards and private address/notes disclosure.
- Release-policy and Android full device-upgrade fixtures; a raw SQLite migration fixture is strong, but not identical to an old signed Android APK upgrading in place.
- If the simulator cannot launch UI tests on hosted CI, keep pure domain tests and signing-free packaging green; document the runner limitation without bypassing it.

## Handoff
No local Apple credentials, real phone numbers or secrets are needed in this phase. Before a physical-device session, consult [REAL_DEVICE_HANDOFF.md](REAL_DEVICE_HANDOFF.md). Attach exact head SHA and run links before marking any test done. No automatic merges or upstream outreach.

## Verification update — November 21, 2026 (local)
- **Room KMP iOS execution is affirmatively green:** [run #44968961303](https://github.com/iansherr/alternate/actions/runs/44968961303) on head `2439de114e1105a6af75b4fbebe69584dd51b46a` shows three iOS native test cases executed, zero failures, zero skips: `insertUpdateDeleteSurviveReopen`, caller-index numeric sorting and rejection; Android job also green. The separate Room probe remains unmigrated from Android schema v5.
- **iOS UI simulator boot/install succeeded:** [run #44968426280](https://github.com/iansherr/alternate/actions/runs/44968426280) installed and launched the unsigned host; privacy disclosure/opt-in UI test passed. A second XCUITest failed because it assumed an offscreen `Retry iOS caller-ID reload` button would remain visible after tapping status, not from a crash. [Successor head `92e0f38`](https://github.com/iansherr/alternate/pull/51) checks that the active navigation/extension status control survives instead; exact-head UI rerun pending at this update.
- **Existing Android device-based migration fixture is not yet green:** [run #44968692816](https://github.com/iansherr/alternate/actions/runs/44968692816) booted the API35 Android emulator, compiled and attempted `:app:connectedDebugAndroidTest`, but Gradle reported failing instrumented tests without showing case details. Diagnostics-only [PR #53](https://github.com/iansherr/alternate/pull/53) successor head `a921cf4b` captures test failure XML to isolate the cause. Synthetic v2→5 [PR #54](https://github.com/iansherr/alternate/pull/54) also requires test evidence.
- Do **not** infer the failure is in migration SQL or assume Android upgrade acceptance is complete; first inspect the actual instrumentation failure trace.

## Further exact-head verification — Nov 21 2026
- **iOS Swift and UI integration passed:** [#51 run 44969196906](https://github.com/iansherr/alternate/actions/runs/44969196906), commit `92e0f38f27a82e551cfaaa882dfbfc503a968e73`: 12 Swift contract/emission test cases exercised, zero failures; unsigned iOS host + native Call Directory extension packaged correctly; simulator app installed/launched; XCUITest **2 executed, 0 failures** (privacy disclosure/opt-in controls and extension-status action). The first #51 run failed a brittle offscreen control assertion and the successor repaired **only the UI test**, not the iOS app implementation.
- **Android CI diagnosis:** [#53 diagnostic run 44969283065](https://github.com/iansherr/alternate/actions/runs/44969283065) found `MigrationTest initializationError` / JUnit `InvalidTestClassError: Method migratesCallerInfoToContactsAndPhones() should be void`. Previous expression-body `= runBlocking { ... }` implicitly returned Boolean from `context.deleteDatabase(name)` terminal expression. No migration SQL was exercised. A block-body/JUnit void signature fix is on #53 head `ecc5dfa45ea70a870e98ddf1598b59f58d9465ca`, [retest](https://github.com/iansherr/alternate/actions/runs/44969751038) pending.
- **Full v2→5 fixture and preserved ancestry:** #54 now has merge commit `45e07d805d2954ceae52630c1bd93ef89e2b460e` with *both* the original v2 fixture branch and corrected #53 as parents; GitHub shows it mergeable with 0 behind parent. This is not merged to main. [Retest](https://github.com/iansherr/alternate/actions/runs/44969898083) pending.
