//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

class CatalogRepository: CatalogRepositoryProtocol {
    private var networkWorker: NetworkingDataSourceProtocol
    private var localStorageWorker: UserProtocol
    private var cancellables = Set<AnyCancellable>()

    init(networkWorker: NetworkingDataSourceProtocol, localStorageWorker: UserProtocol) {
        self.networkWorker = networkWorker
        self.localStorageWorker = localStorageWorker
    }

    func getCatalog() -> AnyPublisher<Catalog?, CustomError> {
        let campaignId = localStorageWorker.getCampaignId()
        return networkWorker.getCatalog(campaignId: campaignId)
    }

    func getRewardDetail(rewardId: String) -> AnyPublisher<Reward?, CustomError> {
        let campaignId = localStorageWorker.getCampaignId()
        return networkWorker.getRewardDetail(campaignId: campaignId, rewardId: rewardId)
    }

    func redeemReward(rewardId: String) -> AnyPublisher<EmptyResponse, CustomError> {
        let campaignId = localStorageWorker.getCampaignId()
        return networkWorker.redeemReward(campaignId: campaignId, rewardId: rewardId)
    }
}
