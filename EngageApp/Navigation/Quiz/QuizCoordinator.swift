//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public class QuizCoordinator: QuizCoordinatorProtocol {
    public var childrenCoordinators: [Coordinator] = []
    public var parentCoordinator: Coordinator?

    private let router: RouterProtocol = QuizCoordinatorRouter()

    public var childCoordinators = [Coordinator]()
    public var navigationController: UINavigationController

    public var mission: Mission

    var container: MainContainerProtocol

    public init(navigationController: UINavigationController, repositoryContainer: MainContainerProtocol, mission: Mission) {
        container = repositoryContainer
        self.navigationController = navigationController
        self.mission = mission

        self.navigationController.isHeroEnabled = true
        self.navigationController.heroNavigationAnimationType = .selectBy(presenting: .zoom, dismissing: .zoomOut)
    }

    public func start() {
        let playGameQuizVC: PlayGameQuizViewController = PlayGameQuizAssembler(container: container, mission: mission).resolve()

        playGameQuizVC.isHeroEnabled = true
        playGameQuizVC.playGameQuizCoordinator = self

        router.route(to: playGameQuizVC, from: navigationController, mode: .push, animated: false)
    }

    public func routeToHome(feedback: (Bool, String)) {
        let homeNavC = UINavigationController()
        let homeCoord = HomeCoordinator(navigationController: homeNavC, container: container)

        childrenCoordinators.append(homeCoord)
        router.route(to: homeNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)
        homeCoord.routeToHome(feedback: feedback)
    }
}

private class QuizCoordinatorRouter: RouterProtocol {}
