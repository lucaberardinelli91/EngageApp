//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol UserProtocol {
    /// User
    func getUser() -> AnyPublisher<UserInfo?, CustomError>
    func saveUser(user: UserInfo) -> AnyPublisher<Bool, CustomError>

    /// Access token
    func saveAccessToken(token: LoginByOtpToken) -> AnyPublisher<Bool, CustomError>
    func getAccessToken() -> TokenKeyChain?
    func deleteAccessToken() -> AnyPublisher<Void, CustomError>

    /// Campaign
    func saveCampaignId(id: String) -> AnyPublisher<Bool, CustomError>
    func getCampaignId() -> String
}
