//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct WalletRoot: Decodable {
    public let transactions: [WalletTransaction]?

    enum RootKeys: String, CodingKey {
        case data
    }

    enum CodingKeys: String, CodingKey {
        case action_list
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        transactions = try data.decodeIfPresent([WalletTransaction].self, forKey: .action_list)
    }
}
