//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct LoginByOtpDataSource: Decodable {
    public let token: LoginByOtpToken

    private enum RootKeys: String, CodingKey {
        case data
    }

    private enum NestedKeys: String, CodingKey {
        case token
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        let data = try container.nestedContainer(keyedBy: NestedKeys.self, forKey: .data)
        token = try data.decode(LoginByOtpToken.self, forKey: .token)
    }
}
