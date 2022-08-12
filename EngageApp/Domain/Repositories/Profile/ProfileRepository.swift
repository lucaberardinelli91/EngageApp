//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

class ProfileRepository: ProfileRepositoryProtocol {
    private var networkWorker: NetworkingDataSourceProtocol
    private var localStorageWorker: UserProtocol
    private var cancellables = Set<AnyCancellable>()

    init(networkWorker: NetworkingDataSourceProtocol, localStorageWorker: UserProtocol) {
        self.networkWorker = networkWorker
        self.localStorageWorker = localStorageWorker
    }
    
    func getUser() -> AnyPublisher<UserRoot, CustomError> {
        let campaignId = localStorageWorker.getCampaignId()
        return networkWorker.getUser(campaignId: campaignId)
    }

    func getUserLocal() -> AnyPublisher<UserInfo?, CustomError> {
        return localStorageWorker.getUser()
    }

    func saveUserLocal(user: UserInfo) -> AnyPublisher<Bool, CustomError> {
        return localStorageWorker.saveUser(user: user)
    }

    func updatePrivacyConditions(privacyFlags: PrivacyFlags) -> AnyPublisher<EmptyResponse, CustomError> {
        return networkWorker.updatePrivacyConditions(privacyFlags: privacyFlags)
    }

    func deleteAccessToken() -> AnyPublisher<Void, CustomError> {
        return localStorageWorker.deleteAccessToken()
    }
}
