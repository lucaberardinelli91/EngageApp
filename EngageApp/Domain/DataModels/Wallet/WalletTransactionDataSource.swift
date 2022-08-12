//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct WalletTransactionDataSource: Decodable {
    public var type: String?
    public var title: String?
    public var coins: Int?
    public var created_at: String?

    enum CodingKeys: String, CodingKey {
        case type
        case title
        case coins
        case created_at
    }

    public init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        type = try? values?.decodeIfPresent(String.self, forKey: .type)
        title = try? values?.decodeIfPresent(String.self, forKey: .title)
        coins = try? values?.decodeIfPresent(Int.self, forKey: .coins)
        created_at = try? values?.decodeIfPresent(String.self, forKey: .created_at)
    }
}
