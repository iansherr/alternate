# Room Kotlin Multiplatform persistence feasibility

This is an **independent, reversible spike** stacked on draft PR #46, not a schema migration. It tests whether Room 2.8.5 and SQLite Bundled 2.7.1 can generate a separate common DAO/database for Android+iOS using Alternate's pinned Kotlin/KSP/AGP toolchain.

## Non-negotiable boundaries
- No changes to existing `:app` source, schema v5, `caller_database`, legacy 2.x MMKV migration, Android package identity, caller overlay, contacts or app storage.
- The experiment has its own table `probe_contacts`, database path, DTO and generated KSP constructor. It contains **fictional test numbers and aliases only**, not a production contact vault or Caller ID index.
- iOS test makes a temporary SQLite file using BundledSQLiteDriver, performs insert, updates, persists/reopens and deletes. Android CI ensures existing app build and unit tests remain green.
- Full iOS encryption, file-protection, backups and signed device behavior are not proved by this test. Any later migration of real Android entities must preserve schema/migrations with device fixtures.
- Keep as a **draft PR**; no upstream messages, independent merges or destructive branch squash.

GitHub Actions checks:
- Ubuntu JDK21: `:app:testDebugUnitTest :app:assembleDebug :shared-core:assemble :shared-core:testAndroidHostTest`.
- macOS26/Xcode26.4.1: `:shared-core:iosSimulatorArm64Test` (real simulator execution, not just Kotlin compilation).

Docs: https://developer.android.com/kotlin/multiplatform/room and https://developer.android.com/codelabs/kmp-migrate-room

Issues: [KMP-05 #12](https://github.com/iansherr/alternate/issues/12), [DATA-01 #42](https://github.com/iansherr/alternate/issues/42), [P0-07 #37](https://github.com/iansherr/alternate/issues/37).
