//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import Foundation
import UIKit

public class RewardViewController: BasePackedViewController<RewardView, RewardViewModel> {
    private var refreshControl = UIRefreshControl()
    public weak var rewardCoordinator: RewardCoordinatorProtocol?

    public var reward: Reward? { didSet { didSetReward() }}

    override public init(viewModel: RewardViewModel) {
        super.init(viewModel: viewModel)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        setCoins()
        configureBinds()
        setInteractions()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    private func didSetReward() {
        guard let reward = reward else { return }

        _view.reward = reward
    }

    private func setInteractions() {
        interaction(_view.closeTap) {
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }

        interaction(_view.earnMoreCoinsTap) {
            self.rewardCoordinator?.routeToMissions()
        }

        interaction(_view.swipeTap) {
            guard let rewardId = self.reward?.id else { return }
            self.viewModel.redeemReward(rewardId: rewardId)
        }
    }

    private func setCoins() {
        _view.coins = viewModel.coins
    }
}

extension RewardViewController {
    private func configureBinds() {
        handle(viewModel.$redemRewardState, success: { [self] _ in
            self.rewardCoordinator?.parentCoordinator is HomeCoordinator ?
                rewardCoordinator?.routeToHome() : rewardCoordinator?.routeToCatalog((viewModel.coins ?? 0) - (reward?.cost ?? 0))
        }, failure: { error in
            print("[ERROR] reward redeem: \(error)")
        })
    }
}
