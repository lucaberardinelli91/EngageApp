//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct LoginByOtpToken: Decodable {
    public let accessToken: String
    public let tokenType: String
    public let expiresIn: Int

    private enum CodingKeys: String, CodingKey {
        case access_token
        case token_type
        case expires_in
    }

    public init(from decoder: Decoder) throws {
        let user = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try user.decode(String.self, forKey: .access_token)
        tokenType = try user.decode(String.self, forKey: .token_type)
        expiresIn = try user.decode(Int.self, forKey: .expires_in)
    }
}
