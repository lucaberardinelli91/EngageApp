//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct RewardDataSource: Decodable, Hashable {
    public let id: String?
    public let image: String?
    public let type: String?
    public let cost: Int?
    public let status: String?
    public let digital: Bool?
    public let max_requests: Int?
    public let limited_availability: Bool?
    public let availability: Int?
    public let campaign_id: String?
    public let created_at: String?
    public let updated_at: String?
    public let deleted_at: String?
    public let redeem_count_for_reward: Int?
    public let title: String?
    public let description: String?
    public let email: String?
    public let redeemable: Bool?
    public let redeems: Int?
    public let user_redeems: Int?
    public let at_level: String?

    enum CodingKeys: String, CodingKey {
        case id
        case image
        case type
        case cost
        case status
        case digital
        case max_requests
        case limited_availability
        case availability
        case campaign_id
        case created_at
        case updated_at
        case deleted_at
        case redeem_count_for_reward
        case title
        case description
        case email
        case redeemable
        case redeems
        case user_redeems
        case at_level
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        cost = try values.decodeIfPresent(Int.self, forKey: .cost)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        digital = try values.decodeIfPresent(Bool.self, forKey: .digital)
        max_requests = try values.decodeIfPresent(Int.self, forKey: .max_requests)
        limited_availability = try values.decodeIfPresent(Bool.self, forKey: .limited_availability)
        availability = try values.decodeIfPresent(Int.self, forKey: .availability)
        campaign_id = try values.decodeIfPresent(String.self, forKey: .campaign_id)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        deleted_at = try values.decodeIfPresent(String.self, forKey: .deleted_at)
        redeem_count_for_reward = try values.decodeIfPresent(Int.self, forKey: .redeem_count_for_reward)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        redeemable = try values.decodeIfPresent(Bool.self, forKey: .redeemable)
        redeems = try values.decodeIfPresent(Int.self, forKey: .redeems)
        user_redeems = try values.decodeIfPresent(Int.self, forKey: .user_redeems)
        at_level = try values.decodeIfPresent(String.self, forKey: .at_level)
    }

    public static func == (lhs: RewardDataSource, rhs: RewardDataSource) -> Bool {
        return lhs.id == rhs.id
    }
}
