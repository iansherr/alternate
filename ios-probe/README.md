# iOS Call Directory host + extension probe

This project is a **bounded iOS feasibility test** for [P0-08 #38](https://github.com/iansherr/alternate/issues/38) and [CID-02 #24](https://github.com/iansherr/alternate/issues/24). It is **not** an Alternate contact manager and is not linked to the Kotlin Multiplatform `shared-core` proof. The real product will only supply explicitly opted-in aliases and numbers, kept separate from Apple Contacts.

## Purpose
Prove that a native Swift `CXCallDirectoryProvider` extension can compile and embed into a standalone iPhone host app on GitHub Actions using a macOS/Xcode iOS simulator **without signing or secrets**. The single number is an intentionally fictional NANP number, `+1-202-555-0124`, and should never match real test calls. No backend, contacts permission, app group storage, or user data.

## Build (unsigned simulator proof)
With Xcode 26.4.1 and [XcodeGen](https://github.com/yonaskolb/XcodeGen):
```sh
cd ios-probe
xcodegen generate
xcodebuild -project CallerIdProbe.xcodeproj -scheme ProbeApp \
  -sdk iphonesimulator -configuration Debug \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath .build CODE_SIGNING_ALLOWED=NO build
```
Success requires `ProbeApp.app/PlugIns/CallerIdExtension.appex` in build products with the Call Directory extension point. The probe host allows checking enabled status and requesting a reload once properly installed.

## Real-device acceptance (NOT done by CI)
- [ ] Acquire macOS/Xcode signing capability and select unique host/extension bundle IDs; never commit credentials.
- [ ] Enroll/provision app and extension for a physical iPhone; install through Xcode/TestFlight.
- [ ] Select a controlled **real** calling number for the test; use no real personal details in logs/CI.
- [ ] Enable the extension through the applicable iOS Phone caller-identification settings; check status in host app.
- [ ] Place an inbound call and verify native iOS display label with no corresponding Apple Contacts entry.
- [ ] Verify while app locked/terminated; disable/reload behavior; document whether historic labels persist.
- [ ] Add App Group snapshot + consented aliases in a **separate** implementation PR only after design approval.

The probe does not attempt Android overlays, Apple's Phone Recents access, Live Caller ID Lookup, or runtime reading of a private database. An unsigned simulator build is **not** proof of a caller appearing on a real incoming call.

See [iOS spike acceptance spec](https://github.com/iansherr/alternate/blob/planning/kmp-ios-roadmap/docs/ios-port/IOS_CALL_DIRECTORY_SPIKE.md).
