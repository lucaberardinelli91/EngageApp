//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public class RewardCoordinator: RewardCoordinatorProtocol {
    public var childrenCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
    public var parentCoordinator: Coordinator?

    private let router: RouterProtocol = RewardCoordinatorRouter()
    var container: MainContainerProtocol
    var coins: Int?

    public init(navigationController: UINavigationController, container: MainContainerProtocol, coins: Int) {
        self.navigationController = navigationController
        self.container = container
        self.coins = coins
    }

    public func start() {
        let rewardVC: RewardViewController = RewardAssembler(container: container, coins: coins ?? 0).resolve()
        rewardVC.rewardCoordinator = self
        rewardVC.hero.isEnabled = true

        navigationController.pushViewController(rewardVC, animated: false)
    }

    public func start(_ reward: Reward) {
        let rewardVC: RewardViewController = RewardAssembler(container: container, coins: coins ?? 0).resolve()
        rewardVC.rewardCoordinator = self
        rewardVC.reward = reward

        navigationController.pushViewController(rewardVC, animated: true)
    }

    public func routeToHome() {
        let homeNavC = UINavigationController()
        let homeCoord = HomeCoordinator(navigationController: homeNavC, container: container)

        childrenCoordinators.append(homeCoord)
        router.route(to: homeNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)
        homeCoord.start()
    }

    public func routeToMissions() {
        let missionsNavC = UINavigationController()
        let missionsCoord: MissionsCoordinatorProtocol = MissionsCoordinator(navigationController: missionsNavC, container: container, coins: coins ?? 0)

        childrenCoordinators.append(missionsCoord)

        router.route(to: missionsNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)

        missionsCoord.start()
    }

    public func routeToCatalog(_ coins: Int) {
        let catalogNavC = UINavigationController()
        let catalogCoord: CatalogCoordinatorProtocol = CatalogCoordinator(navigationController: catalogNavC, container: container, coins: coins, fromRedeem: true)

        self.coins = coins
        childrenCoordinators.append(catalogCoord)

        router.route(to: catalogNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)

        catalogCoord.start()
    }
}

private class RewardCoordinatorRouter: RouterProtocol {}
