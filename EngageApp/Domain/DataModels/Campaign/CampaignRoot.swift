//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct CampaignRoot: Decodable {
    public let campaign: Campaign

    private enum RootKeys: String, CodingKey {
        case data
    }

    private enum CodingKeys: String, CodingKey {
        case campaign
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        campaign = try data.decode(Campaign.self, forKey: .campaign)
    }
}
