//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public class NotificationsCoordinator: NotificationsCoordinatorProtocol {
    public var childrenCoordinators = [Coordinator]()
    public var navigationController: UINavigationController
    public var parentCoordinator: Coordinator?

    private let router: RouterProtocol = NotificationsRouterCoordinator()
    var container: MainContainerProtocol

    public init(navigationController: UINavigationController, container: MainContainerProtocol) {
        self.navigationController = navigationController
        self.container = container
    }

    public func start() {
        let notificationsVC: NotificationsViewController = NotificationsAssembler(container: container).resolve()
        notificationsVC.notificationsCoordinator = self
        notificationsVC.hero.isEnabled = true

        navigationController.pushViewController(notificationsVC, animated: true)
    }

    public func getNotificationsVC() -> NotificationsViewController {
        let notificationsVC: NotificationsViewController = NotificationsAssembler(container: container).resolve()
        notificationsVC.notificationsCoordinator = self
        notificationsVC.hero.isEnabled = true

        return notificationsVC
    }

    public func routeToMissionList(_ coins: Int) {
        let missionsNavC = UINavigationController()
        let missionsCoord: MissionsCoordinatorProtocol = MissionsCoordinator(navigationController: missionsNavC, container: container, coins: coins)

        childrenCoordinators.append(missionsCoord)

        router.route(to: missionsNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)

        missionsCoord.start()
    }

    public func routeToCatalog(_ coins: Int) {
        let catalogNavC = UINavigationController()
        let catalogCoord: CatalogCoordinatorProtocol = CatalogCoordinator(navigationController: catalogNavC, container: container, coins: coins)

        childrenCoordinators.append(catalogCoord)

        router.route(to: catalogNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)

        catalogCoord.start()
    }

    public func routeToProfile() {
        let userNavC = UINavigationController()
        let userCoord: ProfileCoordinatorProtocol = ProfileCoordinator(navigationController: userNavC, container: container)

        childrenCoordinators.append(userCoord)

        router.route(to: userNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)

        userCoord.start()
    }
}

private class NotificationsRouterCoordinator: RouterProtocol {}
