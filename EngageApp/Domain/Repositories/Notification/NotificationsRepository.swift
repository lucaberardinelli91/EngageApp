//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

class NotificationsRepository: NotificationsRepositoryProtocol {
    private var networkWorker: NetworkingDataSourceProtocol
    private var localStorageWorker: UserProtocol
    private var cancellables = Set<AnyCancellable>()

    init(networkWorker: NetworkingDataSourceProtocol, localStorageWorker: UserProtocol) {
        self.networkWorker = networkWorker
        self.localStorageWorker = localStorageWorker
    }

    func getNotifications() -> AnyPublisher<[Notification]?, CustomError> {
        let campaignId = localStorageWorker.getCampaignId()
        return networkWorker.getNotifications(campaignId: campaignId)
    }
}
