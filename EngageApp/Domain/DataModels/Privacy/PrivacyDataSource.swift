//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

// MARK: - PrivacyDataSourceModel

public struct PrivacyDataSource: Codable {
    public let index: Int?
    public let type: PrivacyTypesEnumDataSource?
    public let url: String?
    public let required: Bool?
    public let enabled: Bool?

    public init(privacy: Privacy?) {
        index = privacy?.index
        type = PrivacyTypesEnumDataSource(privacyTypesEnum: privacy?.type)
        url = privacy?.url
        required = privacy?.required
        enabled = privacy?.enabled
    }
}

// MARK: - PrivacyTypesEnumDataSourceModel

public enum PrivacyTypesEnumDataSource: String, Codable {
    case terms = "TERMS"
    case newsletter = "NEWSLETTER"
    case marketing = "MARKETING"
    case marketingThirdParty = "MARKETING_THIRD_PARTY"
    case profiling = "PROFILING"
    case profilingThirdParty = "PROFILING_THIRD_PARTY"
    case unknown = "UNKNOWN"

    public init(privacyTypesEnum: PrivacyTypesEnum?) {
        switch privacyTypesEnum {
        case .terms:
            self = .terms
        case .newsletter:
            self = .newsletter
        case .marketingThirdParty:
            self = .marketingThirdParty
        case .marketing:
            self = .marketing
        case .profiling:
            self = .profiling
        case .profilingThirdParty:
            self = .profilingThirdParty
        default:
            self = .unknown
        }
    }
}
