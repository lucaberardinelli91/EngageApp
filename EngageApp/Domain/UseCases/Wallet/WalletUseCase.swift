//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol GetWalletProtocol {
    func execute() -> AnyPublisher<WalletRoot?, CustomError>
}

enum WalletUseCase {
    class GetWallet: GetWalletProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var walletRepository: WalletRepositoryProtocol

        public init(walletRepository: WalletRepositoryProtocol) {
            self.walletRepository = walletRepository
        }

        func execute() -> AnyPublisher<WalletRoot?, CustomError> {
            walletRepository.getWallet()
        }
    }
}
