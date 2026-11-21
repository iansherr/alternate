# Issue-ready backlog — 35 tickets

Each section is suitable as an independent GitHub Issue body. IDs remain stable as issue numbers change. Tickets remain **planned/unclaimed** until dependencies are satisfied, an agent claims an exact-head branch and acceptance/verification is recorded. Priority: critical / high / optional.

## Discovery & governance

### [P0-01] Capture exact Android 3.2 baseline and upgrade/data fixtures

**Priority:** critical · **Dependencies:** none · **Target:** `Document Gradle/JDK/SDK, Android build + unit/migration outcomes, schema v5, legacy MMKV import, app identity and APK signing expectations. Record existing caller-screening/overlay and directory behaviors.` · **Status:** Planned, unclaimed

**Work.** Document Gradle/JDK/SDK, Android build + unit/migration outcomes, schema v5, legacy MMKV import, app identity and APK signing expectations. Record existing caller-screening/overlay and directory behaviors.

**Acceptance criteria**
- [ ] Exact-head baseline report with commands and pass/fail outputs
- [ ] Android upgrade fixtures and schema evidence retained
- [ ] No asserted behavior without evidence

**Verification**
- [ ] assembleDebug; testDebugUnitTest; connectedDebugAndroidTest where device available
- [ ] Compare IDs, package/signing, migrated records

**Constraints / handoff.** Do not modify shipping Android behavior for this ticket.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [P0-02] Approve iOS product charter, parity matrix and non-goals

**Priority:** critical · **Dependencies:** none · **Target:** `Define iOS local address book, no Apple Contacts writes, offline Caller ID, safe disclosure UX, functional parity, exclusions and MVP milestones.` · **Status:** Planned, unclaimed

**Work.** Define iOS local address book, no Apple Contacts writes, offline Caller ID, safe disclosure UX, functional parity, exclusions and MVP milestones.

**Acceptance criteria**
- [ ] Matrix covers every Android app screen/phone feature and planned iOS equivalent or explicit unsupported reason
- [ ] Definitions of caller labels versus complete contact records and privacy boundaries
- [ ] Owner-approved acceptance and scope control

**Verification**
- [ ] Review against upstream README and iOS public API capabilities
- [ ] Confirm no unsupported claims about native Phone Recents

**Constraints / handoff.** No CRM/cloud/live caller lookup, no Android-style overlay on iOS.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [P0-03] Document privacy threat model and security invariants

**Priority:** critical · **Dependencies:** `P0-02` · **Target:** `Model personal data in Room, shared iOS App Group index, OS caller directory, import/export, app lock, backups and logging. Define deletion/revocation and after-reboot behavior.` · **Status:** Planned, unclaimed

**Work.** Model personal data in Room, shared iOS App Group index, OS caller directory, import/export, app lock, backups and logging. Define deletion/revocation and after-reboot behavior.

**Acceptance criteria**
- [ ] Dataflow and trust boundaries published
- [ ] Minimum identifier+alias caller-index exposure and opt-in designed
- [ ] Threat table addresses lock screen, Recents, backups, extension, accidental calls, export, race conditions and stale labels

**Verification**
- [ ] Security design review + real-device test matrix
- [ ] Explicit acceptance of iOS platform limitations

**Constraints / handoff.** Never assume app lock prevents OS displaying previously registered labels.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [P0-04] KMP/Compose/Room feasibility and component inventory

**Priority:** critical · **Dependencies:** `P0-01`, `P0-02` · **Target:** `Audit Android-only imports, Compose Material 3 Expressive and Navigation APIs, Room drivers/KSP, DataStore, Coil, photo/biometrics, Gradle compatibility. Propose reusable versus platform-specific UI boundaries.` · **Status:** Planned, unclaimed

**Work.** Audit Android-only imports, Compose Material 3 Expressive and Navigation APIs, Room drivers/KSP, DataStore, Coil, photo/biometrics, Gradle compatibility. Propose reusable versus platform-specific UI boundaries.

**Acceptance criteria**
- [ ] File/component compatibility matrix with iOS blockers
- [ ] Supported toolchain versions pinned for spike
- [ ] Build decision documented, including rollback if native UI simpler

**Verification**
- [ ] Verify Kotlin/Compose/Room/KSP + Xcode compatibility via minimal spike after planning gate
- [ ] No production refactor yet

**Constraints / handoff.** Migrate from current native Kotlin main, not legacy-expo.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [P0-05] Define upstream proposal, issue boundaries and coordination/merge contract

**Priority:** critical · **Dependencies:** `P0-02`, `P0-03`, `P0-04` · **Target:** `Prepare proposed upstream coordination; protect fork main and Android releases; define small PR carriers, exact-head evidence, dependencies, ownership, and no accidental squash/cross-agent overwrite.` · **Status:** Planned, unclaimed

**Work.** Prepare proposed upstream coordination; protect fork main and Android releases; define small PR carriers, exact-head evidence, dependencies, ownership, and no accidental squash/cross-agent overwrite.

**Acceptance criteria**
- [ ] Draft upstream proposal approved before posting externally
- [ ] Planning gate includes signoff on issue map and MVP
- [ ] Each issue has bounded change list, tests, dependencies and PR handoff fields

**Verification**
- [ ] Check upstream open PRs and #39/#40 before each claim
- [ ] Document no-upstream-contact without explicit approval

**Constraints / handoff.** No code changes or GitHub upstream mutations in the planning phase.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [P0-06] Define milestone/project board, prioritization and ready/done gates

**Priority:** high · **Dependencies:** `P0-05` · **Target:** `Create tracker columns, phases, risk/priority/owner fields, blocked rules, issue ID links, complete workstream inventory and milestone exit criteria.` · **Status:** Planned, unclaimed

**Work.** Create tracker columns, phases, risk/priority/owner fields, blocked rules, issue ID links, complete workstream inventory and milestone exit criteria.

**Acceptance criteria**
- [ ] All scoped tickets indexed exactly once
- [ ] Dependency graph acyclic and phased
- [ ] Ready/Doing/In review/Blocked/Landed validated against exact SHA, not only green CI

**Verification**
- [ ] Roadmap audit with all tickets and tracked source of truth
- [ ] Periodic upstream drift review

**Constraints / handoff.** GitHub Projects requires separate API/tool access; Markdown board serves as source until linked.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

## Kotlin shared core

### [KMP-01] Add additive KMP skeleton and iOS compilation target

**Priority:** critical · **Dependencies:** `P0-01`, `P0-04`, `P0-05` · **Target:** `Introduce shared module and source sets without removing existing Android application or changing package ID, signing or releases.` · **Status:** Planned, unclaimed

**Work.** Introduce shared module and source sets without removing existing Android application or changing package ID, signing or releases.

**Acceptance criteria**
- [ ] Android existing task graph operational
- [ ] Shared pure Kotlin file compiles for Android/iOS simulator
- [ ] Baseline Android behavior unchanged

**Verification**
- [ ] assembleDebug + unit tests + compileKotlinIosSimulatorArm64 (or documented equivalent)
- [ ] Diff Gradle lock/dependency graph

**Constraints / handoff.** One isolated, revertible structural PR.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [KMP-02] Extract portable contact, phone, group and caller DTOs

**Priority:** critical · **Dependencies:** `KMP-01` · **Target:** `Move pure model/domain contracts, preserving IDs, multi-phone labels, group membership and conflict semantics.` · **Status:** Planned, unclaimed

**Work.** Move pure model/domain contracts, preserving IDs, multi-phone labels, group membership and conflict semantics.

**Acceptance criteria**
- [ ] No Android framework imports in commonMain
- [ ] Existing Room schema and serialization maintained
- [ ] iOS module consumes identical types

**Verification**
- [ ] Cross-platform model round-trip tests
- [ ] Android DB schema diff

**Constraints / handoff.** No schema redesign hidden in refactor.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [KMP-03] Share search, filtering, phone normalization and ordering

**Priority:** critical · **Dependencies:** `KMP-02` · **Target:** `Extract search index, alias/name lookup, country defaults, duplicate number policy and iOS E.164-to-numeric mapping.` · **Status:** Planned, unclaimed

**Work.** Extract search index, alias/name lookup, country defaults, duplicate number policy and iOS E.164-to-numeric mapping.

**Acceptance criteria**
- [ ] Identical Android search/filter outputs on fixtures
- [ ] Unicode, extension, short-code, national/international ambiguities and collisions covered
- [ ] Deterministic iOS sorted-number contract

**Verification**
- [ ] Golden fixture tests on Android and iOS
- [ ] Fuzz malformed phone inputs

**Constraints / handoff.** Avoid silent truncation or wrong caller labels.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [KMP-04] Share vCard parser/exporter and adversarial fixtures

**Priority:** high · **Dependencies:** `KMP-02` · **Target:** `Move pure VCF transformation logic; leave platform file pickers and share sheets as adapters.` · **Status:** Planned, unclaimed

**Work.** Move pure VCF transformation logic; leave platform file pickers and share sheets as adapters.

**Acceptance criteria**
- [ ] Multiple phone numbers, Unicode, notes, photo references and supported groups preserved
- [ ] Bad or huge VCF treated as untrusted
- [ ] No silent merge or network activity

**Verification**
- [ ] Golden VCF 3/4 import-export round trips
- [ ] Malformed and hostile input tests

**Constraints / handoff.** Do not overlap upstream #40 request for broader formats/backups.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [KMP-05] Migrate Room entities, DAOs and database builder safely

**Priority:** critical · **Dependencies:** `KMP-01`, `KMP-02`, `P0-01` · **Target:** `Make Room models/DAO shared with platform builders and iOS driver; retain existing Android DB location, schema and legacy migrations.` · **Status:** Planned, unclaimed

**Work.** Make Room models/DAO shared with platform builders and iOS driver; retain existing Android DB location, schema and legacy migrations.

**Acceptance criteria**
- [ ] Existing Android DB opens after update without destructive reset
- [ ] iOS SQLite CRUD, transaction rollback, cascade and indices work
- [ ] Schema v5 and upgrade data retained

**Verification**
- [ ] Android migration test and exported schema diff
- [ ] iOS simulator persistence/reopen/cascade tests

**Constraints / handoff.** Call out Android-specific SupportSQLite migration and platform rewrite where needed.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [KMP-06] Share repository and Flow-based contact use cases

**Priority:** critical · **Dependencies:** `KMP-03`, `KMP-05` · **Target:** `Share reactive CRUD, grouped membership, favorites, search and indexed lookup; preserve threading, ordering and error cases.` · **Status:** Planned, unclaimed

**Work.** Share reactive CRUD, grouped membership, favorites, search and indexed lookup; preserve threading, ordering and error cases.

**Acceptance criteria**
- [ ] Both platforms use one domain contract
- [ ] Duplicate number and transactional update behavior deterministic
- [ ] No duplicate repositories for same data path

**Verification**
- [ ] Shared repository contract and concurrency tests
- [ ] Android UI behavior parity acceptance

**Constraints / handoff.** Protect main against simultaneous duplicate domain changes.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [KMP-07] Define secure platform preferences, key, biometric and clock adapters

**Priority:** high · **Dependencies:** `KMP-01`, `P0-03` · **Target:** `Keep Android DataStore/lock migration and provide iOS Keychain/LocalAuthentication semantics; clean platform-independent state transitions.` · **Status:** Planned, unclaimed

**Work.** Keep Android DataStore/lock migration and provide iOS Keychain/LocalAuthentication semantics; clean platform-independent state transitions.

**Acceptance criteria**
- [ ] Platform contracts documented and testable
- [ ] PIN/biometric material excluded from caller ID index
- [ ] Android existing PIN/reset/lock behavior unchanged

**Verification**
- [ ] Lock-out timing, force-lock, restart, retry, biometric fallback tests

**Constraints / handoff.** Security review before reusing existing PIN hashing design.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [KMP-08] Separate photo/file system dependencies from shared data and VCF

**Priority:** high · **Dependencies:** `KMP-02`, `KMP-04` · **Target:** `Define portable metadata, photo lifecycle interfaces and file IO adapters, not android Context/Bitmap/Uri in commonMain.` · **Status:** Planned, unclaimed

**Work.** Define portable metadata, photo lifecycle interfaces and file IO adapters, not android Context/Bitmap/Uri in commonMain.

**Acceptance criteria**
- [ ] Photo references durable and deletions clean artifacts
- [ ] No unsafe path traversal or excessive image allocation
- [ ] Export uses explicit destination and temporary-file cleanup

**Verification**
- [ ] Photo roundtrip and adversarial image tests on both platforms

**Constraints / handoff.** No remote avatar storage.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [KMP-09] Audit and extract interoperable Compose UI primitives

**Priority:** high · **Dependencies:** `P0-04`, `KMP-01`, `KMP-06` · **Target:** `Identify Material3 Expressive, platform-local Context, Android Navigation, back handling, fonts and animations. Extract proven compatible controls.` · **Status:** Planned, unclaimed

**Work.** Identify Material3 Expressive, platform-local Context, Android Navigation, back handling, fonts and animations. Extract proven compatible controls.

**Acceptance criteria**
- [ ] One contact card and theme render on iOS without degrading Android
- [ ] Compatibility fallbacks recorded for unsupported components
- [ ] UI architecture agreed before broad migration

**Verification**
- [ ] iOS simulator screenshots/accessibility sizes and Android screenshot comparisons

**Constraints / handoff.** UI parity can be functional rather than pixel-identical.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

## iOS application

### [IOS-01] Create iOS Xcode shell and Kotlin bridge

**Priority:** critical · **Dependencies:** `KMP-01`, `P0-03`, `P0-04` · **Target:** `Add minimal Xcode target, Compose host or native wrapper, bundle IDs, supported iOS floor, code signing and simulator entry point.` · **Status:** Planned, unclaimed

**Work.** Add minimal Xcode target, Compose host or native wrapper, bundle IDs, supported iOS floor, code signing and simulator entry point.

**Acceptance criteria**
- [ ] Build and launch on iOS simulator with shared code
- [ ] Android build remains unchanged
- [ ] Signing/entitlement prerequisites documented

**Verification**
- [ ] xcodebuild with pinned versions
- [ ] Simulator smoke test

**Constraints / handoff.** No silent network SDKs.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [IOS-02] Build contact list, detail, groups, favorites and search

**Priority:** critical · **Dependencies:** `IOS-01`, `KMP-06`, `KMP-09` · **Target:** `Render local data and navigation from shared Flow; support empty/error/loading and search in iPhone screens.` · **Status:** Planned, unclaimed

**Work.** Render local data and navigation from shared Flow; support empty/error/loading and search in iPhone screens.

**Acceptance criteria**
- [ ] Search by name/number/notes with parity
- [ ] Multi-number and groups readable
- [ ] No Apple Contacts permission required for ordinary viewing

**Verification**
- [ ] Simulator UI test with Unicode/long lists and persistence
- [ ] VoiceOver and Dynamic Type baseline

**Constraints / handoff.** iOS system Phone Recents data is not programmatically exposed by public API.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [IOS-03] Implement contact CRUD and deliberate outgoing-call action

**Priority:** critical · **Dependencies:** `IOS-02`, `KMP-06` · **Target:** `Add/edit/delete contacts, groups, favorites, multiple numbers and duplicate resolution; confirm before launching dial action.` · **Status:** Planned, unclaimed

**Work.** Add/edit/delete contacts, groups, favorites, multiple numbers and duplicate resolution; confirm before launching dial action.

**Acceptance criteria**
- [ ] All edits persist and propagate to index refresh adapter
- [ ] No automatic write to Apple Contacts
- [ ] Accidental dial protection when originating within Alternate

**Verification**
- [ ] Real-device CRUD and restart tests
- [ ] Duplicate multi-number regression and confirmation UX tests

**Constraints / handoff.** Cannot prevent tapping an existing native Phone Recents item.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [IOS-04] Native document/photo import/export and disclosure controls

**Priority:** high · **Dependencies:** `IOS-03`, `KMP-04`, `KMP-08` · **Target:** `Implement file/UIDocumentPicker, image picker, explicit contact selection, share sheet, sanitized temp files and import conflict flow.` · **Status:** Planned, unclaimed

**Work.** Implement file/UIDocumentPicker, image picker, explicit contact selection, share sheet, sanitized temp files and import conflict flow.

**Acceptance criteria**
- [ ] vCard import/export with user confirmation
- [ ] No implicit Apple Contacts or iCloud sync
- [ ] Invalid or massive file fails safely and temporary export cleaned

**Verification**
- [ ] Cross-platform VCF fixture suite
- [ ] Photos and Unicode roundtrip tests
- [ ] Sandbox/file security tests

**Constraints / handoff.** No automatic sync in MVP.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [IOS-05] Face ID/Keychain lock and privacy snapshot behavior

**Priority:** critical · **Dependencies:** `IOS-01`, `KMP-07`, `P0-03` · **Target:** `Use iOS native auth/Keychain and lifecycle lock, hide data in task switcher, protect clipboard or export warnings.` · **Status:** Planned, unclaimed

**Work.** Use iOS native auth/Keychain and lifecycle lock, hide data in task switcher, protect clipboard or export warnings.

**Acceptance criteria**
- [ ] Locked UI content not visible via app switcher
- [ ] Graceful biometric failures and fallback
- [ ] After reboot/reinstall behavior documented

**Verification**
- [ ] Physical device test for lock, wake, task switcher, Face ID retries and force-lock

**Constraints / handoff.** App lock does not revoke previously registered Call Directory labels.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [IOS-06] Setup, permission guide and user privacy settings

**Priority:** high · **Dependencies:** `IOS-02`, `P0-02`, `P0-03` · **Target:** `Explain native caller-ID enablement, local-only boundary, lock, index opt-in/out and disclosure limitations.` · **Status:** Planned, unclaimed

**Work.** Explain native caller-ID enablement, local-only boundary, lock, index opt-in/out and disclosure limitations.

**Acceptance criteria**
- [ ] Accessible and accurate setup screens
- [ ] User can opt out and clear exported index; no hidden enablement
- [ ] Caller ID status guides recovery when extension disabled

**Verification**
- [ ] Settings flow integration tests and device walkthrough

**Constraints / handoff.** No claim that Call Directory names stay invisible to Apple iOS UI.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

## iOS caller ID

### [CID-01] Design minimal number-to-label index and atomic App Group contract

**Priority:** critical · **Dependencies:** `KMP-03`, `KMP-06`, `P0-03`, `IOS-01` · **Target:** `Design consented projection of selected normalized phone number and caller alias into app-group snapshot with deterministic sorting/deduplication, data protection, versioning and no sensitive fields.` · **Status:** Planned, unclaimed

**Work.** Design consented projection of selected normalized phone number and caller alias into app-group snapshot with deterministic sorting/deduplication, data protection, versioning and no sensitive fields.

**Acceptance criteria**
- [ ] Only minimal number + label present; no notes/address/email/photo
- [ ] Atomic revision and deletion semantics
- [ ] Handles duplicate aliases, international numbers and locked-state availability

**Verification**
- [ ] Property tests for sort, Int64 normalization, duplicate collision, snapshots and crash/recovery
- [ ] Audit app-group file permissions

**Constraints / handoff.** Do not put full database, auth keys or PIN into extension's shared container.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [CID-02] Implement native Swift CXCallDirectoryProvider extension

**Priority:** critical · **Dependencies:** `CID-01`, `IOS-01` · **Target:** `Embed native Call Directory extension to read safe immutable projection, register sorted identification entries, respect cancellation and avoid runtime app/database access.` · **Status:** Planned, unclaimed

**Work.** Embed native Call Directory extension to read safe immutable projection, register sorted identification entries, respect cancellation and avoid runtime app/database access.

**Acceptance criteria**
- [ ] iOS settings can enable extension
- [ ] Identifies one test number with native call UI
- [ ] Works while main application not running/locked

**Verification**
- [ ] iPhone signed extension build and real inbound call test
- [ ] Error and reload diagnostics sans PII

**Constraints / handoff.** This is offline Call Directory, not Live Caller ID server lookup.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [CID-03] Implement index update/reload/removal, consent and stale-label recovery

**Priority:** critical · **Dependencies:** `CID-01`, `CID-02`, `IOS-03` · **Target:** `Connect save/delete/relabel/enable/disable to snapshot generation, CXCallDirectoryManager reload, errors, retry and explicit index clear.` · **Status:** Planned, unclaimed

**Work.** Connect save/delete/relabel/enable/disable to snapshot generation, CXCallDirectoryManager reload, errors, retry and explicit index clear.

**Acceptance criteria**
- [ ] Label updates or deletion reliably remove obsolete registrations
- [ ] Opt out clears local index and requests OS reload
- [ ] Idempotent snapshot/replay and race handling

**Verification**
- [ ] Physical-device add/change/delete/disable tests and restart/upgrade cycle
- [ ] Failure injection on reload

**Constraints / handoff.** Do not promise iOS itself immediately flushes Recents or all cached historical caller labels.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [CID-04] Real-device acceptance matrix: locks, number formats, reboots and permissions

**Priority:** critical · **Dependencies:** `CID-02`, `CID-03`, `IOS-05` · **Target:** `Execute signed iPhone tests for app terminated/locked, extension disabled/re-enabled, reboot, unknown caller, malformed/duplicate numbers, privacy exposures.` · **Status:** Planned, unclaimed

**Work.** Execute signed iPhone tests for app terminated/locked, extension disabled/re-enabled, reboot, unknown caller, malformed/duplicate numbers, privacy exposures.

**Acceptance criteria**
- [ ] Verified incoming test caller identification
- [ ] Explicit negative case for unknown number
- [ ] Data leakage and stale-label behavior recorded honestly

**Verification**
- [ ] Attach device/iOS version, extension status, screenshots excluding PII, logs redacted
- [ ] Verify Apple Contacts untouched

**Constraints / handoff.** Simulator isn't sufficient to prove incoming-call integration.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [CID-05] Optional label formatting, disclosure preferences and multiple numbers

**Priority:** medium · **Dependencies:** `CID-04`, `IOS-06` · **Target:** `Explore per-number alias, masked/neutral names, group exclusion, preview of OS-exposed labels and import defaults.` · **Status:** Planned, unclaimed

**Work.** Explore per-number alias, masked/neutral names, group exclusion, preview of OS-exposed labels and import defaults.

**Acceptance criteria**
- [ ] No sensitive notes/addrs copied into labels
- [ ] Users can preview identifiers being registered
- [ ] Existing tests for normalization and sync remain green

**Verification**
- [ ] Privacy UX tests and alias edge cases

**Constraints / handoff.** Optional after basic iOS caller ID works.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

## Quality/release

### [QA-01] CI matrix for Android, KMP iOS simulator, unit, schema and lint

**Priority:** critical · **Dependencies:** `KMP-01`, `IOS-01` · **Target:** `Create distinct CI jobs with pinned Android SDK/JDK, macOS/Xcode for iOS, shared tests and migration checks; protect pull requests from false green due to skipped jobs.` · **Status:** Planned, unclaimed

**Work.** Create distinct CI jobs with pinned Android SDK/JDK, macOS/Xcode for iOS, shared tests and migration checks; protect pull requests from false green due to skipped jobs.

**Acceptance criteria**
- [ ] Required Android baseline kept; iOS compile/test jobs visible
- [ ] No successful workflow can cancel required failure diagnostics
- [ ] Exact-head status and cached toolchain defined

**Verification**
- [ ] Deliberate negative test on each mandatory job
- [ ] Mac runner expense/capacity and security review

**Constraints / handoff.** Do not require self-hosted runner or add needless workflows without approval.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [QA-02] Regression/negative acceptance fixtures for migration and caller ID

**Priority:** critical · **Dependencies:** `KMP-05`, `KMP-06`, `CID-03` · **Target:** `Build fixtures for no data loss, schema upgrade, 2.x migration, deletion/collision race and privacy boundary, and document how tests fail when broken.` · **Status:** Planned, unclaimed

**Work.** Build fixtures for no data loss, schema upgrade, 2.x migration, deletion/collision race and privacy boundary, and document how tests fail when broken.

**Acceptance criteria**
- [ ] Every critical privacy/data-loss invariant has positive and negative test
- [ ] No issue closed until test evidence attached
- [ ] Android parity validated at exact-head

**Verification**
- [ ] Migration fixture backups and cross-platform integration tests
- [ ] Deliberately corrupt inputs to verify fail-closed

**Constraints / handoff.** Keep fixture provenance/expected results stable.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [QA-03] Security hardening: import, storage, locks, logging, index and exports

**Priority:** high · **Dependencies:** `IOS-04`, `IOS-05`, `CID-04`, `P0-03` · **Target:** `Threat-model review plus harden local DB, App Group protection, sensitive logs, key handling, app-switcher snapshots, sanitizing and deletion.` · **Status:** Planned, unclaimed

**Work.** Threat-model review plus harden local DB, App Group protection, sensitive logs, key handling, app-switcher snapshots, sanitizing and deletion.

**Acceptance criteria**
- [ ] No unnecessary network/analytics permissions
- [ ] No raw PII in logs/CI artifacts
- [ ] Locked-state and export behaviors meet charter

**Verification**
- [ ] Manual privacy audit, static tests and iOS entitlement review
- [ ] Real-device penetration-oriented checklist

**Constraints / handoff.** Open-source app means no proprietary audit assumption.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [QA-04] Accessibility, localization and UI parity audit

**Priority:** high · **Dependencies:** `IOS-03`, `IOS-06` · **Target:** `Audit TalkBack/VoiceOver, font scaling, focus, keyboard, high contrast, international numbers and RTL; prevent regression of Android UX.` · **Status:** Planned, unclaimed

**Work.** Audit TalkBack/VoiceOver, font scaling, focus, keyboard, high contrast, international numbers and RTL; prevent regression of Android UX.

**Acceptance criteria**
- [ ] Core flows VoiceOver navigable
- [ ] Large text/readable labels and focus order correct
- [ ] RTL/Unicode contact handling sound

**Verification**
- [ ] Screen-reader walkthrough, snapshot tests and manual iOS/Android audit

**Constraints / handoff.** Material 3 Expressive iOS behavior must be checked, not assumed.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [QA-05] Reproducible iOS signing, TestFlight/package plan and release checklist

**Priority:** high · **Dependencies:** `QA-01`, `QA-02`, `QA-03`, `QA-04` · **Target:** `Document Xcode signing, entitlements, CI provisioning, App Store privacy statements, beta distribution, fork branding and upstream license compliance.` · **Status:** Planned, unclaimed

**Work.** Document Xcode signing, entitlements, CI provisioning, App Store privacy statements, beta distribution, fork branding and upstream license compliance.

**Acceptance criteria**
- [ ] End-to-end clean build and signed device installation documented
- [ ] App privacy claims match actual binary/permissions
- [ ] Release go/no-go checklist includes privacy and fallback

**Verification**
- [ ] Clean checkout build with pinned toolchain, device smoke test
- [ ] Verify extension embedded and enabled

**Constraints / handoff.** No release credentials committed; separate upstream brand/trademark discussion.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [QA-06] Upstream contribution handoff, dependency retirement and roadmap closure

**Priority:** critical · **Dependencies:** `QA-05`, `P0-05` · **Target:** `Review all issue/PR evidence and determine portable upstream PRs versus iOS-specific fork changes; preserve authorship, exact commit lineage and independent release path.` · **Status:** Planned, unclaimed

**Work.** Review all issue/PR evidence and determine portable upstream PRs versus iOS-specific fork changes; preserve authorship, exact commit lineage and independent release path.

**Acceptance criteria**
- [ ] All critical MVP acceptance checked with evidence
- [ ] No open unretired dependent PR or silently squashed behavior
- [ ] Maintainer-facing PRs split by bounded scope and approved before upstream posting

**Verification**
- [ ] Trace each release capability to landed PR + tests
- [ ] Revalidate upstream status and current branch lineage

**Constraints / handoff.** Nothing sent upstream without explicit user approval.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

## Optional later

### [OPT-01] Explore protected local encrypted backup/restore and multi-device sync

**Priority:** optional · **Dependencies:** `QA-03` · **Target:** `Consider privacy-preserving local archives and opt-in sync only after MVP, coordinated with upstream #40.` · **Status:** Planned, unclaimed

**Work.** Consider privacy-preserving local archives and opt-in sync only after MVP, coordinated with upstream #40.

**Acceptance criteria**
- [ ] Separate architecture and threat model approved
- [ ] Cloud/network tradeoffs separately consented
- [ ] Not on MVP critical path

**Verification**
- [ ] Future design review

**Constraints / handoff.** Don't duplicate upstream #40.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [OPT-02] Explore multiple profiles and profile-specific caller labels

**Priority:** optional · **Dependencies:** `CID-04` · **Target:** `Investigate separate directories, work/personal profiles and iOS index projection, coordinated with upstream #39.` · **Status:** Planned, unclaimed

**Work.** Investigate separate directories, work/personal profiles and iOS index projection, coordinated with upstream #39.

**Acceptance criteria**
- [ ] Isolation and profile switching clearly specified
- [ ] No accidental cross-profile caller-label leakage
- [ ] Not on MVP critical path

**Verification**
- [ ] Future design and privacy review

**Constraints / handoff.** Don't duplicate upstream #39.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

### [OPT-03] Explore enhanced relationship metadata or privacy-preserving contact groups

**Priority:** optional · **Dependencies:** `IOS-03` · **Target:** `Future tags/notes/reminders, richer CRM and optional export aliases, without making native caller ID depend on them.` · **Status:** Planned, unclaimed

**Work.** Future tags/notes/reminders, richer CRM and optional export aliases, without making native caller ID depend on them.

**Acceptance criteria**
- [ ] Explicit scope separate from original private-directory product
- [ ] Data portability and privacy model approved
- [ ] No feature creep before MVP

**Verification**
- [ ] Future product review

**Constraints / handoff.** Avoid Dex/Monica complexity until core proven.

**Close only when:** acceptance evidence is attached to issue and required behavior **landed** (not merely passing on an open PR). Record head SHA, base SHA, PR URL, test commands/results, any unretired dependency, and release evidence.

---

