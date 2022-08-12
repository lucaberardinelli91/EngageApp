//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public enum KeychainKeys {
    public static var accessTokenKey = "accessTokenKey"
    public static var accessTokenExpiresIn = "accessTokenExpiresIn"
    public static var campaignId = "campaignId"

    // MARK: - Apple Sign In

    public static let userIdentifier = "userIdentifier"
    public static let retrievedToken = "retrievedToken"
    public static let retrievedId = "retrievedId"
    public static let authorizationCode = "authorizationCode"
    public static let email = "email"
    public static let firstName = "firstName"
    public static let lastName = "lastName"
}
