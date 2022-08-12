//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol CatalogRepositoryProtocol {
    func getCatalog() -> AnyPublisher<Catalog?, CustomError>
    func getRewardDetail(rewardId: String) -> AnyPublisher<Reward?, CustomError>
    func redeemReward(rewardId: String) -> AnyPublisher<EmptyResponse, CustomError>
}
