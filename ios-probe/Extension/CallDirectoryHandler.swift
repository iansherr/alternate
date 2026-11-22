import CallKit

/// A thin native adapter: the pure projection can be verified on macOS.
private struct SystemCallDirectorySink: CallerDirectoryEntrySink {
    let context: CXCallDirectoryExtensionContext

    func removeAllIdentifications() {
        context.removeAllIdentificationEntries()
    }

    func addIdentification(number: Int64, alias: String) {
        context.addIdentificationEntry(
            withNextSequentialPhoneNumber: number,
            label: alias
        )
    }
}

/// No full contacts, network, or credentials can reach this extension.
final class AlternateCallDirectoryHandler: CXCallDirectoryProvider {
    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        // Invalid/unavailable storage is fail-closed. No exceptions or
        // user identifiers are logged from the extension.
        let snapshot = try? CallerIndexStore.appGroup().load()
        CallerDirectoryEmission.apply(
            snapshot: snapshot,
            incremental: context.isIncremental,
            to: SystemCallDirectorySink(context: context)
        )
        context.completeRequest()
    }
}
