import CallKit

/// Minimal Call Directory extension with a fictional, reserved example number.
/// Build-and-packaging proof only. Production must load explicitly consented
/// number + visible-alias entries from a protected App Group snapshot.
final class AlternateCallDirectoryHandler: CXCallDirectoryProvider {
    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        // US 202-555-0124 is in the fictional 555-0100–0199 block.
        // Replace ONLY with an authorized test caller on a signed test device.
        context.addIdentificationEntry(
            withNextSequentialPhoneNumber: 12025550124,
            label: "Alternate Fictional Test"
        )
        context.completeRequest()
    }
}
