import SwiftUI
import CallKit

/// A standalone, unsigned simulator-build probe—not the Alternate iPhone app.
@main
struct CallerIdProbeApp: App {
    var body: some Scene {
        WindowGroup {
            ProbeContentView()
        }
    }
}

struct ProbeContentView: View {
    @State private var status = "Extension status not checked"
    @State private var reloadStatus = "Not requested"

    // Keep this in sync with CallerIdExtension's PRODUCT_BUNDLE_IDENTIFIER.
    private let extensionID = "dev.alternate.calleridprobe.extension"

    var body: some View {
        NavigationStack {
            Form {
                Section("What this proves") {
                    Text("This test host embeds a native iOS Call Directory extension.")
                    Text("It contains one fictional test caller label. No contact records, network connections, or Apple Contacts access are used.")
                }
                Section("Extension status") {
                    Text(status)
                    Button("Check enabled status") {
                        CXCallDirectoryManager.sharedInstance
                            .getEnabledStatusForExtension(withIdentifier: extensionID) { value, error in
                                let message: String
                                if let error {
                                    message = "Status unavailable: \(error.localizedDescription)"
                                } else {
                                    switch value {
                                    case .enabled: message = "Enabled"
                                    case .disabled: message = "Disabled"
                                    case .unknown: message = "Unknown"
                                    @unknown default: message = "Unrecognized state"
                                    }
                                }
                                Task { @MainActor in status = message }
                            }
                    }
                    Text(reloadStatus)
                    Button("Request identification reload") {
                        CXCallDirectoryManager.sharedInstance
                            .reloadExtension(withIdentifier: extensionID) { error in
                                let message = error.map { "Reload failed: \($0.localizedDescription)" } ?? "Reload request completed"
                                Task { @MainActor in reloadStatus = message }
                            }
                    }
                }
                Section("Limitations") {
                    Text("An unsigned simulator build only verifies compilation and packaging. Incoming caller identification requires a signed app and a physical iPhone with the extension enabled.")
                }
            }
            .navigationTitle("Caller ID Probe")
        }
    }
}
