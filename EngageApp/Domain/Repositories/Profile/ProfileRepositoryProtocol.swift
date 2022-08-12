//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol ProfileRepositoryProtocol {
    func getUser() -> AnyPublisher<UserRoot, CustomError>
    func getUserLocal() -> AnyPublisher<UserInfo?, CustomError>
    func saveUserLocal(user: UserInfo) -> AnyPublisher<Bool, CustomError>
    func deleteAccessToken() -> AnyPublisher<Void, CustomError>
    func updatePrivacyConditions(privacyFlags: PrivacyFlags) -> AnyPublisher<EmptyResponse, CustomError>
}
