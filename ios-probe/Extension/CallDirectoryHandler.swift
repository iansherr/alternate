import CallKit

/// Reads only an explicitly published minimal phone-number/alias index.
final class AlternateCallDirectoryHandler: CXCallDirectoryProvider {
    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        // Apple requires complete entries for full requests and incremental
        // removal of previous labels when the OS asks for a delta.
        if context.isIncremental {
            context.removeAllIdentificationEntries()
        }
        guard let snapshot = try? CallerIndexStore.appGroup().load(),
              snapshot.enabled else {
            // Missing consent, corrupt snapshot or unavailable App Group:
            // no new names supplied. An OS reload failure is surfaced by host.
            context.completeRequest()
            return
        }
        for entry in snapshot.entries {
            context.addIdentificationEntry(
                withNextSequentialPhoneNumber: entry.number,
                label: entry.alias
            )
        }
        context.completeRequest()
    }
}
