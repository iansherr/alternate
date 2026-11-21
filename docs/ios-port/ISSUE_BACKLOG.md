# Alternate iOS port — 42 linked GitHub issues

Each numbered ticket has a stable ID, upstream-safe scope, acceptance criteria, verification and dependencies. **All implementation remains gated.**

## Discovery & governance

### [P0-01](https://github.com/iansherr/alternate/issues/2) — Capture exact Android 3.2 baseline and upgrade/data fixtures

**Priority:** critical · **Status:** Backlog · **Depends on:** None

**Scope:** Document Gradle/JDK/SDK, Android build + unit/migration outcomes, schema v5, legacy MMKV import, app identity and APK signing expectations. Record existing caller-screening/overlay and directory behaviors.

**Acceptance criteria**
- [ ] Exact-head baseline report with commands and pass/fail outputs
- [ ] Android upgrade fixtures and schema evidence retained
- [ ] No asserted behavior without evidence

**Tests / verification**
- [ ] assembleDebug; testDebugUnitTest; connectedDebugAndroidTest where device available
- [ ] Compare IDs, package/signing, migrated records

**Boundaries:** Do not modify shipping Android behavior for this ticket.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [P0-02](https://github.com/iansherr/alternate/issues/3) — Approve iOS product charter, parity matrix and non-goals

**Priority:** critical · **Status:** Backlog · **Depends on:** None

**Scope:** Define iOS local address book, no Apple Contacts writes, offline Caller ID, safe disclosure UX, functional parity, exclusions and MVP milestones.

**Acceptance criteria**
- [ ] Matrix covers every Android app screen/phone feature and planned iOS equivalent or explicit unsupported reason
- [ ] Definitions of caller labels versus complete contact records and privacy boundaries
- [ ] Owner-approved acceptance and scope control

**Tests / verification**
- [ ] Review against upstream README and iOS public API capabilities
- [ ] Confirm no unsupported claims about native Phone Recents

**Boundaries:** No CRM/cloud/live caller lookup, no Android-style overlay on iOS.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [P0-03](https://github.com/iansherr/alternate/issues/4) — Document privacy threat model and security invariants

**Priority:** critical · **Status:** Backlog · **Depends on:** [P0-02](https://github.com/iansherr/alternate/issues/3)

**Scope:** Model personal data in Room, shared iOS App Group index, OS caller directory, import/export, app lock, backups and logging. Define deletion/revocation and after-reboot behavior.

**Acceptance criteria**
- [ ] Dataflow and trust boundaries published
- [ ] Minimum identifier+alias caller-index exposure and opt-in designed
- [ ] Threat table addresses lock screen, Recents, backups, extension, accidental calls, export, race conditions and stale labels

**Tests / verification**
- [ ] Security design review + real-device test matrix
- [ ] Explicit acceptance of iOS platform limitations

**Boundaries:** Never assume app lock prevents OS displaying previously registered labels.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [P0-04](https://github.com/iansherr/alternate/issues/5) — KMP/Compose/Room feasibility and component inventory

**Priority:** critical · **Status:** Backlog · **Depends on:** [P0-01](https://github.com/iansherr/alternate/issues/2), [P0-02](https://github.com/iansherr/alternate/issues/3)

**Scope:** Audit Android-only imports, Compose Material 3 Expressive and Navigation APIs, Room drivers/KSP, DataStore, Coil, photo/biometrics, Gradle compatibility. Propose reusable versus platform-specific UI boundaries.

**Acceptance criteria**
- [ ] File/component compatibility matrix with iOS blockers
- [ ] Supported toolchain versions pinned for spike
- [ ] Build decision documented, including rollback if native UI simpler

**Tests / verification**
- [ ] Verify Kotlin/Compose/Room/KSP + Xcode compatibility via minimal spike after planning gate
- [ ] No production refactor yet

**Boundaries:** Migrate from current native Kotlin main, not legacy-expo.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [P0-05](https://github.com/iansherr/alternate/issues/6) — Define upstream proposal, issue boundaries and coordination/merge contract

**Priority:** critical · **Status:** Backlog · **Depends on:** [P0-02](https://github.com/iansherr/alternate/issues/3), [P0-03](https://github.com/iansherr/alternate/issues/4), [P0-04](https://github.com/iansherr/alternate/issues/5)

**Scope:** Prepare proposed upstream coordination; protect fork main and Android releases; define small PR carriers, exact-head evidence, dependencies, ownership, and no accidental squash/cross-agent overwrite.

**Acceptance criteria**
- [ ] Draft upstream proposal approved before posting externally
- [ ] Planning gate includes signoff on issue map and MVP
- [ ] Each issue has bounded change list, tests, dependencies and PR handoff fields

**Tests / verification**
- [ ] Check upstream open PRs and #39/#40 before each claim
- [ ] Document no-upstream-contact without explicit approval

**Boundaries:** No code changes or GitHub upstream mutations in the planning phase.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [P0-06](https://github.com/iansherr/alternate/issues/7) — Define milestone/project board, prioritization and ready/done gates

**Priority:** high · **Status:** Backlog · **Depends on:** [P0-05](https://github.com/iansherr/alternate/issues/6), [P0-07](https://github.com/iansherr/alternate/issues/37), [P0-08](https://github.com/iansherr/alternate/issues/38), [SEC-01](https://github.com/iansherr/alternate/issues/39)

**Scope:** Create tracker columns, phases, risk/priority/owner fields, blocked rules, issue ID links, complete workstream inventory and milestone exit criteria.

**Acceptance criteria**
- [ ] All scoped tickets indexed exactly once
- [ ] Dependency graph acyclic and phased
- [ ] Ready/Doing/In review/Blocked/Landed validated against exact SHA, not only green CI

**Tests / verification**
- [ ] Roadmap audit with all tickets and tracked source of truth
- [ ] Periodic upstream drift review

**Boundaries:** GitHub Projects requires separate API/tool access; Markdown board serves as source until linked.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [P0-07](https://github.com/iansherr/alternate/issues/37) — Architecture decision gate: KMP logic vs shared UI vs native iOS

**Priority:** critical · **Status:** Backlog · **Depends on:** [P0-04](https://github.com/iansherr/alternate/issues/5), [P0-05](https://github.com/iansherr/alternate/issues/6)

**Scope:** Establish a decision record comparing (A) KMP data/domain + native SwiftUI, (B) KMP + Compose Multiplatform shared UI, and (C) separate iOS app with stable data exchange. Assess actual Alternate 3.2.0 AndroidX Navigation, Material 3 Expressive, shape/animation dependencies, Room/KSP, Gradle/Kotlin/Xcode, upstream maintenance burden, developer resources, and rollback. KMP is a hypothesis, not a mandated architectural outcome.

**Acceptance criteria**
- [ ] Evidence-based scorecard: reuse, iOS UX, Android risk, maintenance cost and upstream acceptability
- [ ] Explicit go/no-go with limited scope and stop criteria; Android baseline stays intact
- [ ] Allow extraction of portable core independently of decision to share screens

**Tests / verification**
- [ ] Pin toolchain and compile tiny representative contact card/model + database read on iOS simulator AFTER implementation authorization
- [ ] Show native SwiftUI fallback if Compose Material Expressive incompatible

**Boundaries:** Architecture decision must be recorded before broad KMP-09 UI migration; don't treat experimental compile as iPhone caller-ID proof.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [P0-08](https://github.com/iansherr/alternate/issues/38) — iPhone device, Apple signing and Call Directory capability preflight

**Priority:** critical · **Status:** Backlog · **Depends on:** [P0-02](https://github.com/iansherr/alternate/issues/3), [P0-03](https://github.com/iansherr/alternate/issues/4)

**Scope:** Inventory available macOS/Xcode, Apple Developer Program/team, signing and entitlements, suitable physical iPhone, test caller number and dual-SIM/carrier conditions; verify Call Directory extension route, settings access and feasible signed test on device as a bounded preflight. Separate planning from authorized prototype implementation.

**Acceptance criteria**
- [ ] Owner records device/provisioning prerequisites, costs and responsibilities (without posting secrets)
- [ ] Native Call Directory eligibility and on-device test plan documented
- [ ] Preflight go/no-go condition before deep shared-UI investment; evidence distinguishes simulator from actual calls

**Tests / verification**
- [ ] List exact Xcode/iOS build versions and provisioning steps
- [ ] After authorization, test simple independent extension on real device with one synthetic contact

**Boundaries:** No app code before planning gate; no assumption simulator can validate cellular caller ID.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [SEC-01](https://github.com/iansherr/alternate/issues/39) — Define demonstrable encryption-at-rest, backups and private-index storage model

**Priority:** critical · **Status:** Backlog · **Depends on:** [P0-03](https://github.com/iansherr/alternate/issues/4), [P0-08](https://github.com/iansherr/alternate/issues/38)

**Scope:** Audit actual Android 3.x Room database and legacy MMKV behavior separately from iOS. Do not claim the app uses SQLCipher unless code proves it. Decide iOS full database encryption or iOS file-protection level, Keychain secret lifecycle, iCloud/iTunes backup exclusions where appropriate, SQLITE WAL/SHM/temporary files, App Group snapshot after-first-unlock availability, device theft and reinstall/data wipe semantics.

**Acceptance criteria**
- [ ] Current Android privacy facts documented without overstatement
- [ ] iOS protected/unprotected index availability and lock-state tradeoff explicitly approved
- [ ] Backup, restore, reinstall and delete handling fully specified for vault, extension index and OS labels
- [ ] Sensitive notes/addresses/photos never present in caller-ID snapshot

**Tests / verification**
- [ ] Threat-model review for locked phone, after reboot, restore and key rotation
- [ ] On-device backup/file-protection inspection with test records, no real PII

**Boundaries:** Address the fundamental distinction between isolation from Apple Contacts and actual encryption at rest.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

## Kotlin shared core

### [DATA-01](https://github.com/iansherr/alternate/issues/42) — Deterministic import/merge, reversible migration and portable contact ownership

**Priority:** high · **Status:** Backlog · **Depends on:** [KMP-02](https://github.com/iansherr/alternate/issues/9), [KMP-04](https://github.com/iansherr/alternate/issues/11), [KMP-05](https://github.com/iansherr/alternate/issues/12)

**Scope:** Write shared canonical contact-number/address schema and conflict contract for imported vCards and Android data without silently changing Android's established unique-number semantics. Preserve exact raw numbers, country/extension, full names, multiple phones and labels; define duplicate resolution skip/merge/keep-both at contact and phone levels, dry-run preview and undo/export-before-migration. Do not promise automatic cross-device sync.

**Acceptance criteria**
- [ ] No contact or number silently lost/overwritten during import or upgrade
- [ ] Unchanged duplicates skipped deterministically; differences are user-resolved without unintended merges
- [ ] Idempotent retry and rollback/backups for migrations; explicit duplicate number ownership on each platform
- [ ] International formatting and special characters round-trip between Android and iOS

**Tests / verification**
- [ ] Golden before/after fixtures with 2.x/3.x data and conflicted vCards
- [ ] Negative tests for partial failure, truncated file, corrupted DB and interrupted migration

**Boundaries:** Separate from upstream #40 broad import formats and backup requests; constrain to essential data integrity.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [KMP-01](https://github.com/iansherr/alternate/issues/8) — Add additive KMP skeleton and iOS compilation target

**Priority:** critical · **Status:** Backlog · **Depends on:** [P0-01](https://github.com/iansherr/alternate/issues/2), [P0-04](https://github.com/iansherr/alternate/issues/5), [P0-05](https://github.com/iansherr/alternate/issues/6), [P0-06](https://github.com/iansherr/alternate/issues/7), [P0-07](https://github.com/iansherr/alternate/issues/37), [P0-08](https://github.com/iansherr/alternate/issues/38)

**Scope:** Introduce shared module and source sets without removing existing Android application or changing package ID, signing or releases.

**Acceptance criteria**
- [ ] Android existing task graph operational
- [ ] Shared pure Kotlin file compiles for Android/iOS simulator
- [ ] Baseline Android behavior unchanged

**Tests / verification**
- [ ] assembleDebug + unit tests + compileKotlinIosSimulatorArm64 (or documented equivalent)
- [ ] Diff Gradle lock/dependency graph

**Boundaries:** One isolated, revertible structural PR.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [KMP-02](https://github.com/iansherr/alternate/issues/9) — Extract portable contact, phone, group and caller DTOs

**Priority:** critical · **Status:** Backlog · **Depends on:** [KMP-01](https://github.com/iansherr/alternate/issues/8)

**Scope:** Move pure model/domain contracts, preserving IDs, multi-phone labels, group membership and conflict semantics.

**Acceptance criteria**
- [ ] No Android framework imports in commonMain
- [ ] Existing Room schema and serialization maintained
- [ ] iOS module consumes identical types

**Tests / verification**
- [ ] Cross-platform model round-trip tests
- [ ] Android DB schema diff

**Boundaries:** No schema redesign hidden in refactor.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [KMP-03](https://github.com/iansherr/alternate/issues/10) — Share search, filtering, phone normalization and ordering

**Priority:** critical · **Status:** Backlog · **Depends on:** [KMP-02](https://github.com/iansherr/alternate/issues/9)

**Scope:** Extract search index, alias/name lookup, country defaults, duplicate number policy and iOS E.164-to-numeric mapping.

**Acceptance criteria**
- [ ] Identical Android search/filter outputs on fixtures
- [ ] Unicode, extension, short-code, national/international ambiguities and collisions covered
- [ ] Deterministic iOS sorted-number contract

**Tests / verification**
- [ ] Golden fixture tests on Android and iOS
- [ ] Fuzz malformed phone inputs

**Boundaries:** Avoid silent truncation or wrong caller labels.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [KMP-04](https://github.com/iansherr/alternate/issues/11) — Share vCard parser/exporter and adversarial fixtures

**Priority:** high · **Status:** Backlog · **Depends on:** [KMP-02](https://github.com/iansherr/alternate/issues/9)

**Scope:** Move pure VCF transformation logic; leave platform file pickers and share sheets as adapters.

**Acceptance criteria**
- [ ] Multiple phone numbers, Unicode, notes, photo references and supported groups preserved
- [ ] Bad or huge VCF treated as untrusted
- [ ] No silent merge or network activity

**Tests / verification**
- [ ] Golden VCF 3/4 import-export round trips
- [ ] Malformed and hostile input tests

**Boundaries:** Do not overlap upstream #40 request for broader formats/backups.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [KMP-05](https://github.com/iansherr/alternate/issues/12) — Migrate Room entities, DAOs and database builder safely

**Priority:** critical · **Status:** Backlog · **Depends on:** [KMP-01](https://github.com/iansherr/alternate/issues/8), [KMP-02](https://github.com/iansherr/alternate/issues/9), [P0-01](https://github.com/iansherr/alternate/issues/2), [SEC-01](https://github.com/iansherr/alternate/issues/39)

**Scope:** Make Room models/DAO shared with platform builders and iOS driver; retain existing Android DB location, schema and legacy migrations.

**Acceptance criteria**
- [ ] Existing Android DB opens after update without destructive reset
- [ ] iOS SQLite CRUD, transaction rollback, cascade and indices work
- [ ] Schema v5 and upgrade data retained

**Tests / verification**
- [ ] Android migration test and exported schema diff
- [ ] iOS simulator persistence/reopen/cascade tests

**Boundaries:** Call out Android-specific SupportSQLite migration and platform rewrite where needed.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [KMP-06](https://github.com/iansherr/alternate/issues/13) — Share repository and Flow-based contact use cases

**Priority:** critical · **Status:** Backlog · **Depends on:** [KMP-03](https://github.com/iansherr/alternate/issues/10), [KMP-05](https://github.com/iansherr/alternate/issues/12)

**Scope:** Share reactive CRUD, grouped membership, favorites, search and indexed lookup; preserve threading, ordering and error cases.

**Acceptance criteria**
- [ ] Both platforms use one domain contract
- [ ] Duplicate number and transactional update behavior deterministic
- [ ] No duplicate repositories for same data path

**Tests / verification**
- [ ] Shared repository contract and concurrency tests
- [ ] Android UI behavior parity acceptance

**Boundaries:** Protect main against simultaneous duplicate domain changes.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [KMP-07](https://github.com/iansherr/alternate/issues/14) — Define secure platform preferences, key, biometric and clock adapters

**Priority:** high · **Status:** Backlog · **Depends on:** [KMP-01](https://github.com/iansherr/alternate/issues/8), [P0-03](https://github.com/iansherr/alternate/issues/4), [SEC-01](https://github.com/iansherr/alternate/issues/39)

**Scope:** Keep Android DataStore/lock migration and provide iOS Keychain/LocalAuthentication semantics; clean platform-independent state transitions.

**Acceptance criteria**
- [ ] Platform contracts documented and testable
- [ ] PIN/biometric material excluded from caller ID index
- [ ] Android existing PIN/reset/lock behavior unchanged

**Tests / verification**
- [ ] Lock-out timing, force-lock, restart, retry, biometric fallback tests

**Boundaries:** Security review before reusing existing PIN hashing design.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [KMP-08](https://github.com/iansherr/alternate/issues/15) — Separate photo/file system dependencies from shared data and VCF

**Priority:** high · **Status:** Backlog · **Depends on:** [KMP-02](https://github.com/iansherr/alternate/issues/9), [KMP-04](https://github.com/iansherr/alternate/issues/11)

**Scope:** Define portable metadata, photo lifecycle interfaces and file IO adapters, not android Context/Bitmap/Uri in commonMain.

**Acceptance criteria**
- [ ] Photo references durable and deletions clean artifacts
- [ ] No unsafe path traversal or excessive image allocation
- [ ] Export uses explicit destination and temporary-file cleanup

**Tests / verification**
- [ ] Photo roundtrip and adversarial image tests on both platforms

**Boundaries:** No remote avatar storage.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [KMP-09](https://github.com/iansherr/alternate/issues/16) — Audit and extract interoperable Compose UI primitives

**Priority:** high · **Status:** Backlog · **Depends on:** [P0-04](https://github.com/iansherr/alternate/issues/5), [KMP-01](https://github.com/iansherr/alternate/issues/8), [KMP-06](https://github.com/iansherr/alternate/issues/13)

**Scope:** Identify Material3 Expressive, platform-local Context, Android Navigation, back handling, fonts and animations. Extract proven compatible controls.

**Acceptance criteria**
- [ ] One contact card and theme render on iOS without degrading Android
- [ ] Compatibility fallbacks recorded for unsupported components
- [ ] UI architecture agreed before broad migration

**Tests / verification**
- [ ] iOS simulator screenshots/accessibility sizes and Android screenshot comparisons

**Boundaries:** UI parity can be functional rather than pixel-identical.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

## iOS application

### [IOS-01](https://github.com/iansherr/alternate/issues/17) — Create iOS Xcode shell and Kotlin bridge

**Priority:** critical · **Status:** Backlog · **Depends on:** [KMP-01](https://github.com/iansherr/alternate/issues/8), [P0-03](https://github.com/iansherr/alternate/issues/4), [P0-04](https://github.com/iansherr/alternate/issues/5), [P0-08](https://github.com/iansherr/alternate/issues/38)

**Scope:** Add minimal Xcode target, Compose host or native wrapper, bundle IDs, supported iOS floor, code signing and simulator entry point.

**Acceptance criteria**
- [ ] Build and launch on iOS simulator with shared code
- [ ] Android build remains unchanged
- [ ] Signing/entitlement prerequisites documented

**Tests / verification**
- [ ] xcodebuild with pinned versions
- [ ] Simulator smoke test

**Boundaries:** No silent network SDKs.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [IOS-02](https://github.com/iansherr/alternate/issues/18) — Build contact list, detail, groups, favorites and search

**Priority:** critical · **Status:** Backlog · **Depends on:** [IOS-01](https://github.com/iansherr/alternate/issues/17), [KMP-06](https://github.com/iansherr/alternate/issues/13), [KMP-09](https://github.com/iansherr/alternate/issues/16)

**Scope:** Render local data and navigation from shared Flow; support empty/error/loading and search in iPhone screens.

**Acceptance criteria**
- [ ] Search by name/number/notes with parity
- [ ] Multi-number and groups readable
- [ ] No Apple Contacts permission required for ordinary viewing

**Tests / verification**
- [ ] Simulator UI test with Unicode/long lists and persistence
- [ ] VoiceOver and Dynamic Type baseline

**Boundaries:** iOS system Phone Recents data is not programmatically exposed by public API.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [IOS-03](https://github.com/iansherr/alternate/issues/19) — Implement contact CRUD and deliberate outgoing-call action

**Priority:** critical · **Status:** Backlog · **Depends on:** [IOS-02](https://github.com/iansherr/alternate/issues/18), [KMP-06](https://github.com/iansherr/alternate/issues/13)

**Scope:** Add/edit/delete contacts, groups, favorites, multiple numbers and duplicate resolution; confirm before launching dial action.

**Acceptance criteria**
- [ ] All edits persist and propagate to index refresh adapter
- [ ] No automatic write to Apple Contacts
- [ ] Accidental dial protection when originating within Alternate

**Tests / verification**
- [ ] Real-device CRUD and restart tests
- [ ] Duplicate multi-number regression and confirmation UX tests

**Boundaries:** Cannot prevent tapping an existing native Phone Recents item.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [IOS-04](https://github.com/iansherr/alternate/issues/20) — Native document/photo import/export and disclosure controls

**Priority:** high · **Status:** Backlog · **Depends on:** [IOS-03](https://github.com/iansherr/alternate/issues/19), [KMP-04](https://github.com/iansherr/alternate/issues/11), [KMP-08](https://github.com/iansherr/alternate/issues/15), [DATA-01](https://github.com/iansherr/alternate/issues/42)

**Scope:** Implement file/UIDocumentPicker, image picker, explicit contact selection, share sheet, sanitized temp files and import conflict flow.

**Acceptance criteria**
- [ ] vCard import/export with user confirmation
- [ ] No implicit Apple Contacts or iCloud sync
- [ ] Invalid or massive file fails safely and temporary export cleaned

**Tests / verification**
- [ ] Cross-platform VCF fixture suite
- [ ] Photos and Unicode roundtrip tests
- [ ] Sandbox/file security tests

**Boundaries:** No automatic sync in MVP.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [IOS-05](https://github.com/iansherr/alternate/issues/21) — Face ID/Keychain lock and privacy snapshot behavior

**Priority:** critical · **Status:** Backlog · **Depends on:** [IOS-01](https://github.com/iansherr/alternate/issues/17), [KMP-07](https://github.com/iansherr/alternate/issues/14), [P0-03](https://github.com/iansherr/alternate/issues/4), [SEC-01](https://github.com/iansherr/alternate/issues/39)

**Scope:** Use iOS native auth/Keychain and lifecycle lock, hide data in task switcher, protect clipboard or export warnings.

**Acceptance criteria**
- [ ] Locked UI content not visible via app switcher
- [ ] Graceful biometric failures and fallback
- [ ] After reboot/reinstall behavior documented

**Tests / verification**
- [ ] Physical device test for lock, wake, task switcher, Face ID retries and force-lock

**Boundaries:** App lock does not revoke previously registered Call Directory labels.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [IOS-06](https://github.com/iansherr/alternate/issues/22) — Setup, permission guide and user privacy settings

**Priority:** high · **Status:** Backlog · **Depends on:** [IOS-02](https://github.com/iansherr/alternate/issues/18), [P0-02](https://github.com/iansherr/alternate/issues/3), [P0-03](https://github.com/iansherr/alternate/issues/4)

**Scope:** Explain native caller-ID enablement, local-only boundary, lock, index opt-in/out and disclosure limitations.

**Acceptance criteria**
- [ ] Accessible and accurate setup screens
- [ ] User can opt out and clear exported index; no hidden enablement
- [ ] Caller ID status guides recovery when extension disabled

**Tests / verification**
- [ ] Settings flow integration tests and device walkthrough

**Boundaries:** No claim that Call Directory names stay invisible to Apple iOS UI.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [UX-01](https://github.com/iansherr/alternate/issues/40) — Accidental-call and accidental-sharing protection product contract

**Priority:** critical · **Status:** Backlog · **Depends on:** [P0-02](https://github.com/iansherr/alternate/issues/3), [P0-03](https://github.com/iansherr/alternate/issues/4), [IOS-03](https://github.com/iansherr/alternate/issues/19), [IOS-06](https://github.com/iansherr/alternate/issues/22)

**Scope:** Specify and implement deliberate call confirmation and export/share safeguards without making everyday lookup cumbersome; provide opt-in aliases, redact addresses/notes from quick-share surfaces, confirmation scopes, safe copy behavior and app-switcher previews. Explicitly state native Phone Recents and some system sharing cannot be intercepted. Protect import into Apple Contacts from unintentional broad writes.

**Acceptance criteria**
- [ ] No single accidental tap in Alternate places a call or transmits a complete vCard
- [ ] Users preview exactly which fields and people are shared; addresses/notes excluded by default when appropriate
- [ ] Previews, clipboard, share sheets and shortcuts reviewed for PII disclosure
- [ ] One clearly documented limitation: native Phone app Recents cannot be guarded by Alternate

**Tests / verification**
- [ ] UI mis-tap and accessibility double-tap regression scenarios
- [ ] Real-device export/share/call privacy walkthrough with fake sensitive fields

**Boundaries:** Core product motivation, not optional polishing. Avoid claiming control over Apple's Phone app.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

## iOS caller ID

### [CID-01](https://github.com/iansherr/alternate/issues/23) — Design minimal number-to-label index and atomic App Group contract

**Priority:** critical · **Status:** Backlog · **Depends on:** [KMP-03](https://github.com/iansherr/alternate/issues/10), [KMP-06](https://github.com/iansherr/alternate/issues/13), [P0-03](https://github.com/iansherr/alternate/issues/4), [IOS-01](https://github.com/iansherr/alternate/issues/17), [SEC-01](https://github.com/iansherr/alternate/issues/39)

**Scope:** Design consented projection of selected normalized phone number and caller alias into app-group snapshot with deterministic sorting/deduplication, data protection, versioning and no sensitive fields.

**Acceptance criteria**
- [ ] Only minimal number + label present; no notes/address/email/photo
- [ ] Atomic revision and deletion semantics
- [ ] Handles duplicate aliases, international numbers and locked-state availability

**Tests / verification**
- [ ] Property tests for sort, Int64 normalization, duplicate collision, snapshots and crash/recovery
- [ ] Audit app-group file permissions

**Boundaries:** Do not put full database, auth keys or PIN into extension's shared container.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [CID-02](https://github.com/iansherr/alternate/issues/24) — Implement native Swift CXCallDirectoryProvider extension

**Priority:** critical · **Status:** Backlog · **Depends on:** [CID-01](https://github.com/iansherr/alternate/issues/23), [IOS-01](https://github.com/iansherr/alternate/issues/17), [P0-08](https://github.com/iansherr/alternate/issues/38)

**Scope:** Embed native Call Directory extension to read safe immutable projection, register sorted identification entries, respect cancellation and avoid runtime app/database access.

**Acceptance criteria**
- [ ] iOS settings can enable extension
- [ ] Identifies one test number with native call UI
- [ ] Works while main application not running/locked

**Tests / verification**
- [ ] iPhone signed extension build and real inbound call test
- [ ] Error and reload diagnostics sans PII

**Boundaries:** This is offline Call Directory, not Live Caller ID server lookup.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [CID-03](https://github.com/iansherr/alternate/issues/25) — Implement index update/reload/removal, consent and stale-label recovery

**Priority:** critical · **Status:** Backlog · **Depends on:** [CID-01](https://github.com/iansherr/alternate/issues/23), [CID-02](https://github.com/iansherr/alternate/issues/24), [IOS-03](https://github.com/iansherr/alternate/issues/19)

**Scope:** Connect save/delete/relabel/enable/disable to snapshot generation, CXCallDirectoryManager reload, errors, retry and explicit index clear.

**Acceptance criteria**
- [ ] Label updates or deletion reliably remove obsolete registrations
- [ ] Opt out clears local index and requests OS reload
- [ ] Idempotent snapshot/replay and race handling

**Tests / verification**
- [ ] Physical-device add/change/delete/disable tests and restart/upgrade cycle
- [ ] Failure injection on reload

**Boundaries:** Do not promise iOS itself immediately flushes Recents or all cached historical caller labels.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [CID-04](https://github.com/iansherr/alternate/issues/26) — Real-device acceptance matrix: locks, number formats, reboots and permissions

**Priority:** critical · **Status:** Backlog · **Depends on:** [CID-02](https://github.com/iansherr/alternate/issues/24), [CID-03](https://github.com/iansherr/alternate/issues/25), [IOS-05](https://github.com/iansherr/alternate/issues/21), [CID-06](https://github.com/iansherr/alternate/issues/41)

**Scope:** Execute signed iPhone tests for app terminated/locked, extension disabled/re-enabled, reboot, unknown caller, malformed/duplicate numbers, privacy exposures.

**Acceptance criteria**
- [ ] Verified incoming test caller identification
- [ ] Explicit negative case for unknown number
- [ ] Data leakage and stale-label behavior recorded honestly

**Tests / verification**
- [ ] Attach device/iOS version, extension status, screenshots excluding PII, logs redacted
- [ ] Verify Apple Contacts untouched

**Boundaries:** Simulator isn't sufficient to prove incoming-call integration.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [CID-05](https://github.com/iansherr/alternate/issues/27) — Optional label formatting, disclosure preferences and multiple numbers

**Priority:** medium · **Status:** Backlog · **Depends on:** [CID-04](https://github.com/iansherr/alternate/issues/26), [IOS-06](https://github.com/iansherr/alternate/issues/22)

**Scope:** Explore per-number alias, masked/neutral names, group exclusion, preview of OS-exposed labels and import defaults.

**Acceptance criteria**
- [ ] No sensitive notes/addrs copied into labels
- [ ] Users can preview identifiers being registered
- [ ] Existing tests for normalization and sync remain green

**Tests / verification**
- [ ] Privacy UX tests and alias edge cases

**Boundaries:** Optional after basic iOS caller ID works.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [CID-06](https://github.com/iansherr/alternate/issues/41) — Test caller-label precedence, ambiguity, reload limits and OS caching

**Priority:** high · **Status:** Backlog · **Depends on:** [CID-02](https://github.com/iansherr/alternate/issues/24), [CID-03](https://github.com/iansherr/alternate/issues/25), [P0-08](https://github.com/iansherr/alternate/issues/38)

**Scope:** Define behavior for numbers also in Apple Contacts or identified by Apple/carrier/other caller-ID apps; dual-SIM and withheld-number calls, local/international display normalization, invalid numbers, duplicate aliases, number reuse and large caller indexes. Test extension reload/incremental update, cancellation, no stale labels after deletion and on/off toggles under iOS limits.

**Acceptance criteria**
- [ ] Precedence/collision matrix documented from real-device evidence, not guesses
- [ ] Unsupported and privacy-sensitive caller cases handled as unknown, not misidentified
- [ ] Performance bounds and failure/reload recovery measured and documented
- [ ] No unsupported promise that historical Recents labels instantly vanish

**Tests / verification**
- [ ] Physical iPhone test across duplicate local Contacts, unknown, blocked, and two caller-ID providers when available
- [ ] Stress sorted index and incremental reload, error handling, memory/time limits

**Boundaries:** Official Apple docs support incremental add/remove but not guaranteed global label precedence or history clearing.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

## Quality/release

### [OPS-01](https://github.com/iansherr/alternate/issues/43) — Upstream contribution/release ownership, support policy and sustainable maintenance

**Priority:** high · **Status:** Backlog · **Depends on:** [P0-05](https://github.com/iansherr/alternate/issues/6), [P0-07](https://github.com/iansherr/alternate/issues/37), [QA-05](https://github.com/iansherr/alternate/issues/32)

**Scope:** Decide ownership and release responsibilities for KMP framework, native Swift extension and iOS app if upstream declines iOS. Explicitly cover MIT attribution, artwork/brand/metadata permissions, Apple bundle IDs, signed builds, reproducible toolchains, update provenance, review/maintainer time, security disclosures, fork sync and KMP dependency upgrades. Specify when to stop or minimize effort to avoid permanent fork maintenance.

**Acceptance criteria**
- [ ] Upstream-first portable PR sequence and fallback fork-release strategy agreed
- [ ] Ownership and support/security-response boundaries documented
- [ ] No shared credentials or surprise release obligations; legal/license/artwork audit complete
- [ ] Sustainable minimum maintenance plan and stop conditions written

**Tests / verification**
- [ ] Review MIT license and non-code assets/trademarks with actual repository metadata
- [ ] Cold-start contributor can reproduce build and identify support owner

**Boundaries:** Do not infer upstream willingness or create upstream issue/PR without explicit owner approval.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [QA-01](https://github.com/iansherr/alternate/issues/28) — CI matrix for Android, KMP iOS simulator, unit, schema and lint

**Priority:** critical · **Status:** Backlog · **Depends on:** [KMP-01](https://github.com/iansherr/alternate/issues/8), [IOS-01](https://github.com/iansherr/alternate/issues/17), [P0-08](https://github.com/iansherr/alternate/issues/38)

**Scope:** Create distinct CI jobs with pinned Android SDK/JDK, macOS/Xcode for iOS, shared tests and migration checks; protect pull requests from false green due to skipped jobs.

**Acceptance criteria**
- [ ] Required Android baseline kept; iOS compile/test jobs visible
- [ ] No successful workflow can cancel required failure diagnostics
- [ ] Exact-head status and cached toolchain defined

**Tests / verification**
- [ ] Deliberate negative test on each mandatory job
- [ ] Mac runner expense/capacity and security review

**Boundaries:** Do not require self-hosted runner or add needless workflows without approval.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [QA-02](https://github.com/iansherr/alternate/issues/29) — Regression/negative acceptance fixtures for migration and caller ID

**Priority:** critical · **Status:** Backlog · **Depends on:** [KMP-05](https://github.com/iansherr/alternate/issues/12), [KMP-06](https://github.com/iansherr/alternate/issues/13), [CID-03](https://github.com/iansherr/alternate/issues/25), [DATA-01](https://github.com/iansherr/alternate/issues/42)

**Scope:** Build fixtures for no data loss, schema upgrade, 2.x migration, deletion/collision race and privacy boundary, and document how tests fail when broken.

**Acceptance criteria**
- [ ] Every critical privacy/data-loss invariant has positive and negative test
- [ ] No issue closed until test evidence attached
- [ ] Android parity validated at exact-head

**Tests / verification**
- [ ] Migration fixture backups and cross-platform integration tests
- [ ] Deliberately corrupt inputs to verify fail-closed

**Boundaries:** Keep fixture provenance/expected results stable.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [QA-03](https://github.com/iansherr/alternate/issues/30) — Security hardening: import, storage, locks, logging, index and exports

**Priority:** high · **Status:** Backlog · **Depends on:** [IOS-04](https://github.com/iansherr/alternate/issues/20), [IOS-05](https://github.com/iansherr/alternate/issues/21), [CID-04](https://github.com/iansherr/alternate/issues/26), [P0-03](https://github.com/iansherr/alternate/issues/4), [UX-01](https://github.com/iansherr/alternate/issues/40), [CID-06](https://github.com/iansherr/alternate/issues/41), [SEC-01](https://github.com/iansherr/alternate/issues/39)

**Scope:** Threat-model review plus harden local DB, App Group protection, sensitive logs, key handling, app-switcher snapshots, sanitizing and deletion.

**Acceptance criteria**
- [ ] No unnecessary network/analytics permissions
- [ ] No raw PII in logs/CI artifacts
- [ ] Locked-state and export behaviors meet charter

**Tests / verification**
- [ ] Manual privacy audit, static tests and iOS entitlement review
- [ ] Real-device penetration-oriented checklist

**Boundaries:** Open-source app means no proprietary audit assumption.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [QA-04](https://github.com/iansherr/alternate/issues/31) — Accessibility, localization and UI parity audit

**Priority:** high · **Status:** Backlog · **Depends on:** [IOS-03](https://github.com/iansherr/alternate/issues/19), [IOS-06](https://github.com/iansherr/alternate/issues/22)

**Scope:** Audit TalkBack/VoiceOver, font scaling, focus, keyboard, high contrast, international numbers and RTL; prevent regression of Android UX.

**Acceptance criteria**
- [ ] Core flows VoiceOver navigable
- [ ] Large text/readable labels and focus order correct
- [ ] RTL/Unicode contact handling sound

**Tests / verification**
- [ ] Screen-reader walkthrough, snapshot tests and manual iOS/Android audit

**Boundaries:** Material 3 Expressive iOS behavior must be checked, not assumed.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [QA-05](https://github.com/iansherr/alternate/issues/32) — Reproducible iOS signing, TestFlight/package plan and release checklist

**Priority:** high · **Status:** Backlog · **Depends on:** [QA-01](https://github.com/iansherr/alternate/issues/28), [QA-02](https://github.com/iansherr/alternate/issues/29), [QA-03](https://github.com/iansherr/alternate/issues/30), [QA-04](https://github.com/iansherr/alternate/issues/31)

**Scope:** Document Xcode signing, entitlements, CI provisioning, App Store privacy statements, beta distribution, fork branding and upstream license compliance.

**Acceptance criteria**
- [ ] End-to-end clean build and signed device installation documented
- [ ] App privacy claims match actual binary/permissions
- [ ] Release go/no-go checklist includes privacy and fallback

**Tests / verification**
- [ ] Clean checkout build with pinned toolchain, device smoke test
- [ ] Verify extension embedded and enabled

**Boundaries:** No release credentials committed; separate upstream brand/trademark discussion.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [QA-06](https://github.com/iansherr/alternate/issues/33) — Upstream contribution handoff, dependency retirement and roadmap closure

**Priority:** critical · **Status:** Backlog · **Depends on:** [QA-05](https://github.com/iansherr/alternate/issues/32), [P0-05](https://github.com/iansherr/alternate/issues/6), [OPS-01](https://github.com/iansherr/alternate/issues/43)

**Scope:** Review all issue/PR evidence and determine portable upstream PRs versus iOS-specific fork changes; preserve authorship, exact commit lineage and independent release path.

**Acceptance criteria**
- [ ] All critical MVP acceptance checked with evidence
- [ ] No open unretired dependent PR or silently squashed behavior
- [ ] Maintainer-facing PRs split by bounded scope and approved before upstream posting

**Tests / verification**
- [ ] Trace each release capability to landed PR + tests
- [ ] Revalidate upstream status and current branch lineage

**Boundaries:** Nothing sent upstream without explicit user approval.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

## Optional later

### [OPT-01](https://github.com/iansherr/alternate/issues/34) — Explore protected local encrypted backup/restore and multi-device sync

**Priority:** optional · **Status:** Deferred · **Depends on:** [QA-03](https://github.com/iansherr/alternate/issues/30)

**Scope:** Consider privacy-preserving local archives and opt-in sync only after MVP, coordinated with upstream #40.

**Acceptance criteria**
- [ ] Separate architecture and threat model approved
- [ ] Cloud/network tradeoffs separately consented
- [ ] Not on MVP critical path

**Tests / verification**
- [ ] Future design review

**Boundaries:** Don't duplicate upstream #40.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [OPT-02](https://github.com/iansherr/alternate/issues/35) — Explore multiple profiles and profile-specific caller labels

**Priority:** optional · **Status:** Deferred · **Depends on:** [CID-04](https://github.com/iansherr/alternate/issues/26)

**Scope:** Investigate separate directories, work/personal profiles and iOS index projection, coordinated with upstream #39.

**Acceptance criteria**
- [ ] Isolation and profile switching clearly specified
- [ ] No accidental cross-profile caller-label leakage
- [ ] Not on MVP critical path

**Tests / verification**
- [ ] Future design and privacy review

**Boundaries:** Don't duplicate upstream #39.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

### [OPT-03](https://github.com/iansherr/alternate/issues/36) — Explore enhanced relationship metadata or privacy-preserving contact groups

**Priority:** optional · **Status:** Deferred · **Depends on:** [IOS-03](https://github.com/iansherr/alternate/issues/19)

**Scope:** Future tags/notes/reminders, richer CRM and optional export aliases, without making native caller ID depend on them.

**Acceptance criteria**
- [ ] Explicit scope separate from original private-directory product
- [ ] Data portability and privacy model approved
- [ ] No feature creep before MVP

**Tests / verification**
- [ ] Future product review

**Boundaries:** Avoid Dex/Monica complexity until core proven.

**Done only when:** required behavior has landed with reproducible evidence on the accepted target head (not merely a green open PR).

---

