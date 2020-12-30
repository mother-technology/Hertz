import SwiftUI

extension Bundle {
    var bundleShortVersion: Double {
        guard let bundleShortVersionString = infoDictionary?["CFBundleShortVersionString"] as? String else {
            return 0
        }

        guard let version = Double(bundleShortVersionString) else {
            return 0
        }

        return version
    }

    var bundleVersion: Double {
        guard let bundleVersionString = infoDictionary?["CFBundleVersion"] as? String else {
            return 0
        }

        guard let version = Double(bundleVersionString) else {
            return 0
        }

        return version
    }
}
