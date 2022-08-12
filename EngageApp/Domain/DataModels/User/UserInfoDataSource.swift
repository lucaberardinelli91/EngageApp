//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct UserInfoDataSource: Decodable, Hashable {
    public var id: String?
    public var agreeTerms: Bool?
    public var agreeMarketing: Bool?
    public var agreeMarketingThirdParty: Bool?
    public var agreeProfiling: Bool?
    public var agreeProfilingThirdParty: Bool?
    public var agreeNewsletter: Bool?
    public var last_seen: String?
    public var remove_requested_at: String?
    public var remove_done_at: String?
    public var verify_code: Int?
    public var verified_at: String?
    public var token_invalid_before: String?
    public var points: Int?
    public var coins: Int?
    public var idm_id: String?
    public var idm_token: String?
    public var idm_refresh_token: String?
    public var incomplete_profile_fields: String?
    public var affiliate_id: String?
    public var campaign_id: String?
    public var referrer_id: String?
    public var created_at: String?
    public var deleted_at: String?
    public var name: String?
    public var profile: UserProfileDataSource?

    enum CodingKeys: String, CodingKey {
        case id
        case last_seen
        case privacy
        case profilation
        case marketing
        case third
        case third_profilation
        case tos
        case remove_requested_at
        case remove_done_at
        case verify_code
        case verified_at
        case token_invalid_before
        case points
        case coins
        case idm_id
        case idm_token
        case idm_refresh_token
        case incomplete_profile_fields
        case affiliate_id
        case campaign_id
        case referrer_id
        case created_at
        case deleted_at
        case name
        case profile
    }

    public init() {}

    public init(from decoder: Decoder) throws {
        let user = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? user?.decodeIfPresent(String.self, forKey: .id)
        agreeTerms = try? user?.decodeIfPresent(Bool.self, forKey: .tos) // privacy
        agreeMarketing = try? user?.decodeIfPresent(Bool.self, forKey: .marketing)
        agreeMarketingThirdParty = try? user?.decodeIfPresent(Bool.self, forKey: .third)
        agreeProfiling = try? user?.decodeIfPresent(Bool.self, forKey: .profilation)
        agreeProfilingThirdParty = try? user?.decodeIfPresent(Bool.self, forKey: .third_profilation)
        agreeNewsletter = try? user?.decodeIfPresent(Bool.self, forKey: .profilation) // ???????????????????

        last_seen = try? user?.decodeIfPresent(String.self, forKey: .last_seen)
        remove_requested_at = try? user?.decodeIfPresent(String.self, forKey: .remove_requested_at)
        remove_done_at = try? user?.decodeIfPresent(String.self, forKey: .remove_done_at)
        verify_code = try? user?.decodeIfPresent(Int.self, forKey: .verify_code)
        verified_at = try? user?.decodeIfPresent(String.self, forKey: .verified_at)
        token_invalid_before = try? user?.decodeIfPresent(String.self, forKey: .token_invalid_before)
        points = try? user?.decodeIfPresent(Int.self, forKey: .points)
        coins = try? user?.decodeIfPresent(Int.self, forKey: .coins)
        idm_id = try? user?.decodeIfPresent(String.self, forKey: .idm_id)
        idm_token = try? user?.decodeIfPresent(String.self, forKey: .idm_token)
        idm_refresh_token = try? user?.decodeIfPresent(String.self, forKey: .idm_refresh_token)
        incomplete_profile_fields = try? user?.decodeIfPresent(String.self, forKey: .incomplete_profile_fields)
        affiliate_id = try? user?.decodeIfPresent(String.self, forKey: .affiliate_id)
        campaign_id = try? user?.decodeIfPresent(String.self, forKey: .campaign_id)
        referrer_id = try? user?.decodeIfPresent(String.self, forKey: .referrer_id)
        created_at = try? user?.decodeIfPresent(String.self, forKey: .created_at)
        deleted_at = try? user?.decodeIfPresent(String.self, forKey: .deleted_at)
        name = try? user?.decodeIfPresent(String.self, forKey: .name)
        profile = try? user?.decodeIfPresent(UserProfileDataSource.self, forKey: .profile)
    }

    public static func == (lhs: UserInfoDataSource, rhs: UserInfoDataSource) -> Bool {
        return lhs.id == rhs.id
    }
}

public struct UserProfileDataSource: Codable, Hashable {
    public var first_name: String?
    public var last_name: String?
    public var mobile: String?
    public var birthday: String?
    public var gender: String?
    public var initials: String?
    public var email: UserEmailDataSource?

    private enum CodingKeys: String, CodingKey {
        case first_name
        case last_name
        case mobile
        case birthday
        case gender
        case initials
        case email
    }

    public init() {}

    public init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        first_name = try? values?.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try? values?.decodeIfPresent(String.self, forKey: .last_name)
        mobile = try? values?.decodeIfPresent(String.self, forKey: .mobile)
        birthday = try? values?.decodeIfPresent(String.self, forKey: .birthday)
        gender = try? values?.decodeIfPresent(String.self, forKey: .gender)
        initials = try? values?.decodeIfPresent(String.self, forKey: .initials)
        email = try? values?.decodeIfPresent(UserEmailDataSource.self, forKey: .email)
    }
}

public struct UserEmailDataSource: Codable, Hashable {
    public var email: String?

    private enum CodingKeys: String, CodingKey {
        case email
    }

    public init() {}

    public init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        email = try? values?.decodeIfPresent(String.self, forKey: .email)
    }
}
