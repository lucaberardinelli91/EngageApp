//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import UIKit

public protocol RewardViewModelProtocol {
    func redeemReward(rewardId: String)
}

public class RewardViewModel: BaseViewModel, RewardViewModelProtocol {
    @Published var redemRewardState: LoadingState<Void, CustomError> = .idle
    private let redemRewardUseCase: RedeemRewardProtocol

    public let coins: Int?

    public init(redemRewardUseCase: RedeemRewardProtocol, coins: Int) {
        self.redemRewardUseCase = redemRewardUseCase
        self.coins = coins
    }

    public func redeemReward(rewardId: String) {
        redemRewardState = .loading

        redemRewardUseCase.execute(rewardId: rewardId)
            .receive(on: RunLoop.main)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.redemRewardState = .failure(error)
            } receiveValue: { [self] _ in
                redemRewardState = .success(())
            }.store(in: &cancellables)
    }
}
