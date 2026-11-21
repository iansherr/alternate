# iPhone Call Directory spike: bounded specification

**Planning artifact only. No iOS project created, no build claims.** Related to [P0-08](https://github.com/iansherr/alternate/issues/38), [CID-01](https://github.com/iansherr/alternate/issues/23), [CID-02](https://github.com/iansherr/alternate/issues/24).

## Objective
On an actual test iPhone, identify exactly one known synthetic incoming phone number with a chosen alias via a native Swift `CXCallDirectoryProvider` extension, **without adding anything to Apple Contacts or introducing a cloud service**. This is an independent proof: do not import Alternate's UI/DB yet.

## Preflight checklist
- [ ] Available macOS/Xcode with documented version, test iPhone and second calling line.
- [ ] Apple team/signing/provisioning route identified; avoid sharing certificates/tokens/UDIDs publicly.
- [ ] App + extension bundle IDs and App Group entitlement scoped (to be created only during implementation).
- [ ] Confirm target iOS settings path for enabling third-party Call Directory on exact OS release.
- [ ] Confirm user accepts that identification labels are visible to iOS and may appear in Phone Recents.
- [ ] Use obviously synthetic name/number and redacted screenshots only.

## Architecture contract
1. Main app owns private source directory (later KMP/native); extension gets **only** minimal phone-number-to-visible-label snapshot through App Group.
2. Snapshot is versioned, sorted ascending numerically, atomic-write/rename, fail-closed on corruption, and stores no address, photo, notes, email, PIN or keys.
3. Define iOS file-protection mode compatible with after-first-unlock call identification; don't trade away at-rest protection without owner approval.
4. `CXCallDirectoryProvider` inserts normalized integer phone numbers and labels; validate numeric format, overflow, duplicate keys, and extension cancellation/time budget. iOS manages call display.
5. Main app requests extension reload and reports disabled/error states; switching off and deleting must *actually* remove indexed labels with documented OS limitations.
6. Do not confuse Android `ContactsContract.Directory` with iOS Call Directory—they are unrelated APIs.

## Positive and negative real-device acceptance
| Test | Expected evidence |
|---|---|
| Unknown number | No Alternate label |
| One registered number | Chosen alias appears in native incoming call screen |
| Application locked/not running | Label still appears after extension snapshot has loaded |
| Contact deleted / alias changed | After reload, obsolete registration gone; native Recents history behavior separately recorded |
| Extension disabled | No new identification from the extension; identify error states |
| Reboot and first unlock | Availability and file-protection limitation measured, never assumed |
| Duplicate and malformed numbers | Rejected or deterministically resolved, not mislabeled |
| Apple Contacts same number | Record precedence empirically; no production claim without evidence |
| Airplane mode / connectivity | Already-loaded local mapping works without caller-ID server (test scenario requires cellular/Wi-Fi Calling as appropriate) |
| Outgoing action | Never auto-dials without deliberate user action inside app |

## Reference APIs
- [CXCallDirectoryProvider](https://developer.apple.com/documentation/callkit/cxcalldirectoryprovider)
- [Call Directory extension context](https://developer.apple.com/documentation/callkit/cxcalldirectoryextensioncontext)
- [Apple identification and blocking calls](https://developer.apple.com/documentation/callkit/identifying-and-blocking-calls)
- [Apple app group security](https://support.apple.com/guide/security/app-protection-and-app-groups-in-ios-ipados-and-visionos-sec1a976c067/web)

## Evidence package
Record extension/app IDs redacted as needed, commit/tested SHA, iOS/Xcode version, signing prerequisites, exact clean build commands, extension enablement and reload status, consent state, test number anonymized, screenshots without PII, and failure modes. A simulator compile **does not** prove real incoming caller ID.

**No claim of success until a real physical iPhone incoming call has passed.**
