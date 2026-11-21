# Shared-core KMP proof of concept

This is an isolated **experiment**, not a completed Alternate port.

Goal: verify a new, additive Kotlin Multiplatform library works alongside the unchanged Android 3.2.0 application. Android app code, manifest, database, signing and release tasks are not changed.

The toy `CallerIdEntry` validation and sorting contract proves only common Kotlin code can compile and be tested on Android/iOS targets. It does **not** implement iPhone Call Directory, phone parsing, consent, persistence or secure storage. The sample aliases and numbers are synthetic.

Targets: Android (`com.android.kotlin.multiplatform.library`), `iosArm64`, `iosSimulatorArm64`. Compiling an iOS target requires macOS/Xcode; seeing only Linux Android green is not a cross-platform proof.

## Proof
- Android: `./gradlew :app:testDebugUnitTest :app:assembleDebug :shared-core:assemble :shared-core:testAndroidHostTest`
- macOS: `./gradlew :shared-core:compileKotlinIosSimulatorArm64 :shared-core:compileTestKotlinIosSimulatorArm64`
- Tests: Kotlin `commonTest` for sorted, duplicate and malformed minimal IDs.

No dependencies on the Android app and no runtime changes. Keep this PR **draft** until both platforms compile and the Android KMP host tests execute on the exact PR head. iOS compilation is not the same as running tests in an iPhone simulator. See [KMP-01](https://github.com/iansherr/alternate/issues/8), [P0-07](https://github.com/iansherr/alternate/issues/37), [architecture ADR](https://github.com/iansherr/alternate/blob/planning/kmp-ios-roadmap/docs/ios-port/ADR-001_ARCHITECTURE.md).
