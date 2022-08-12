//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public class WelcomeCoordinator: WelcomeCoordinatorProtocol {
    public var childrenCoordinators = [Coordinator]()
    public var navigationController: UINavigationController
    public var parentCoordinator: Coordinator?

    var container: MainContainerProtocol

    private let router: RouterProtocol = WelcomeRouterCoordinator()

    public init(navigationController: UINavigationController, container: MainContainerProtocol) {
        self.navigationController = navigationController
        self.container = container
    }

    public func start() {
        let welcomeVC: WelcomeViewController = WelcomeAssembler(container: container).resolve()
        welcomeVC.isHeroEnabled = true
        welcomeVC.heroModalAnimationType = .zoom
        welcomeVC.welcomeCoordinator = self

        navigationController.heroNavigationAnimationType = .selectBy(presenting: .zoom, dismissing: .zoomOut)
        navigationController.pushViewController(welcomeVC, animated: false)
    }

    public func routeTowebView(url: URL) {
        let webViewVC: WebViewViewController = WebViewAssembler(container: container, url: url, title: nil).resolve()
        let webViewNavC = UINavigationController(rootViewController: webViewVC)

        router.route(to: webViewNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen, modalTransitionStyle: .coverVertical)
    }

    public func routeToHome() {
        let homeNavC = UINavigationController()
        let homeCoord = HomeCoordinator(navigationController: homeNavC, container: container)

        childrenCoordinators.append(homeCoord)
        router.route(to: homeNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)
        homeCoord.start()
    }
}

private class WelcomeRouterCoordinator: RouterProtocol {}
