//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

class InstantwinRepository: InstantwinRepositoryProtocol {
    private var networkWorker: NetworkingDataSourceProtocol
    private var localStorageWorker: UserProtocol
    private var cancellables = Set<AnyCancellable>()

    init(networkWorker: NetworkingDataSourceProtocol, localStorageWorker: UserProtocol) {
        self.networkWorker = networkWorker
        self.localStorageWorker = localStorageWorker
    }

    func instantWinPlay(instantwinRandomId: String) -> AnyPublisher<InstantWin, CustomError> {
        let campaignId = localStorageWorker.getCampaignId()
        return networkWorker.instantWinPlay(campaignId: campaignId, instantwinRandomId: instantwinRandomId)
    }
}
