# P0 feasibility audit — source evidence and baseline (2026-11-21)

**Status: static inspection complete, runtime verification NOT DONE.** No Android application code changed. No Gradle, Android emulator, macOS Xcode or signed iPhone execution has occurred.

## Verified refs and source files
Fork and upstream `main`: `a434f408fd693332948e67183620797a6019ab8e`. Planning branch head at audit start `d7d6b30c3c875172aa67c786d363f202b91077f2`. Both forks have 0 open PRs; upstream open [#39](https://github.com/BioHazard786/Alternate/issues/39) profiles and [#40](https://github.com/BioHazard786/Alternate/issues/40) backups/sorting.

| Area | Current source evidence | Implication |
|---|---|---|
| Build graph | `settings.gradle.kts` only `include(":app")` | No KMP module yet. Add separate library without converting existing Android application. |
| Kotlin/AGP | `gradle/libs.versions.toml` Kotlin **2.4.21**, AGP **9.5.1**, KSP **2.3.14** | Kotlin's published **fully-supported** AGP range for 2.4.21 stops at 9.3.1; do not assume shared plugin works with current pins. |
| Gradle | `gradle/wrapper/gradle-wrapper.properties` Gradle **9.9.1** | Published Kotlin 2.4.21 tested/fully supported Gradle range stops at 9.7.0; may run, not yet validated. Avoid blindly changing Android pins to fix iOS. |
| Android app identity | `app/build.gradle.kts` application ID **com.lulu786.Alternate**, version 3.2.0, code 19, SDK 24–36, compile SDK 37 | Preserve package identity and Android upgrade path. |
| DB | `data/AppDatabase.kt` Room 2.8.5, schema **5**, name `caller_database`; migrations 2→3, 3→4, 4→5 | No destructive recreation; iOS DB may be new but Android schema/migration history is a contract. |
| Tests | `DataTests.kt`, `FilterTests.kt`, `MigrationTest.kt`; exported `app/schemas/.../5.json` | Existing fixture baseline; migration test uses a pre-v5 database. Tests exist but were NOT executed. |
| 2.x upgrade | `data/LegacyMmkvImport.kt`, `AlternateApp.kt` | Upgrade flow must be tested with real fixture and versions, not merely unit source review. |
| Caller recognition | `callerid/CallDirectoryProvider.kt` Android ContactsContract ContentProvider and `CallOverlay.kt` Android system overlay | iOS does NOT use this implementation. Must implement native Swift Call Directory and a minimal shared index. |
| UI | `ui/theme/Theme.kt` MaterialExpressiveTheme, platform dynamic color; `ui/components/Avatar.kt` Android LocalContext / shapes; navigation AndroidX | Compose UI reuse needs controlled compatibility probe; prefer shared business logic first. |
| Search/format | `util/Search.kt`, `util/Text.kt`, `callerid/PhoneNormalizer.kt` | `Search.kt` mostly pure but DTOs depend on Room rows; `Text.kt` includes Java Normalizer/date and Android PhoneNumberUtils. Extract surgically. |
| vCard | `util/Vcf.kt` exports 3.0, imports 2.1/3.0/4.0; relies on Room DTO types | Extraction requires shared DTO or mapper boundary, sanitizing and Unicode fixtures. |
| Storage/security | `AppDatabase.kt` uses ordinary Room builder; **no SQLCipher dependency found** in version catalog | Treat encryption-at-rest as **not verified**, not as present. |
| Backup | `app/src/main/AndroidManifest.xml`: `android:allowBackup="true"` | Android system backup may include application data depending on platform/backup rules and user configuration; audit, do not imply app itself uploads data. |
| Network | No `android.permission.INTERNET` in inspected main manifest | Supports offline design, but full dependency/network audit remains necessary before release claims. |

## Source references (exact upstream version)
- [Gradle catalog](https://github.com/BioHazard786/Alternate/blob/a434f408fd693332948e67183620797a6019ab8e/gradle/libs.versions.toml)
- [Wrapper](https://github.com/BioHazard786/Alternate/blob/a434f408fd693332948e67183620797a6019ab8e/gradle/wrapper/gradle-wrapper.properties)
- [Manifest](https://github.com/BioHazard786/Alternate/blob/a434f408fd693332948e67183620797a6019ab8e/app/src/main/AndroidManifest.xml)
- [DB and migrations](https://github.com/BioHazard786/Alternate/blob/a434f408fd693332948e67183620797a6019ab8e/app/src/main/java/com/lulu786/alternate/data/AppDatabase.kt)
- [Existing migration test](https://github.com/BioHazard786/Alternate/blob/a434f408fd693332948e67183620797a6019ab8e/app/src/androidTest/java/com/lulu786/alternate/MigrationTest.kt)

## Toolchain compatibility references
- [JetBrains KMP compatibility guide](https://kotlinlang.org/docs/multiplatform/multiplatform-compatibility-guide.html) (tested Kotlin 2.4.20/2.4.21: Gradle through 9.7.0; AGP through 9.3.1 as checked 2026-11-21).
- [JetBrains AGP 9 migration guidance](https://kotlinlang.org/docs/multiplatform/multiplatform-project-agp-9-migration.html). For a KMP Android library, use `com.android.kotlin.multiplatform.library` rather than applying the KMP plugin on the existing Android application.
- [Android KMP library plugin](https://developer.android.com/kotlin/multiplatform/plugin).

## Verification queue (NOT RUN)
Environment in this chat: Linux with Java/Kotlin CLI, **no Android SDK, no macOS/Xcode**, and GitHub cannot be cloned directly because outbound DNS/network access fails. Therefore cannot truthfully record Android green or iOS simulator status.

```bash
git clone https://github.com/BioHazard786/Alternate.git
cd Alternate
git checkout a434f408fd693332948e67183620797a6019ab8e
java -version
./gradlew --version
./gradlew :app:assembleDebug
./gradlew :app:testDebugUnitTest
# Android emulator/physical device with suitable API level:
./gradlew :app:connectedDebugAndroidTest
```

**Record:** JDK, SDK/NDK (if any), Gradle, AGP, Kotlin, Android image, test counts/results, exported schema diff, APK ID and no accidental permissions added. Do **not** silently alter dependency versions to produce green checks.

## Blocking decisions
1. Can the existing Android AGP 9.5.1 + Kotlin 2.4.21 + Gradle 9.9.1 toolchain reliably run baseline tests despite being outside published fully-supported ranges?
2. If not, is a separate pinned KMP shared-library module viable without changing Android app toolchain? If not, determine smallest toolchain upgrade/downgrade with source-backed risk assessment.
3. What Android backup/data protection behavior is required by the privacy charter? This is a separate security decision, not an automatic unrelated change to upstream.
4. Do not close [P0-01](https://github.com/iansherr/alternate/issues/2), [P0-04](https://github.com/iansherr/alternate/issues/5), or [SEC-01](https://github.com/iansherr/alternate/issues/39) until actual test evidence or explicit accepted limitation is attached.
