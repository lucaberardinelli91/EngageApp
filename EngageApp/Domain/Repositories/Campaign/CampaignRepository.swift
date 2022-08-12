//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

class CampaignRepository: CampaignRepositoryProtocol {
    private var networkWorker: NetworkingDataSourceProtocol
    private var localStorageWorker: UserProtocol
    private var cancellables = Set<AnyCancellable>()

    init(networkWorker: NetworkingDataSourceProtocol, localStorageWorker: UserProtocol) {
        self.networkWorker = networkWorker
        self.localStorageWorker = localStorageWorker
    }

    func getCampaign() -> AnyPublisher<CampaignRoot, CustomError> {
        return networkWorker.getCampaign()
    }

    func saveCampaignId(id: String) -> AnyPublisher<Bool, CustomError> {
        return Future { promise in
            self.localStorageWorker.saveCampaignId(id: id)
            promise(.success(true))
        }.eraseToAnyPublisher()
    }

    func getCampaignId() -> AnyPublisher<String, CustomError> {
        return Future { promise in
            let campaignId = self.localStorageWorker.getCampaignId()
            campaignId == "" ? promise(.failure(CustomError.genericError("Campaign Id not found"))) : promise(.success(campaignId))
        }.eraseToAnyPublisher()
    }
}
