//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol MissionsRepositoryProtocol {
    func getMissions() -> AnyPublisher<Missions?, CustomError>
}
