//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

class InformationRepository: InformationRepositoryProtocol {
    private var networkWorker: NetworkingDataSourceProtocol
    private var localStorageWorker: UserProtocol
    private var cancellables = Set<AnyCancellable>()

    init(networkWorker: NetworkingDataSourceProtocol, localStorageWorker: UserProtocol) {
        self.networkWorker = networkWorker
        self.localStorageWorker = localStorageWorker
    }

    func markInformationAsRead(infoId: String) -> AnyPublisher<EmptyResponse, CustomError> {
        let campaignId = localStorageWorker.getCampaignId()
        return networkWorker.markInformationAsRead(campaignId: campaignId, infoId: infoId)
    }
}
