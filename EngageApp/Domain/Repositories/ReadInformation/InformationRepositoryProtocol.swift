//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol InformationRepositoryProtocol {
    func markInformationAsRead(infoId: String) -> AnyPublisher<EmptyResponse, CustomError>
}
