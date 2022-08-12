//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct PrivacyFlags: Encodable {
    public var agreeNewsletter: Bool = false
    public var agreeMarketing: Bool = false
    public var agreeMarketingThirdParty: Bool = false
    public var agreeProfiling: Bool = false
    public var agreeTerms: Bool = false

    public init(agreeNewsletter: Bool, agreeMarketing: Bool, agreeMarketingThirdParty: Bool, agreeProfiling: Bool, agreeTerms: Bool) {
        self.agreeNewsletter = agreeNewsletter
        self.agreeMarketing = agreeMarketing
        self.agreeMarketingThirdParty = agreeMarketingThirdParty
        self.agreeProfiling = agreeProfiling
        self.agreeTerms = agreeTerms
    }
}

public struct Privacy {
    public let index: Int?
    public let type: PrivacyTypesEnum?
    public let url: String?
    public let required: Bool?
    public let enabled: Bool?

    public init(privacyDataSourceModel: PrivacyDataSource?) {
        index = privacyDataSourceModel?.index
        type = PrivacyTypesEnum(privacyTypesEnumDataSourceModel: privacyDataSourceModel?.type)
        url = privacyDataSourceModel?.url
        required = privacyDataSourceModel?.required
        enabled = privacyDataSourceModel?.enabled
    }

    static func getPrivacyConditions() -> [Privacy] {
        return [Privacy(1),
                Privacy(2),
                Privacy(3),
                Privacy(4),
                Privacy(5)]
    }

    public init(_ count: Int) {
        switch count {
        case 1:
            index = 1
            type = PrivacyTypesEnum.newsletter
            url = ""
            required = false
            enabled = true
        case 2:
            index = 2
            type = PrivacyTypesEnum.marketing
            url = ""
            required = false
            enabled = true
        case 3:
            index = 3
            type = PrivacyTypesEnum.marketingThirdParty
            url = ""
            required = false
            enabled = true
        case 4:
            index = 4
            type = PrivacyTypesEnum.profiling
            url = ""
            required = false
            enabled = true
        case 5:
            index = 5
            type = PrivacyTypesEnum.profilingThirdParty
            url = ""
            required = false
            enabled = true
        default:
            index = 0
            type = PrivacyTypesEnum.newsletter
            url = ""
            required = false
            enabled = true
        }
    }
}

// MARK: - PrivacyTypesEnum

public enum PrivacyTypesEnum {
    case terms
    case newsletter
    case marketing
    case marketingThirdParty
    case profiling
    case profilingThirdParty
    case unknown

    public init(privacyTypesEnumDataSourceModel: PrivacyTypesEnumDataSource?) {
        switch privacyTypesEnumDataSourceModel {
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
