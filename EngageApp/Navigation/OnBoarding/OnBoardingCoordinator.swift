//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public class OnBoardingCoordinator: OnBoardingCoordinatorProtocol {
    public var childrenCoordinators = [Coordinator]()
    public var navigationController: UINavigationController
    public var parentCoordinator: Coordinator?

    var container: MainContainerProtocol
    private let router: RouterProtocol = OnBoardingRouterCoordinator()

    public init(navigationController: UINavigationController, container: MainContainerProtocol) {
        self.navigationController = navigationController
        self.container = container
    }

    public func start() {
        let onBoardingVC: OnboardingViewController = OnboardingAssembler(container: container).resolve()
        onBoardingVC.onBoardingCoordinator = self
        onBoardingVC.hero.isEnabled = true

        navigationController.pushViewController(onBoardingVC, animated: true)
    }

    public func routeToWelcome(withFade _: Bool) {
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

private class OnBoardingRouterCoordinator: RouterProtocol {}
