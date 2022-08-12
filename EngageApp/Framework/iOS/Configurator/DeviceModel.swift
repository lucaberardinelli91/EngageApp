//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public class DeviceModel: CustomStringConvertible {
    /// Device unique identifier string (may change between installations)
    public private(set) var guid: String

    /// Current OS version
    public private(set) var systemVersion: String

    /// Current device's model (may change between backups/restores)
    public private(set) var model: String

    /// Current device's language (may change between restarts)
    public private(set) var language: String

    public var description: String {
        return "Device GUID: \(guid)"
    }

    /// Return client version.
    /// - Returns: String
    public func clientVersion() -> String {
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    }

    /// - Returns: String
    public func buildVersion() -> String {
        let full_version = clientVersion()
        let index = full_version.range(of: ".", options: .backwards)!
        return String(full_version[full_version.index(after: index.lowerBound)...])
    }

    /// Return a formatted string for currently device
    ///
    /// - Parameter name: name of the application
    /// - Returns: User-Agent conform string
    public func userAgent() -> String {
        if let info = Bundle.main.infoDictionary {
            let executable = info[kCFBundleExecutableKey as String] as? String ?? "Unknown"
            let appVersion = info["CFBundleShortVersionString"] as? String ?? "Unknown"

            let osNameVersion: String = {
                let device = UIDevice.current.localizedModel
                let version = ProcessInfo.processInfo.operatingSystemVersion
                let locale = Locale.preferredLanguages.first?.components(separatedBy: "-").first ?? "en"
                let versionString = "\(version.majorVersion)_\(version.minorVersion)_\(version.patchVersion) like Mac OSX; \(locale)"

                let osName: String = {
                    #if os(iOS)
                        return "iOS"
                    #elseif os(watchOS)
                        return "watchOS"
                    #elseif os(tvOS)
                        return "tvOS"
                    #elseif os(macOS)
                        return "OS X"
                    #elseif os(Linux)
                        return "Linux"
                    #else
                        return "Unknown"
                    #endif
                }()

                return "\(device); \(osName) \(versionString)"
            }()

            return "\(executable)/\(appVersion) (\(osNameVersion))"
        }

        return "EngageApp"
    }

    internal lazy var systemUserAgent: String = {
        let prefix = "EngageApp"
        let version = self.clientVersion()
        let build = self.buildVersion()
        let deviceModel = UIDevice.current.model
        let systemVersion = UIDevice.current.systemVersion
        let displayName = "EngageAppiOS"
        let fullAgent = "\(prefix)/\(version)b\(build) (\(deviceModel); iPhone OS \(systemVersion)) (\(displayName))"
        return fullAgent
    }()

    public init() {
        let currentDevice = UIDevice.current

        let generatedGUID = currentDevice.identifierForVendor?.uuidString ?? NSUUID().uuidString
        guid = generatedGUID

        systemVersion = currentDevice.systemVersion
        model = currentDevice.model
        language = Locale.preferredLanguages.first?.components(separatedBy: "-").first ?? "en"
    }
}
