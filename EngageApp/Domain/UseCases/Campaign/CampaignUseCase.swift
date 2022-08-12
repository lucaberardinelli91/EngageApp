//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol GetCampaignProtocol {
    func execute() -> AnyPublisher<CampaignRoot, CustomError>
}

public protocol SaveCampaignIdProtocol {
    func execute(id: String) -> AnyPublisher<Bool, CustomError>
}

public protocol GetCampaignIdProtocol {
    func execute() -> AnyPublisher<String, CustomError>
}

enum CampaignUseCase {
    class GetCampaign: GetCampaignProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var campaignRepository: CampaignRepositoryProtocol

        public init(campaignRepository: CampaignRepositoryProtocol) {
            self.campaignRepository = campaignRepository
        }

        func execute() -> AnyPublisher<CampaignRoot, CustomError> {
            campaignRepository.getCampaign()
        }
    }

    class SaveCampaignId: SaveCampaignIdProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var campaignRepository: CampaignRepositoryProtocol

        public init(campaignRepository: CampaignRepositoryProtocol) {
            self.campaignRepository = campaignRepository
        }

        func execute(id: String) -> AnyPublisher<Bool, CustomError> {
            campaignRepository.saveCampaignId(id: id)
        }
    }

    class GetCampaignId: GetCampaignIdProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var campaignRepository: CampaignRepositoryProtocol

        public init(campaignRepository: CampaignRepositoryProtocol) {
            self.campaignRepository = campaignRepository
        }

        func execute() -> AnyPublisher<String, CustomError> {
            campaignRepository.getCampaignId()
        }
    }
}
