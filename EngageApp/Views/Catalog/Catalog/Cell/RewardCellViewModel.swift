//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol RewardCellViewModelProtocol {
    func getInfo()
}

public class RewardCellViewModel: RewardCellViewModelProtocol {
    private var reward: Reward

    @Published var rewardCollectionViewCellState: LoadingState<Reward, CustomError> = .idle

    public init(configurator: Reward) {
        reward = configurator
    }

    public func getInfo() {
        rewardCollectionViewCellState = .success(reward)
    }
}
