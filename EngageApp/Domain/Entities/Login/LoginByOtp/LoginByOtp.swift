//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct LoginByOtp: Decodable {
    public let token: LoginByOtpToken

    private enum RootKeys: String, CodingKey {
        case data
    }

    private enum CodingKeys: String, CodingKey {
        case token
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        token = try data.decode(LoginByOtpToken.self, forKey: .token)
    }
}
