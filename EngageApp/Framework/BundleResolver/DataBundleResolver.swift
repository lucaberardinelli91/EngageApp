//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public class DataBundleResolver {
    public static func resolveBundle() -> Bundle {
        return Bundle(for: Self.self)
    }

    public static func returnMainBundle() -> Bundle {
        return Bundle.main
    }

    public static func appVersion() -> String? {
        return returnMainBundle().infoDictionary?["CFBundleShortVersionString"] as? String
    }

    public static func buildVersion() -> String? {
        return returnMainBundle().infoDictionary?["CFBundleVersion"] as? String
    }
}
