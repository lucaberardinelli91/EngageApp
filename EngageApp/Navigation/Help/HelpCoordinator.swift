//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public class HelpCoordinator: HelpCoordinatorProtocol {
    public var childrenCoordinators = [Coordinator]()
    public var navigationController: UINavigationController
    public var parentCoordinator: Coordinator?

    var container: MainContainerProtocol
    private let router: RouterProtocol = HelpRouterCoordinator()

    public init(navigationController: UINavigationController, container: MainContainerProtocol) {
        self.navigationController = navigationController
        self.container = container
    }

    public func start() {
        let helpVC: HelpViewController = HelpAssembler(container: container).resolve()
        helpVC.helpCoordinator = self
        helpVC.hero.isEnabled = true

        navigationController.pushViewController(helpVC, animated: true)
    }

    public func routeTowebView(url: URL) {
        let webViewVC: WebViewViewController = WebViewAssembler(container: container, url: url, title: nil).resolve()
        let webViewNavC = UINavigationController(rootViewController: webViewVC)

        router.route(to: webViewNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen, modalTransitionStyle: .coverVertical)
    }
}

private class HelpRouterCoordinator: RouterProtocol {}
