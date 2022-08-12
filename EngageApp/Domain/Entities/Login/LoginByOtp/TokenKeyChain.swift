//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct TokenKeyChain: Decodable {
    public let accessToken: String
    public let expiresIn: String

    public init(accessToken: String, expiresIn: String) {
        self.accessToken = accessToken
        self.expiresIn = expiresIn
    }

    public init(tokenKeyChainDataSource: TokenKeyChainDataSource) {
        accessToken = tokenKeyChainDataSource.accessToken
        expiresIn = tokenKeyChainDataSource.expiresIn
    }
}
