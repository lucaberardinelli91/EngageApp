//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public class MissionsCoordinator: MissionsCoordinatorProtocol {
    public var childrenCoordinators = [Coordinator]()
    public var navigationController: UINavigationController
    public var parentCoordinator: Coordinator?
    public var coins: Int?

    var container: MainContainerProtocol
    private let router: RouterProtocol = MissionsRouterCoordinator()

    public init(navigationController: UINavigationController, container: MainContainerProtocol, coins: Int) {
        self.navigationController = navigationController
        self.container = container
        self.coins = coins
    }

    public func start() {
        let missionsVC: MissionsListViewController = MissionsAssembler(container: container, coins: coins ?? 0).resolve()
        missionsVC.hero.isEnabled = true

        let launcherCoord: LauncherCoordinatorProtocol = LauncherCoordinator(navigationController: navigationController, container: container, coins: coins ?? 0)

        childrenCoordinators.append(launcherCoord)
        missionsVC.launcherCoordinator = launcherCoord

        missionsVC.missionsCoordinator = self
        navigationController.pushViewController(missionsVC, animated: true)
    }

    public func getMissionsVC() -> MissionsListViewController {
        let missionsVC: MissionsListViewController = MissionsAssembler(container: container, coins: coins ?? 0).resolve()
        missionsVC.missionsCoordinator = self
        missionsVC.hero.isEnabled = true

        return missionsVC
    }

    public func routeToMission(_ mission: Mission?) {
        guard let type = mission?.type else { return }

        if MissionType(type) == .info {
            guard let data = mission?.data, let id = data.id, let cta = data.cta, let title = data.title, let content = data.content, let points = data.points else { return }

            let launcherCoord = LauncherCoordinator(navigationController: navigationController, container: container, coins: coins ?? 0)
            childrenCoordinators.append(launcherCoord)

            launcherCoord.routeToLauncherInfo(LauncherInfo(id: id,
                                                           cta: cta,
                                                           title: title,
                                                           subTitle: title,
                                                           text: content,
                                                           coins: "\(points)"))
        } else {
            let launcherCoord = LauncherCoordinator(navigationController: navigationController, container: container, coins: coins ?? 0)
            let launcherVC: LauncherViewController = LauncherAssembler(container: container).resolve()

            launcherVC.launcherCoordinator = launcherCoord
            launcherVC.mission = mission

            childrenCoordinators.append(launcherCoord)

            navigationController.present(launcherVC, animated: true, completion: nil)
        }
    }

    public func routeToWallet(_ coins: Int) {
        let walletVC: WalletListViewController = WalletAssembler(container: container, coins: coins).resolve()
        let walletCoord = WalletCoordinator(navigationController: navigationController, container: container, coins: coins)
        walletVC.walletCoordinator = walletCoord
        walletVC.isInMission = true

        childrenCoordinators.append(walletCoord)

        navigationController.present(walletVC, animated: true, completion: nil)
    }

    public func routeToHome() {
        let homeNavC = UINavigationController()
        let homeCoord = HomeCoordinator(navigationController: homeNavC, container: container)

        childrenCoordinators.append(homeCoord)
        router.route(to: homeNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)
        homeCoord.start()
    }
}

private class MissionsRouterCoordinator: RouterProtocol {}
