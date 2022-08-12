//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol GetCatalogProtocol {
    func execute() -> AnyPublisher<Catalog?, CustomError>
}

public protocol GetRewardDetailProtocol {
    func execute(rewardId: String) -> AnyPublisher<Reward?, CustomError>
}

public protocol RedeemRewardProtocol {
    func execute(rewardId: String) -> AnyPublisher<EmptyResponse, CustomError>
}

enum CatalogUseCase {
    class GetCatalog: GetCatalogProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var catalogRepository: CatalogRepositoryProtocol

        public init(catalogRepository: CatalogRepositoryProtocol) {
            self.catalogRepository = catalogRepository
        }

        func execute() -> AnyPublisher<Catalog?, CustomError> {
            catalogRepository.getCatalog()
        }
    }

    class GetRewardDetail: GetRewardDetailProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var catalogRepository: CatalogRepositoryProtocol

        public init(catalogRepository: CatalogRepositoryProtocol) {
            self.catalogRepository = catalogRepository
        }

        func execute(rewardId: String) -> AnyPublisher<Reward?, CustomError> {
            catalogRepository.getRewardDetail(rewardId: rewardId)
        }
    }

    class RedeemReward: RedeemRewardProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var catalogRepository: CatalogRepositoryProtocol

        public init(catalogRepository: CatalogRepositoryProtocol) {
            self.catalogRepository = catalogRepository
        }

        func execute(rewardId: String) -> AnyPublisher<EmptyResponse, CustomError> {
            catalogRepository.redeemReward(rewardId: rewardId)
        }
    }
}
