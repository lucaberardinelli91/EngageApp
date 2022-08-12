//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

class MissionsRepository: MissionsRepositoryProtocol {
    private var networkWorker: NetworkingDataSourceProtocol
    private var localStorageWorker: UserProtocol
    private var cancellables = Set<AnyCancellable>()

    init(networkWorker: NetworkingDataSourceProtocol, localStorageWorker: UserProtocol) {
        self.networkWorker = networkWorker
        self.localStorageWorker = localStorageWorker
    }

    func getMissions() -> AnyPublisher<Missions?, CustomError> {
        let campaignId = localStorageWorker.getCampaignId()
        return networkWorker.getMissions(campaignId: campaignId)
    }
}
