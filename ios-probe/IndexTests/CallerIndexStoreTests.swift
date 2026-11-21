import XCTest
@testable import CallerIndexContract

final class CallerIndexStoreTests: XCTestCase {
    func testAbsentIndexDoesNotPublishAnything() throws {
        let store = makeStore()
        XCTAssertEqual(try store.load(), .disabled)
    }

    func testConsentRequiredForAnyNumber() throws {
        let entry = try CallerIndexEntry(digits: "12025550124", alias: "Fictional")
        XCTAssertThrowsError(try CallerIndexSnapshot(enabled: false, entries: [entry]).validate())
    }

    func testRoundTripAndExplicitDisableRemoveAlias() throws {
        let store = makeStore()
        let first = try CallerIndexEntry(digits: "12025550124", alias: "Fictional Contact")
        let second = try CallerIndexEntry(digits: "442071234567", alias: "Fictional London")
        let snapshot = CallerIndexSnapshot(enabled: true, entries: [first, second])
        try store.write(snapshot)
        XCTAssertEqual(try store.load(), snapshot)
        try store.disable()
        XCTAssertEqual(try store.load(), .disabled)
        let data = try Data(contentsOf: store.directory.appendingPathComponent("consented-caller-index.json"))
        XCTAssertFalse(String(data: data, encoding: .utf8)!.contains("Fictional Contact"))
    }

    func testOrderingDuplicateAndAliasValidation() throws {
        let first = try CallerIndexEntry(digits: "12025550124", alias: "First")
        let other = try CallerIndexEntry(digits: "442071234567", alias: "Second")
        XCTAssertNoThrow(try CallerIndexSnapshot(enabled: true, entries: [first, other]).validate())
        XCTAssertThrowsError(try CallerIndexSnapshot(enabled: true, entries: [other, first]).validate())
        XCTAssertThrowsError(try CallerIndexSnapshot(enabled: true, entries: [first, first]).validate())
        XCTAssertThrowsError(try CallerIndexEntry(digits: "12025550124", alias: "Private\nNote"))
    }

    func testBadPhoneNumbersAreRejectedNotGuessed() {
        for value in ["", "+12025550124", "012025550124", "202-555-0124",
                      "abc", "123", String(repeating: "9", count: 16)] {
            XCTAssertThrowsError(try CallerIndexEntry(digits: value, alias: "Test"))
        }
        for value in ["", " ", " Name ", String(repeating: "é", count: 41)] {
            XCTAssertThrowsError(try CallerIndexEntry(digits: "12025550124", alias: value))
        }
    }

    func testCorruptAndOversizedIndexFailClosed() throws {
        let store = makeStore()
        try FileManager.default.createDirectory(at: store.directory, withIntermediateDirectories: true)
        let path = store.directory.appendingPathComponent("consented-caller-index.json")
        try Data("not-json".utf8).write(to: path)
        XCTAssertThrowsError(try store.load())
        try Data(repeating: 0x31, count: CallerIndexStore.maxBytes + 1).write(to: path)
        XCTAssertThrowsError(try store.load())
    }

    func testNumericOrder() throws {
        let lower = try CallerIndexEntry(digits: "12025550124", alias: "A")
        let higher = try CallerIndexEntry(digits: "442071234567", alias: "B")
        XCTAssertTrue(lower.number < higher.number)
    }

    private func makeStore() -> CallerIndexStore {
        let directory = FileManager.default.temporaryDirectory
            .appendingPathComponent("caller-index-test-" + UUID().uuidString, isDirectory: true)
        addTeardownBlock { try? FileManager.default.removeItem(at: directory) }
        return CallerIndexStore(directory: directory)
    }
}
