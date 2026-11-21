# Consent-controlled Call Directory index — stacked iOS probe

**Development-only proof.** This draft work builds on the native Call Directory packaging spike in [PR #47](https://github.com/iansherr/alternate/pull/47). The actual Alternate contact manager and Kotlin/Room database have not been connected. It is not a shipping app.

## Model and consent
- No caller data is published by default. The test host requires an explicit **Publish this number and alias** action.
- Only the international numeric phone identifier and an explicitly chosen visible alias enter the shared container. No full contact card, notes, addresses, email, image, PIN, key, network traffic, or Apple Contacts writes.
- Index schema version is fixed at 1. All numbers are 7–15 international digits (no leading zero) and strictly numerically sorted; duplicate/ambiguous numbers are rejected. Alias is limited to 80 UTF-8 bytes with no leading/trailing whitespace or control characters. This is **not** a full international phone parser; the upstream domain must do that separately.
- Max 10,000 entries and 1.5 MB JSON. Missing index defaults to disabled; malformed, oversized and out-of-order snapshots are rejected rather than silently applied.
- App Group is **group.dev.alternate.calleridprobe**, a placeholder requiring appropriate unique App ID/App Group/entitlement provisioning on a real device. Missing group fails rather than falling back to an unprotected directory.
- On iOS, the index snapshot is written atomically with **Complete Until First User Authentication** file protection. A dedicated directory is excluded from file backups. The user must understand that labels are readable by iOS after the first unlock even while the device is locked. App Group backup behavior requires device verification.
- The extension reads that snapshot and *never* opens the main app's vault. For an incremental Call Directory request it calls **removeAllIdentificationEntries()**, then supplies the entire new sorted snapshot. This is intentional to avoid retaining stale aliases. Otherwise it supplies the complete list.
- Disabling replaces the index with an empty **disabled** snapshot, then requests OS reload. An OS reload failure can leave old labels in native iOS. A successful reload is not a promise that existing Phone Recents history is erased.

## Run reproducible tests
On a Mac with Xcode 26.4.1 and XcodeGen:
1. From ios-probe, run: swift test --parallel
2. Run: xcodegen generate
3. Run: xcodebuild -project CallerIdProbe.xcodeproj -scheme ProbeApp -configuration Debug -sdk iphonesimulator -destination 'generic/platform=iOS Simulator' -derivedDataPath .build CODE_SIGNING_ALLOWED=NO build
4. Confirm ProbeApp.app/PlugIns/CallerIdExtension.appex exists and the extension Info.plist has NSExtensionPointIdentifier com.apple.callkit.call-directory.

GitHub CI runs Swift unit tests followed by an unsigned simulator build. Tests cover opt-in default, invalid numbers, duplicate/unsorted entries, corrupted/oversized files and disabling/removal. These are not actual incoming-call tests.

## Remaining work and limitations
- This proof does not use any real contact data; the default +1-202-555-0124 is a fictional number. A signed **physical iPhone** with a controlled calling line, enabled extension and correct App Group is required to establish real caller identification.
- A signed device test must also verify labels when the app is locked/terminated; first unlock after reboot; update/delete/disable and reload outcomes; competing identifiers and Phone history. Do not accept successful simulator builds as product completion.
- Encrypted whole-vault storage, DB/Room synchronization, importing, alias lifecycle and app-level accidental-call protection are future work.
- The source is in a stacked PR; its base PR must be retired carefully and required behavior must actually land before marking this work complete.

See [CID-01](https://github.com/iansherr/alternate/issues/23), [CID-03](https://github.com/iansherr/alternate/issues/25), [security design](https://github.com/iansherr/alternate/issues/39), and [base native extension](https://github.com/iansherr/alternate/pull/47).
