//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct UserInfo: Decodable {
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
    public var profile: UserProfile?
    
    public init(){
        self.name = "Mario Rossi"
    }

    public init(userDataSource: UserInfoDataSource) {
        id = userDataSource.id ?? ""
        agreeTerms = userDataSource.agreeTerms ?? false
        agreeMarketing = userDataSource.agreeMarketing ?? false
        agreeMarketingThirdParty = userDataSource.agreeMarketingThirdParty ?? false
        agreeProfiling = userDataSource.agreeProfiling ?? false
        agreeProfilingThirdParty = userDataSource.agreeProfilingThirdParty ?? false
        agreeNewsletter = userDataSource.agreeNewsletter ?? false
        last_seen = userDataSource.last_seen ?? ""
        remove_requested_at = userDataSource.remove_requested_at ?? ""
        remove_done_at = userDataSource.remove_done_at ?? ""
        verify_code = userDataSource.verify_code ?? 0
        verified_at = userDataSource.verified_at ?? ""
        token_invalid_before = userDataSource.token_invalid_before ?? ""
        points = userDataSource.points ?? 0
        coins = userDataSource.coins ?? 0
        idm_id = userDataSource.idm_id ?? ""
        idm_token = userDataSource.idm_token ?? ""
        idm_refresh_token = userDataSource.idm_refresh_token ?? ""
        incomplete_profile_fields = userDataSource.incomplete_profile_fields ?? ""
        affiliate_id = userDataSource.affiliate_id ?? ""
        campaign_id = userDataSource.campaign_id ?? ""
        referrer_id = userDataSource.referrer_id ?? ""
        created_at = userDataSource.created_at ?? ""
        deleted_at = userDataSource.deleted_at ?? ""
        name = userDataSource.name ?? ""
        profile = UserProfile(userProfileDataSource: userDataSource.profile ?? UserProfileDataSource())
    }

    public init(agreeTerms: Bool, agreeMarketing: Bool, agreeMarketingThirdParty: Bool, agreeProfiling: Bool, agreeProfilingThirdParty: Bool, agreeNewsletter: Bool, id: String) {
        self.id = id
        self.agreeTerms = agreeTerms
        self.agreeMarketing = agreeMarketing
        self.agreeMarketingThirdParty = agreeMarketingThirdParty
        self.agreeNewsletter = agreeNewsletter
        self.agreeProfiling = agreeProfiling
        self.agreeProfilingThirdParty = agreeProfilingThirdParty
        last_seen = ""
        remove_requested_at = ""
        remove_done_at = ""
        verify_code = 0
        verified_at = ""
        token_invalid_before = ""
        points = 0
        coins = 0
        idm_id = ""
        idm_token = ""
        idm_refresh_token = ""
        incomplete_profile_fields = ""
        affiliate_id = ""
        campaign_id = ""
        referrer_id = ""
        created_at = ""
        deleted_at = ""
        name = ""
        profile = UserProfile(userProfileDataSource: UserProfileDataSource())
    }
}

public struct UserProfile: Decodable {
    public var firstName: String?
    public var lastName: String?
    public var mobile: String?
    public var birthday: String?
    public var gender: String?
    public var initials: String?
    public var email: UserEmail?

    public init(userProfileDataSource: UserProfileDataSource) {
        firstName = userProfileDataSource.first_name
        lastName = userProfileDataSource.last_name
        mobile = userProfileDataSource.mobile
        birthday = userProfileDataSource.birthday
        gender = userProfileDataSource.gender
        initials = userProfileDataSource.initials
        email = UserEmail(userEmailDataSource: userProfileDataSource.email ?? UserEmailDataSource())
    }
}

public struct UserEmail: Decodable {
    public var email: String?

    public init(userEmailDataSource: UserEmailDataSource) {
        email = userEmailDataSource.email
    }
}
