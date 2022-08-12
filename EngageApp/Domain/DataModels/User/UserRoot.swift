//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct UserRoot: Decodable {
    public let user: UserInfo

    private enum RootKeys: String, CodingKey {
        case data
    }

    private enum CodingKeys: String, CodingKey {
        case user
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        user = try data.decode(UserInfo.self, forKey: .user)
    }
}
