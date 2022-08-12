//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol InstantwinRepositoryProtocol {
    func instantWinPlay(instantwinRandomId: String) -> AnyPublisher<InstantWin, CustomError>
}
