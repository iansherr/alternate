import SwiftUI
import CallKit

/// A standalone Call Directory integration probe, not a completed Alternate app.
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
    @State private var reloadStatus = "No index published"
    @State private var numberDigits = "12025550124"
    @State private var visibleAlias = "Alternate Fictional Test"

    // Keep this in sync with the extension bundle ID.
    private let extensionID = "dev.alternate.calleridprobe.extension"

    var body: some View {
        NavigationStack {
            Form {
                Section("Experimental caller identification") {
                    Text("Only a phone number and a chosen alias are shared with the iOS caller-identification system. No full contact records are imported.")
                    Text("Published labels may appear on the incoming call screen and in native Phone history. No caller ID is published without an explicit action below.")
                }
                Section("Opt in a test caller") {
                    TextField("International digits, without +", text: $numberDigits)
                        .keyboardType(.numberPad)
                    TextField("Caller label visible to iOS", text: $visibleAlias)
                    Button("Publish this number and alias") {
                        do {
                            let entry = try CallerIndexEntry(digits: numberDigits, alias: visibleAlias)
                            try CallerIndexStore.appGroup().write(
                                CallerIndexSnapshot(enabled: true, entries: [entry])
                            )
                            reloadStatus = "Index saved; asking iOS to reload."
                            requestReload()
                        } catch {
                            reloadStatus = "Could not safely publish. Check number, label and App Group signing."
                        }
                    }
                    Button("Disable and erase saved aliases") {
                        do {
                            try CallerIndexStore.appGroup().disable()
                            reloadStatus = "Index cleared; asking iOS to reload."
                            requestReload()
                        } catch {
                            reloadStatus = "Could not clear index. Previously loaded OS labels may remain."
                        }
                    }
                }
                Section("Extension") {
                    Text(status)
                    Button("Check extension enablement") {
                        CXCallDirectoryManager.sharedInstance
                            .getEnabledStatusForExtension(withIdentifier: extensionID) { value, error in
                                let message: String
                                if error != nil {
                                    message = "Status unavailable"
                                } else {
                                    switch value {
                                    case .enabled: message = "Enabled"
                                    case .disabled: message = "Disabled"
                                    case .unknown: message = "Unknown"
                                    @unknown default: message = "Unrecognized status"
                                    }
                                }
                                Task { @MainActor in status = message }
                            }
                    }
                    Text(reloadStatus)
                    Button("Retry iOS caller-ID reload") {
                        requestReload()
                    }
                }
                Section("Limitations") {
                    Text("The default number is fictional and cannot prove actual caller recognition. A physical iPhone, valid App Group provisioning and a controlled real calling number are required.")
                    Text("Disabling cannot intercept native Phone Recents or guarantee that historical labels disappear.")
                }
            }
            .navigationTitle("Caller ID Probe")
        }
    }

    private func requestReload() {
        CXCallDirectoryManager.sharedInstance.reloadExtension(withIdentifier: extensionID) { error in
            let message = error == nil
                ? "Reload request completed; incoming calls still need real-device testing."
                : "Reload failed; previously registered OS caller labels may remain."
            Task { @MainActor in reloadStatus = message }
        }
    }
}
