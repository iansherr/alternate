import Foundation

/// This restricted projection deliberately cannot hold full contact records.
struct CallerIndexEntry: Codable, Equatable {
    let number: Int64
    let alias: String

    init(digits: String, alias: String) throws {
        guard digits.count >= 7 && digits.count <= 15,
              digits.first != "0",
              digits.utf8.allSatisfy({ $0 >= 48 && $0 <= 57 }),
              let parsed = Int64(digits) else {
            throw CallerIndexError.invalidNumber
        }
        self.number = parsed
        self.alias = alias
        try validate()
    }

    func validate() throws {
        let digits = String(number)
        guard digits.count >= 7 && digits.count <= 15, number > 0 else {
            throw CallerIndexError.invalidNumber
        }
        guard alias == alias.trimmingCharacters(in: .whitespacesAndNewlines),
              !alias.isEmpty,
              alias.utf8.count <= 80,
              !alias.unicodeScalars.contains(where: { CharacterSet.controlCharacters.contains($0) }) else {
            throw CallerIndexError.invalidAlias
        }
    }
}

struct CallerIndexSnapshot: Codable, Equatable {
    let schemaVersion: Int
    let enabled: Bool
    let entries: [CallerIndexEntry]

    init(enabled: Bool, entries: [CallerIndexEntry]) {
        self.schemaVersion = 1
        self.enabled = enabled
        self.entries = entries
    }

    static let disabled = CallerIndexSnapshot(enabled: false, entries: [])

    func validate() throws {
        guard schemaVersion == 1 else { throw CallerIndexError.unsupportedVersion }
        guard entries.count <= CallerIndexStore.maxEntries else { throw CallerIndexError.tooLarge }
        guard enabled || entries.isEmpty else { throw CallerIndexError.indexNotConsented }
        var previous: Int64 = 0
        for entry in entries {
            try entry.validate()
            guard entry.number > previous else { throw CallerIndexError.duplicateOrUnsorted }
            previous = entry.number
        }
    }
}

enum CallerIndexError: Error {
    case invalidNumber
    case invalidAlias
    case unsupportedVersion
    case duplicateOrUnsorted
    case indexNotConsented
    case tooLarge
    case unavailableAppGroup
}

struct CallerIndexStore {
    static let appGroupIdentifier = "group.dev.alternate.calleridprobe"
    static let maxEntries = 10_000
    static let maxBytes = 1_500_000

    let directory: URL
    private var file: URL { directory.appendingPathComponent("consented-caller-index.json") }

    /// Missing App Group is an error, not a reason to use an unshared directory.
    static func appGroup() throws -> CallerIndexStore {
        #if os(iOS)
        guard let url = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: appGroupIdentifier
        ) else {
            throw CallerIndexError.unavailableAppGroup
        }
        return CallerIndexStore(directory: url.appendingPathComponent("CallerIndex", isDirectory: true))
        #else
        throw CallerIndexError.unavailableAppGroup
        #endif
    }

    func load() throws -> CallerIndexSnapshot {
        guard FileManager.default.fileExists(atPath: file.path) else { return .disabled }

        let attributes = try FileManager.default.attributesOfItem(atPath: file.path)
        guard let size = attributes[.size] as? NSNumber,
              size.intValue <= Self.maxBytes else {
            throw CallerIndexError.tooLarge
        }
        let payload = try Data(contentsOf: file)
        guard payload.count <= Self.maxBytes else { throw CallerIndexError.tooLarge }
        let decoded = try JSONDecoder().decode(CallerIndexSnapshot.self, from: payload)
        try decoded.validate()
        return decoded
    }

    /// Only the main app writes an explicitly consented, minimal index.
    func write(_ snapshot: CallerIndexSnapshot) throws {
        try snapshot.validate()
        let payload = try JSONEncoder().encode(snapshot)
        guard payload.count <= Self.maxBytes else { throw CallerIndexError.tooLarge }

        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        #if os(iOS)
        // Protected until first unlock, then accessible while device is locked.
        try FileManager.default.setAttributes(
            [.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication],
            ofItemAtPath: directory.path
        )
        var values = URLResourceValues()
        values.isExcludedFromBackup = true
        var protectedDirectory = directory
        try protectedDirectory.setResourceValues(values)
        try (payload as NSData).write(
            to: file,
            options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication]
        )
        #else
        try payload.write(to: file, options: .atomic)
        #endif
    }

    /// The host must still request OS reload; simply deleting a local file
    /// cannot erase previously loaded caller labels from iOS.
    func disable() throws {
        try write(.disabled)
    }
}
