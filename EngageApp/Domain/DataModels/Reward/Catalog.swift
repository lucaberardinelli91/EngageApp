//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct Catalog: Decodable {
    public let rewards: [Reward]?

    enum RootKeys: String, CodingKey {
        case data
    }

    enum CodingKeys: String, CodingKey {
        case coins
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        rewards = try data.decodeIfPresent([Reward].self, forKey: .coins)
    }
}
