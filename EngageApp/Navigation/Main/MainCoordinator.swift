//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import Hero
import UIKit

public class MainCoordinator: MainCoordinatorProtocol {
    private let router: RouterProtocol = MainRouter()

    public var childrenCoordinators = [Coordinator]()
    public var navigationController: UINavigationController
    public var parentCoordinator: Coordinator?

    var container: MainContainerProtocol

    public init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        container = Configurator.mainContainer

        self.navigationController.isHeroEnabled = true
        self.navigationController.heroNavigationAnimationType = .selectBy(presenting: .zoom, dismissing: .zoomOut)
    }

    public func start() {
        let splashVC: SplashViewController = SplashAssembler(container: container).resolve()
        splashVC.mainCoordinator = self

        navigationController.pushViewController(splashVC, animated: false)
    }

    public func routeToOnboarding() {
        let onBoardingNavC = UINavigationController()
        onBoardingNavC.hero.isEnabled = true
        onBoardingNavC.heroModalAnimationType = .zoom

        let onBoardingCoord = OnBoardingCoordinator(navigationController: onBoardingNavC, container: container)

        childrenCoordinators.append(onBoardingCoord)

        router.route(to: onBoardingNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen, modalTransitionStyle: .crossDissolve)

        onBoardingCoord.start()
    }

    public func routeToWelcome(withFade: Bool) {
        DispatchQueue.main.async {
            self.navigationController.dismiss(animated: false) {
                let welcomeNavC = UINavigationController()
                welcomeNavC.hero.isEnabled = true

                let welcomeCoord = WelcomeCoordinator(navigationController: welcomeNavC, container: self.container)

                self.childrenCoordinators.append(welcomeCoord)

                self.router.route(to: welcomeNavC, from: self.navigationController, mode: .present, modalPresentationStyle: .fullScreen, modalTransitionStyle: withFade ? .crossDissolve : .coverVertical)

                welcomeCoord.start()
            }
        }
    }

    public func routeToHome() {
        let homeNavC = UINavigationController()
        let homeCoord = HomeCoordinator(navigationController: homeNavC, container: container)

        childrenCoordinators.append(homeCoord)
        router.route(to: homeNavC, from: navigationController, mode: .present, modalPresentationStyle: .overFullScreen)
        homeCoord.start()
    }

    public func processRoute(route: RouteBySplash) {
        switch route {
        case .onBoarding: routeToOnboarding()
        case .welcome: routeToWelcome(withFade: false)
        case .home: routeToHome()
        }
    }
}

private class MainRouter: RouterProtocol {}
