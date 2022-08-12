//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

// MARK: - ProfileCoordinator

public class ProfileCoordinator: ProfileCoordinatorProtocol {
    public var childrenCoordinators = [Coordinator]()
    public var navigationController: UINavigationController
    public var parentCoordinator: Coordinator?

    /// Repositories container
    var container: MainContainerProtocol
    private let router: RouterProtocol = ProfileRouterCoordinator()

    // MARK: - init

    public init(navigationController: UINavigationController, container: MainContainerProtocol) {
        self.navigationController = navigationController
        self.container = container
    }

    // MARK: - Start

    public func start() {
        let profileVC: ProfileViewController = ProfileAssembler(container: container).resolve()
        profileVC.profileCoordinator = self
        profileVC.hero.isEnabled = true

        navigationController.pushViewController(profileVC, animated: true)
    }

    public func start(_ userInfo: UserInfo) {
        let profileVC: ProfileViewController = ProfileAssembler(container: container).resolve()
        profileVC.profileCoordinator = self
        profileVC.userInfo = userInfo

        navigationController.pushViewController(profileVC, animated: true)
    }

    public func routeToHelp() {
        let helpNavC = UINavigationController()
        let helpCoord: HelpCoordinatorProtocol = HelpCoordinator(navigationController: helpNavC, container: container)

        childrenCoordinators.append(helpCoord)

        router.route(to: helpNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)

        helpCoord.start()
    }

    public func routeTowebView(url: URL) {
        let webViewVC: WebViewViewController = WebViewAssembler(container: container, url: url, title: nil).resolve()
        let webViewNavC = UINavigationController(rootViewController: webViewVC)

        router.route(to: webViewNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen, modalTransitionStyle: .coverVertical)
    }

    public func routeToWelcome() {
        DispatchQueue.main.async {
            let welcomeNavC = UINavigationController()
            welcomeNavC.hero.isEnabled = true
            welcomeNavC.heroModalAnimationType = .zoom

            let welcomeCoord = WelcomeCoordinator(navigationController: welcomeNavC, container: self.container)

            self.childrenCoordinators.append(welcomeCoord)

            self.router.route(to: welcomeNavC, from: self.navigationController, mode: .present, modalPresentationStyle: .fullScreen)

            welcomeCoord.start()
        }
    }
}

// MARK: - ProfileRouterCoordinator

private class ProfileRouterCoordinator: RouterProtocol {}
