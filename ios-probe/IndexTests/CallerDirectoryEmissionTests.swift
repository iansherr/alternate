import XCTest
@testable import CallerIndexContract

private final class FakeDirectorySink: CallerDirectoryEntrySink {
    private(set) var events: [String] = []

    func removeAllIdentifications() {
        events.append("clear")
    }

    func addIdentification(number: Int64, alias: String) {
        events.append("add:\(number):\(alias)")
    }
}

final class CallerDirectoryEmissionTests: XCTestCase {
    func testFullReloadPublishesOnlyValidSortedEntries() throws {
        let sink = FakeDirectorySink()
        let lower = try CallerIndexEntry(digits: "12025550124", alias: "Fictional A")
        let higher = try CallerIndexEntry(digits: "442071234567", alias: "Fictional B")
        CallerDirectoryEmission.apply(
            snapshot: CallerIndexSnapshot(enabled: true, entries: [lower, higher]),
            incremental: false, to: sink
        )
        XCTAssertEqual(sink.events, ["add:12025550124:Fictional A",
                                     "add:442071234567:Fictional B"])
    }

    func testIncrementalReloadClearsBeforeAddingCurrentNames() throws {
        let sink = FakeDirectorySink()
        let newAlias = try CallerIndexEntry(digits: "12025550124", alias: "Updated")
        CallerDirectoryEmission.apply(
            snapshot: CallerIndexSnapshot(enabled: true, entries: [newAlias]),
            incremental: true, to: sink
        )
        XCTAssertEqual(sink.events, ["clear", "add:12025550124:Updated"])
    }

    func testOptOutAndAbsentSnapshotClearIncrementalEntries() {
        let cases: [CallerIndexSnapshot?] = [CallerIndexSnapshot.disabled, nil]
        for snapshot in cases {
            let sink = FakeDirectorySink()
            CallerDirectoryEmission.apply(snapshot: snapshot, incremental: true, to: sink)
            XCTAssertEqual(sink.events, ["clear"])
        }
    }

    func testNoPublicationWhenIndexNotConsentedOrUnsorted() throws {
        let one = try CallerIndexEntry(digits: "12025550124", alias: "A")
        let two = try CallerIndexEntry(digits: "442071234567", alias: "B")
        for snapshot in [
            CallerIndexSnapshot(enabled: false, entries: [one]),
            CallerIndexSnapshot(enabled: true, entries: [two, one]),
            CallerIndexSnapshot(enabled: true, entries: [one, one])
        ] {
            let sink = FakeDirectorySink()
            CallerDirectoryEmission.apply(snapshot: snapshot, incremental: false, to: sink)
            XCTAssertTrue(sink.events.isEmpty)
        }
    }

    func testFullRequestForMissingIndexDoesNotPublishAnything() {
        let sink = FakeDirectorySink()
        CallerDirectoryEmission.apply(snapshot: nil, incremental: false, to: sink)
        XCTAssertTrue(sink.events.isEmpty)
    }
}
