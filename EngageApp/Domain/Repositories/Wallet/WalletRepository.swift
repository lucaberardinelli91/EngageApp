//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

class WalletRepository: WalletRepositoryProtocol {
    private var networkWorker: NetworkingDataSourceProtocol
    private var localStorageWorker: UserProtocol
    private var cancellables = Set<AnyCancellable>()

    init(networkWorker: NetworkingDataSourceProtocol, localStorageWorker: UserProtocol) {
        self.networkWorker = networkWorker
        self.localStorageWorker = localStorageWorker
    }

    func getWallet() -> AnyPublisher<WalletRoot?, CustomError> {
        let campaignId = localStorageWorker.getCampaignId()
        return networkWorker.getWallet(campaignId: campaignId)
    }
}
