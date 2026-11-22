import Foundation

/// Abstraction lets us verify exactly what is sent to Call Directory without
/// trying to instantiate Apple's system-owned CXCallDirectoryExtensionContext.
protocol CallerDirectoryEntrySink {
    func removeAllIdentifications()
    func addIdentification(number: Int64, alias: String)
}

enum CallerDirectoryEmission {
    static func apply(
        snapshot: CallerIndexSnapshot?,
        incremental: Bool,
        to sink: CallerDirectoryEntrySink
    ) {
        // Apple's incremental API permits removing all previous entries.
        // Clearing first also removes old labels on explicit opt-out/relabel.
        if incremental {
            sink.removeAllIdentifications()
        }

        // Fail closed if absent, non-consented or corrupt. Do not publish a
        // partial index, even if one entry is invalid.
        guard let snapshot, snapshot.enabled,
              (try? snapshot.validate()) != nil else {
            return
        }
        for entry in snapshot.entries {
            sink.addIdentification(number: entry.number, alias: entry.alias)
        }
    }
}
