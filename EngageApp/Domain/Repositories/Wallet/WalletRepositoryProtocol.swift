//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol WalletRepositoryProtocol {
    func getWallet() -> AnyPublisher<WalletRoot?, CustomError>
}
