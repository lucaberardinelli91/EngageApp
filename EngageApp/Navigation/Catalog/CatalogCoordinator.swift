//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public class CatalogCoordinator: CatalogCoordinatorProtocol {
    public var childrenCoordinators = [Coordinator]()
    public var navigationController: UINavigationController
    public var parentCoordinator: Coordinator?

    private let router: RouterProtocol = CatalogRouterCoordinator()
    public var container: MainContainerProtocol
    public var fromRedeem: Bool = false
    public var coins: Int?

    public init(navigationController: UINavigationController, container: MainContainerProtocol, coins: Int, fromRedeem: Bool = false) {
        self.navigationController = navigationController
        self.container = container
        self.fromRedeem = fromRedeem
        self.coins = coins
    }

    public func start() {
        let catalogVC: CatalogViewController = CatalogAssembler(container: container, coins: coins ?? 0, fromRedeem: fromRedeem).resolve()
        catalogVC.catalogCoordinator = self
        catalogVC.hero.isEnabled = true

        navigationController.pushViewController(catalogVC, animated: true)
    }

    public func routeToMissions() {
        let missionsNavC = UINavigationController()
        let missionsCoord: MissionsCoordinatorProtocol = MissionsCoordinator(navigationController: missionsNavC, container: container, coins: coins ?? 0)

        childrenCoordinators.append(missionsCoord)

        router.route(to: missionsNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)

        missionsCoord.start()
    }

    public func getCatalogVC() -> CatalogViewController {
        let catalogVC: CatalogViewController = CatalogAssembler(container: container, coins: coins ?? 0).resolve()
        catalogVC.catalogCoordinator = self
        catalogVC.hero.isEnabled = true

        return catalogVC
    }

    public func routeToHome() {
        let homeNavC = UINavigationController()
        let homeCoord = HomeCoordinator(navigationController: homeNavC, container: container)

        childrenCoordinators.append(homeCoord)
        router.route(to: homeNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)
        homeCoord.start()
    }

    public func routeToWallet(_ coins: Int) {
        let walletNavC = UINavigationController()
        let walletVC: WalletListViewController = WalletAssembler(container: container, coins: coins).resolve()

        let walletCoord = WalletCoordinator(navigationController: navigationController, container: container, coins: coins)
        walletVC.walletCoordinator = walletCoord
        self.coins = coins

        childrenCoordinators.append(walletCoord)

        navigationController.present(walletVC, animated: true, completion: nil)
    }

    public func routeToReward(_ reward: Reward) {
        let rewardNavC = UINavigationController()
        let rewardCoord: RewardCoordinatorProtocol = RewardCoordinator(navigationController: rewardNavC, container: container, coins: coins ?? 0)

        rewardCoord.parentCoordinator = self
        childrenCoordinators.append(rewardCoord)

        router.route(to: rewardNavC, from: navigationController, mode: .present, modalPresentationStyle: .pageSheet)

        rewardCoord.start(reward)
    }
}

private class CatalogRouterCoordinator: RouterProtocol {}
