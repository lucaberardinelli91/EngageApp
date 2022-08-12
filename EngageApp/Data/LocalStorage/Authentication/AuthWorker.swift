//
//  EngageApp
//
//  Created by Luca Berardinelli
//
import KeychainAccess

// MARK: - AuthProtocol

internal protocol AuthProtocol {
    var accessToken: String? { get set }
}

// MARK: - AuthWorker

class AuthWorker: AuthProtocol {
    // MARK: - Business logic properties

    private let keychain: Keychain

    public var accessToken: String? {
        get { return keychain[KeychainKeys.accessTokenKey] }
        set { keychain[KeychainKeys.accessTokenKey] = newValue }
    }

    public var accessTokenExpiresIn: String? {
        get { return keychain[KeychainKeys.accessTokenExpiresIn] }
        set { keychain[KeychainKeys.accessTokenExpiresIn] = newValue }
    }

    public var campaignId: String {
        get { return keychain[KeychainKeys.campaignId] ?? "" }
        set { keychain[KeychainKeys.campaignId] = newValue }
    }

    // MARK: - Object lifecycle

    init(keychain: Keychain) {
        self.keychain = keychain
    }
}
