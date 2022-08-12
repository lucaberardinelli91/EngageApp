//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

// MARK: - LauncherAssembler

public class RewardAssembler: RewardAssemblerInjector {
    var container: MainContainerProtocol
    var coins: Int?

    public init(container: MainContainerProtocol, coins: Int) {
        self.container = container
        self.coins = coins
    }
}

// MARK: - RewardAssemblerInjector

public protocol RewardAssemblerInjector {
    func resolve() -> RewardViewController

    func resolve() -> RewardViewModel
}

public extension RewardAssembler {
    func resolve() -> RewardViewController {
        return RewardViewController(viewModel: resolve())
    }

    func resolve() -> RewardViewModel {
        return RewardViewModel(redemRewardUseCase: container.redeemReward, coins: coins ?? 0)
    }
}
