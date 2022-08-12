//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct InstantWinDataSource: Decodable {
    public let won: Bool

    private enum RootKeys: String, CodingKey {
        case data
    }

    private enum NestedKeys: String, CodingKey {
        case won
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        let data = try container.nestedContainer(keyedBy: NestedKeys.self, forKey: .data)
        won = try data.decode(Bool.self, forKey: .won)
    }
}
