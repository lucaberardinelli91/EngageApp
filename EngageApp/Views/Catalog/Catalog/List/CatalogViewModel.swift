//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import UIKit

public protocol CatalogViewModelProtocol {
    func getCatalog()
}

public class CatalogViewModel: BaseViewModel, CatalogViewModelProtocol {
    @Published var getCatalogState: LoadingState<[Reward], CustomError> = .idle
    private let getCatalogUseCase: GetCatalogProtocol
    public var fromRedeem: Bool = false
    public var coins: Int?

    public init(getCatalogUseCase: GetCatalogProtocol, coins: Int, fromRedeem: Bool) {
        self.getCatalogUseCase = getCatalogUseCase
        self.fromRedeem = fromRedeem
        self.coins = coins
    }

    public func getCatalog() {
        // MOCK API
        getCatalogState = .success(Reward.getRewards())
        
//        getCatalogState = .loading
//
//        getCatalogUseCase.execute()
//            .receive(on: RunLoop.main)
//            .sink { completion in
//                guard case let .failure(error) = completion else { return }
//                self.getCatalogState = .failure(error)
//            } receiveValue: { [self] catalog in
//                guard let rewards = catalog?.rewards else { return }
//                getCatalogState = .success(rewards)
//            }.store(in: &cancellables)
    }
}
