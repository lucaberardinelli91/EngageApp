//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

// MARK: - WelcomeCoordinator

public class HomeCoordinator: HomeCoordinatorProtocol {
    public var childrenCoordinators = [Coordinator]()
    public var navigationController: UINavigationController
    public var parentCoordinator: Coordinator?
    public var coins: Int?

    /// Repositories container
    var container: MainContainerProtocol
    private let router: RouterProtocol = HomeRouterCoordinator()

    // MARK: - init

    public init(navigationController: UINavigationController, container: MainContainerProtocol) {
        self.navigationController = navigationController
        self.container = container
    }

    // MARK: - Start

    public func start() {
        routeToHome(feedback: (nil, ""))
    }

    public func routeToHome(feedback: (Bool?, String)) {
        let homeVC: HomeViewController = HomeAssembler(container: container).resolve()
        let notificationCoord: NotificationsCoordinatorProtocol = NotificationsCoordinator(navigationController: navigationController, container: container)
        let catalogCoord: CatalogCoordinatorProtocol = CatalogCoordinator(navigationController: navigationController, container: container, coins: coins ?? 0)
        let missionsCoord: MissionsCoordinatorProtocol = MissionsCoordinator(navigationController: navigationController, container: container, coins: coins ?? 0)

        /// Notifications controller
        childrenCoordinators.append(notificationCoord)
        homeVC.notificationsVC = notificationCoord.getNotificationsVC()

        /// Catalog controller
        childrenCoordinators.append(catalogCoord)
        let catalogVC = catalogCoord.getCatalogVC()
        catalogVC.homeCoordinator = self
        homeVC.catalogVC = catalogVC

        /// Missions controller
        childrenCoordinators.append(missionsCoord)
        let missionVC = missionsCoord.getMissionsVC()
        missionVC.homeCoordinator = self
        homeVC.missionsVC = missionVC

        /// Home controller
        homeVC.homeCoordinator = self
        navigationController.pushViewController(homeVC, animated: false)

        /// Check mission feedback
        guard let _ = feedback.0 else { return }
        homeVC.feedback = feedback
    }

    // MARK: - Profile

    public func routeToProfile(_ userInfo: UserInfo) {
        let userNavC = UINavigationController()
        let userCoord: ProfileCoordinatorProtocol = ProfileCoordinator(navigationController: userNavC, container: container)

        childrenCoordinators.append(userCoord)

        router.route(to: userNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)

        userCoord.start(userInfo)
    }

    // MARK: - Wallet

    public func routeToWallet(_ coins: Int) {
        let walletVC: WalletListViewController = WalletAssembler(container: container, coins: coins).resolve()
        let walletCoord = WalletCoordinator(navigationController: navigationController, container: container, coins: coins)

        walletVC.walletCoordinator = walletCoord
        childrenCoordinators.append(walletCoord)
        self.coins = coins

        navigationController.present(walletVC, animated: false, completion: nil)
    }

    // MARK: - Catalog

    public func routeToCatalog(_ coins: Int) {
        let catalogNavC = UINavigationController()
        let catalogCoord: CatalogCoordinatorProtocol = CatalogCoordinator(navigationController: catalogNavC, container: container, coins: coins)

        self.coins = coins
        childrenCoordinators.append(catalogCoord)

        router.route(to: catalogNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)

        catalogCoord.start()
    }

    public func routeToReward(_ reward: Reward, _ coins: Int) {
        let rewardNavC = UINavigationController()
        let rewardCoord: RewardCoordinatorProtocol = RewardCoordinator(navigationController: rewardNavC, container: container, coins: coins)

        rewardCoord.parentCoordinator = self
        childrenCoordinators.append(rewardCoord)

        router.route(to: rewardNavC, from: navigationController, mode: .present, modalPresentationStyle: .pageSheet)

        rewardCoord.start(reward)
    }

    // MARK: - Missions

    public func routeToMissions(_ coins: Int) {
        let missionsNavC = UINavigationController()
        let missionsCoord: MissionsCoordinatorProtocol = MissionsCoordinator(navigationController: missionsNavC, container: container, coins: coins)

        self.coins = coins
        childrenCoordinators.append(missionsCoord)

        router.route(to: missionsNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)

        missionsCoord.start()
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
}

private class HomeRouterCoordinator: RouterProtocol {}
