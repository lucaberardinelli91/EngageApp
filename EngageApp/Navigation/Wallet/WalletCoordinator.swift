//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public class WalletCoordinator: WalletCoordinatorProtocol {
    public var childrenCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
    public var parentCoordinator: Coordinator?
    private var coins: Int?

    var container: MainContainerProtocol
    private let router: RouterProtocol = WalletCoordinatorRouter()

    public init(navigationController: UINavigationController, container: MainContainerProtocol, coins: Int) {
        self.navigationController = navigationController
        self.container = container
        self.coins = coins
    }

    public func start() {
        let walletVC: WalletListViewController = WalletAssembler(container: container, coins: coins ?? 0).resolve()
        walletVC.walletCoordinator = self
        walletVC.hero.isEnabled = true

        navigationController.pushViewController(walletVC, animated: false)
    }

    public func routeToMissions() {
        let missionsNavC = UINavigationController()
        let missionsCoord: MissionsCoordinatorProtocol = MissionsCoordinator(navigationController: missionsNavC, container: container, coins: coins ?? 0)

        childrenCoordinators.append(missionsCoord)

        router.route(to: missionsNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)

        missionsCoord.start()
    }
}

private class WalletCoordinatorRouter: RouterProtocol {}
