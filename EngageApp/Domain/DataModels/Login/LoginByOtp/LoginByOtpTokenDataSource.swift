//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct LoginByOtpTokenDataSource: Decodable {
    public let access_token: String
    public let token_type: String
    public let expires_in: Int

    private enum CodingKeys: String, CodingKey {
        case access_token
        case token_type
        case expires_in
    }

    public init(from decoder: Decoder) throws {
        let user = try decoder.container(keyedBy: CodingKeys.self)
        access_token = try user.decode(String.self, forKey: .access_token)
        token_type = try user.decode(String.self, forKey: .token_type)
        expires_in = try user.decode(Int.self, forKey: .expires_in)
    }
}
