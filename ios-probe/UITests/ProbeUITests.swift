import XCTest

/// UI smoke coverage only. Native Phone caller identification cannot be
/// reproduced by an iOS Simulator test runner.
final class ProbeUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    @MainActor
    func testPrivacyDisclosureAndManualPublishControls() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.navigationBars["Caller ID Probe"].waitForExistence(timeout: 20))
        XCTAssertTrue(app.buttons["Publish this number and alias"].exists)
        XCTAssertTrue(app.buttons["Disable and erase saved aliases"].exists)
        XCTAssertTrue(app.textFields["International digits, without +"].exists)
        XCTAssertTrue(app.textFields["Caller label visible to iOS"].exists)
        let labels = app.staticTexts.matching(
            NSPredicate(format: "label CONTAINS[c] %@", "No caller ID is published")
        )
        XCTAssertTrue(labels.firstMatch.exists, "Consent notice must remain visible")
    }

    @MainActor
    func testExtensionStatusActionDoesNotCrashWhenUnavailable() {
        let app = XCUIApplication()
        app.launch()
        let button = app.buttons["Check extension enablement"]
        XCTAssertTrue(button.waitForExistence(timeout: 20))
        button.tap()
        XCTAssertTrue(app.buttons["Retry iOS caller-ID reload"].exists)
        // The simulator has no cellular call subsystem: do not treat the
        // extension status response as evidence of native identification.
    }
}
