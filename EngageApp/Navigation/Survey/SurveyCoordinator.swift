//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public class SurveyCoordinator: SurveyCoordinatorProtocol {
    public var childrenCoordinators: [Coordinator] = []
    public var parentCoordinator: Coordinator?

    private let router: RouterProtocol = SurveyCoordinatorRouter()

    public var childCoordinators = [Coordinator]()
    public var navigationController: UINavigationController

    public var surveyID: String
    public var points: Int

    var container: MainContainerProtocol

    public init(navigationController: UINavigationController, mainContainer: MainContainerProtocol, surveyID: String, points: Int) {
        container = mainContainer
        self.navigationController = navigationController
        self.surveyID = surveyID
        self.points = points

        self.navigationController.isHeroEnabled = true
        self.navigationController.heroNavigationAnimationType = .selectBy(presenting: .zoom, dismissing: .zoomOut)
    }

    public func start() {
        let surveyAnswersVC: SurveyAnswersViewController = SurveyAnswersAssembler(container: container, surveyID: surveyID).resolve()
        surveyAnswersVC.surveyAnswersCoordinator = self
        surveyAnswersVC.points = points

        router.route(to: surveyAnswersVC, from: navigationController, mode: .push, animated: true)
    }

    public func routeToHome(feedback: (Bool, String)) {
        let homeNavC = UINavigationController()
        let homeCoord = HomeCoordinator(navigationController: homeNavC, container: container)

        childrenCoordinators.append(homeCoord)
        router.route(to: homeNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)
        homeCoord.routeToHome(feedback: feedback)
    }
}

private class SurveyCoordinatorRouter: RouterProtocol {}
