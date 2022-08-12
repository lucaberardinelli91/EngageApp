//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct Campaign: Decodable, Hashable {
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

    public init(campaignDataSource: CampaignDataSource) {
        id = campaignDataSource.id
        fqdn = campaignDataSource.fqdn
        name = campaignDataSource.name
        brandName = campaignDataSource.brandName
        supportEmail = campaignDataSource.supportEmail
        template = campaignDataSource.template
        image = campaignDataSource.image
        logo = campaignDataSource.logo
        type = campaignDataSource.type
        startAt = campaignDataSource.startAt
        endAt = campaignDataSource.endAt
        closed = campaignDataSource.closed
        showLeaderboard = campaignDataSource.showLeaderboard
        showCatalog = campaignDataSource.showCatalog
        showHomesteps = campaignDataSource.showHomesteps
        lang = campaignDataSource.lang
        maxMobiles = campaignDataSource.maxMobiles
        mgmEnabled = campaignDataSource.mgmEnabled
        idmClass = campaignDataSource.idmClass
        idmBaseUrl = campaignDataSource.idmBaseUrl
        idmApiKey = campaignDataSource.idmApiKey
        idmPhoneLoginEnabled = campaignDataSource.idmPhoneLoginEnabled
        idmExternalVerify = campaignDataSource.idmExternalVerify
        idmExternalReset = campaignDataSource.idmExternalReset
        smsSender = campaignDataSource.smsSender
        createdAt = campaignDataSource.createdAt
        updatedAt = campaignDataSource.updatedAt
        deletedAt = campaignDataSource.deletedAt
        status = campaignDataSource.status
    }

    public static func == (lhs: Campaign, rhs: Campaign) -> Bool {
        return lhs.id == rhs.id
    }
}
