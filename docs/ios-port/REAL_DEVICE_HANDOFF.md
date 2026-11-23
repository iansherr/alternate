# Real iPhone caller-identification acceptance — next blocking gate

**Status:** Not performed. Draft [PR #50](https://github.com/iansherr/alternate/pull/50) passes macOS Swift unit tests and unsigned simulator host/extension packaging on exact head `52b65b714e579e7585c9d51dad1889590983cfb6` ([run #44936063500](https://github.com/iansherr/alternate/actions/runs/44936063500)). That result proves neither signed installation nor native incoming-call identification.

## Prerequisites
- Mac with Xcode 26.4.1 (or a documented supported equivalent), XcodeGen and a test iPhone (iOS 18+), plus an **independently controlled real phone line** for inbound calls.
- Apple Developer team/signing permission and **App Groups** capability for BOTH the probe host and extension. Do not put signing identities, secrets, provisioning profiles, device IDs or real numbers into GitHub issues/CI logs.
- Use a unique owned host bundle ID and an extension bundle ID **prefixed by the host ID**. Register a corresponding unique App Group ID. Defaults are fictional placeholders, not a provisioned capability.
- Never test with private contact notes, addresses or a third party's personal number; use a synthetic alias and a calling number you control.

## Build and provision separately from public repo work
1. Start from the tested `spike/ios-consented-index` branch, which is *stacked on* `spike/ios-call-directory-probe` ([PR #47](https://github.com/iansherr/alternate/pull/47)); preserve dependency lineage.
2. Run XcodeGen for `ios-probe/project.yml`; inspect generated app/extension targets and deployment versions in Xcode.
3. Configure signing/team and unique bundle IDs for host and extension in the XcodeGen project settings. Update their extension-lookup identifier in `App/CallerIdProbeApp.swift`.
4. Configure the **same registered App Group** for host/extension entitlements and the constant in `SharedIndex/CallerIndexStore.swift`. Protect all credentials locally; do not push any user-specific signing changes upstream.
5. Build and install on the physical iPhone. Confirm the extension appears under **Settings → Apps → Phone → Call Blocking & Identification** on iOS 26, and explicitly enable it. Apple documents extension enablement is required.
6. The host should initially report no caller labels. Verify no Apple Contacts import or addition was requested.
7. In the host UI, change the default *fictional* `12025550124` to the international digits of the **controlled real calling number** (no plus sign) and enter a synthetic label such as `Alternate Test`. Tap **Publish this number and alias**, then check extension enabled/reload status.
8. Place an inbound call from that controlled line. Confirm native Phone shows the chosen alias without a system Contacts record. Record result on exact test device/iOS version and signed app commit, with screenshots redacted.

## Negative and revocation matrix
| Case | Expected/recorded outcome |
|---|---|
| First install without publish consent | No index, no Alternate caller ID |
| Unknown unregistered incoming number | No Alternate label |
| Published controlled caller, app closed | Chosen alias on native incoming call |
| iPhone locked after first unlock | Alias remains available if OS loaded index |
| Reboot before/after first unlock | Record actual behavior and protected-file limitations |
| Edit published alias + reload | New label appears, old label is no longer indexed |
| Disable/erase + successful reload | No new Alternate identification; record any Phone Recents history that remains |
| Disable/erase + reload failure | Host displays error; do **not** assert old OS labels were removed |
| App Group entitlement absent or denied | Fail without falling back to unprotected storage |
| Duplicate/conflicting number / malformed snapshot | Reject or clear safely, never misidentify another caller |
| Matching Apple Contact / carrier/other caller-ID app | Document precedence empirically |
| Uninstall/reinstall or restore | Document persistence of OS labels, index, backups and consent state |

## Acceptance and handoff
- Evidence must include the tested signed head SHA, Xcode and iOS versions, enabled extension status, no-Apple-Contacts write, positive and negative call scenarios, after-lock test, disable/reload outcomes and redacted logs/screenshots.
- **Do not** call production ready solely because macOS Swift tests and unsigned simulator build pass.
- Outstanding separate work: integrate with the full local contacts directory; opt-in alias selection; privacy audit; iOS vault/Room data access; consent persistence, backup/restoration, and Android data regression tests.
- Do not merge PR #50 onto fork main before PR #47's behavior is preserved and review/retirement requirements are satisfied. No upstream posts without explicit approval.

Supporting documents: [Call Directory spec](IOS_CALL_DIRECTORY_SPIKE.md), [security issue #39](https://github.com/iansherr/alternate/issues/39), [iPhone preflight #38](https://github.com/iansherr/alternate/issues/38), [native caller acceptance #26](https://github.com/iansherr/alternate/issues/26).

Apple references: https://support.apple.com/guide/iphone/screen-and-block-calls-iphe4b3f7823/26/ios/26 and https://developer.apple.com/documentation/callkit/cxcalldirectorymanager/opensettings(completionhandler:)
