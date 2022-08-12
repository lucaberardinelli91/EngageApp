//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct CampaignDataSource: Decodable, Hashable {
    public var id: String?
    public var fqdn: String?
    public var name: String?
    public var brandName: String?
    public var supportEmail: String?
    public var template: String?
    public var image: String?
    public var logo: String?
    public var type: String?
    public var startAt: String?
    public var endAt: String?
    public var closed: Bool?
    public var showLeaderboard: Bool?
    public var showCatalog: Bool?
    public var showHomesteps: Bool?
    public var lang: String?
    public var maxMobiles: Int?
    public var mgmEnabled: Bool?
    public var idmClass: String?
    public var idmBaseUrl: String?
    public var idmApiKey: String?
    public var idmPhoneLoginEnabled: Bool?
    public var idmExternalVerify: Bool?
    public var idmExternalReset: Bool?
    public var smsSender: String?
    public var createdAt: String?
    public var updatedAt: String?
    public var deletedAt: String?
    public var status: String?

    enum CodingKeys: String, CodingKey {
        case id
        case fqdn
        case name
        case brand_name
        case support_email
        case template
        case image
        case logo
        case type
        case start_at
        case end_at
        case closed
        case show_leaderboard
        case show_catalog
        case show_homesteps
        case lang
        case max_mobiles
        case mgm_enabled
        case idm_class
        case idm_base_url
        case idm_api_key
        case idm_phone_login_enabled
        case idm_external_verify
        case idm_external_reset
        case sms_sender
        case created_at
        case updated_at
        case deleted_at
        case status
    }

    public init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decode(String.self, forKey: .id)
        fqdn = try? values?.decodeIfPresent(String.self, forKey: .fqdn)
        name = try? values?.decodeIfPresent(String.self, forKey: .name)
        brandName = try? values?.decodeIfPresent(String.self, forKey: .brand_name)
        supportEmail = try? values?.decodeIfPresent(String.self, forKey: .support_email)
        template = try? values?.decodeIfPresent(String.self, forKey: .template)
        image = try? values?.decodeIfPresent(String.self, forKey: .image)
        logo = try? values?.decodeIfPresent(String.self, forKey: .logo)
        type = try? values?.decodeIfPresent(String.self, forKey: .type)
        startAt = try? values?.decodeIfPresent(String.self, forKey: .start_at)
        endAt = try? values?.decodeIfPresent(String.self, forKey: .end_at)
        closed = try? values?.decodeIfPresent(Bool.self, forKey: .closed)
        showLeaderboard = try? values?.decodeIfPresent(Bool.self, forKey: .show_leaderboard)
        showCatalog = try? values?.decodeIfPresent(Bool.self, forKey: .show_catalog)
        showHomesteps = try? values?.decodeIfPresent(Bool.self, forKey: .show_homesteps)
        lang = try? values?.decodeIfPresent(String.self, forKey: .lang)
        maxMobiles = try? values?.decodeIfPresent(Int.self, forKey: .max_mobiles)
        mgmEnabled = try? values?.decodeIfPresent(Bool.self, forKey: .mgm_enabled)
        idmClass = try? values?.decodeIfPresent(String.self, forKey: .idm_class)
        idmBaseUrl = try? values?.decodeIfPresent(String.self, forKey: .idm_base_url)
        idmApiKey = try? values?.decodeIfPresent(String.self, forKey: .idm_api_key)
        idmPhoneLoginEnabled = try? values?.decodeIfPresent(Bool.self, forKey: .idm_phone_login_enabled)
        idmExternalVerify = try? values?.decodeIfPresent(Bool.self, forKey: .idm_external_verify)
        idmExternalReset = try? values?.decodeIfPresent(Bool.self, forKey: .idm_external_reset)
        smsSender = try? values?.decodeIfPresent(String.self, forKey: .sms_sender)
        createdAt = try? values?.decodeIfPresent(String.self, forKey: .created_at)
        updatedAt = try? values?.decodeIfPresent(String.self, forKey: .updated_at)
        deletedAt = try? values?.decodeIfPresent(String.self, forKey: .deleted_at)
        status = try? values?.decodeIfPresent(String.self, forKey: .status)
    }

    public static func == (lhs: CampaignDataSource, rhs: CampaignDataSource) -> Bool {
        return lhs.id == rhs.id
    }
}
