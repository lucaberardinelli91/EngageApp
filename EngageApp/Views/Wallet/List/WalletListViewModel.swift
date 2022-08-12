//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import UIKit

public protocol WalletListViewModelProtocol {
    func getWallet()
}

public class WalletListViewModel: BaseViewModel, WalletListViewModelProtocol {
    @Published var getWalletState: LoadingState<[WalletTransaction], CustomError> = .idle
    private let getWalletUseCase: GetWalletProtocol
    public let coins: Int?

    public init(getWalletUseCase: GetWalletProtocol, coins: Int) {
        self.getWalletUseCase = getWalletUseCase
        self.coins = coins
    }

    public func getWallet() {
        // MOCK API
        getWalletState = .success(WalletTransaction.getTransactions())
        
//        getWalletState = .loading
//
//        getWalletUseCase.execute()
//            .receive(on: RunLoop.main)
//            .sink { completion in
//                guard case let .failure(error) = completion else { return }
//                self.getWalletState = .failure(error)
//            } receiveValue: { [self] wallet in
//                guard let transactions = wallet?.transactions else { return }
//                getWalletState = .success(transactions)
//            }.store(in: &cancellables)
    }
}
