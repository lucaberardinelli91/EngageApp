//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public class FanCamCoordinator: FanCamCoordinatorProtocol {
    public var childrenCoordinators: [Coordinator] = []
    public var parentCoordinator: Coordinator?
    public var navigationController: UINavigationController
    public var mission: Mission

    private let router: RouterProtocol = FanCamCoordinatorRouter()

    var container: MainContainerProtocol

    public init(navigationController: UINavigationController, mainContainer: MainContainerProtocol, mission: Mission) {
        container = mainContainer
        self.navigationController = navigationController
        self.mission = mission
    }

    public func start() {
        let fanCamVC: FanCamViewController = FanCamAssembler(container: container, mission: mission).resolve()
        fanCamVC.fanCamCoordinator = self

        navigationController.pushViewController(fanCamVC, animated: false)
    }

    public func routeToHome(feedback: (Bool, String)) {
        let homeNavC = UINavigationController()
        let homeCoord = HomeCoordinator(navigationController: homeNavC, container: container)

        childrenCoordinators.append(homeCoord)
        router.route(to: homeNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)
        homeCoord.routeToHome(feedback: feedback)
    }
}

private class FanCamCoordinatorRouter: RouterProtocol {}
