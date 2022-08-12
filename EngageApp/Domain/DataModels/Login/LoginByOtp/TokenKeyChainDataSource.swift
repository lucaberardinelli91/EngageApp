//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct TokenKeyChainDataSource: Decodable {
    public let accessToken: String
    public let expiresIn: String

    private enum CodingKeys: String, CodingKey {
        case access_token
        case expires_in
    }

    public init(accessToken: String, expiresIn: String) {
        self.accessToken = accessToken
        self.expiresIn = expiresIn
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decode(String.self, forKey: .access_token)
        expiresIn = try values.decode(String.self, forKey: .expires_in)
    }
}
