//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol CampaignRepositoryProtocol {
    func getCampaign() -> AnyPublisher<CampaignRoot, CustomError>
    func saveCampaignId(id: String) -> AnyPublisher<Bool, CustomError>
    func getCampaignId() -> AnyPublisher<String, CustomError>
}
