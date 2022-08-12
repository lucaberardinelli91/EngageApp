//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit
public class LauncherCoordinator: LauncherCoordinatorProtocol {
    public var childrenCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
    public var parentCoordinator: Coordinator?

    private let router: RouterProtocol = LauncherCoordinatorRouter()
    var container: MainContainerProtocol

    var mission: Mission?
    var coins: Int?

    public init(navigationController: UINavigationController, container: MainContainerProtocol, coins: Int) {
        self.navigationController = navigationController
        self.container = container
        self.coins = coins
    }

    public func start() {}

    public func start(mission: Mission) {
        let laucherVC: LauncherViewController = LauncherAssembler(container: container).resolve()
        laucherVC.launcherCoordinator = self
        laucherVC.hero.isEnabled = true
        laucherVC.mission = mission

        self.mission = mission

        navigationController.pushViewController(laucherVC, animated: false)
    }

    public func getLauncherVC() -> LauncherViewController {
        let launcherVC: LauncherViewController = LauncherAssembler(container: container).resolve()
        launcherVC.launcherCoordinator = self
        launcherVC.hero.isEnabled = true

        return launcherVC
    }

    public func routeToMissions() {
        let missionsNavC = UINavigationController()
        let missionsCoord: MissionsCoordinatorProtocol = MissionsCoordinator(navigationController: missionsNavC, container: container, coins: coins ?? 0)

        childrenCoordinators.append(missionsCoord)

        router.route(to: missionsNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)

        missionsCoord.start()
    }

    public func routeToQuiz(mission: Mission) {
        let quizNavC = UINavigationController()
        quizNavC.hero.isEnabled = true
        quizNavC.heroModalAnimationType = .zoom

        let quizCoord = QuizCoordinator(navigationController: quizNavC, repositoryContainer: container, mission: mission)

        childrenCoordinators.removeAll()
        childrenCoordinators.append(quizCoord)

        router.route(to: quizNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)

        quizCoord.start()
    }

    public func routeToSurvey(surveyId: String, points: Int) {
        let surveyNavC = UINavigationController()
        let surveyCoord = SurveyCoordinator(navigationController: surveyNavC, mainContainer: container, surveyID: surveyId, points: points)

        childrenCoordinators.removeAll()
        childrenCoordinators.append(surveyCoord)

        router.route(to: surveyNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen, modalTransitionStyle: .coverVertical)

        surveyCoord.start()
    }

    public func routeToFancam(mission: Mission) {
        let fanCamNavC = UINavigationController()
        let fanCamCoord: FanCamCoordinatorProtocol = FanCamCoordinator(navigationController: fanCamNavC, mainContainer: container, mission: mission)

        childrenCoordinators.removeAll()
        childrenCoordinators.append(fanCamCoord)

        router.route(to: fanCamNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)

        fanCamCoord.start()
    }

    public func routeToLauncherInfo(_ info: LauncherInfo?) {
        let launcherInfoVC: ReadInfoViewController = ReadInfoAssembler(container: container).resolve()
        launcherInfoVC.launcherCoordinator = self

        launcherInfoVC.info = info

        navigationController.pushViewController(launcherInfoVC, animated: true)
    }

    public func routeToHome(feedback: (Bool, String)) {
        let homeNavC = UINavigationController()
        let homeCoord = HomeCoordinator(navigationController: homeNavC, container: container)

        childrenCoordinators.append(homeCoord)
        router.route(to: homeNavC, from: navigationController, mode: .present, modalPresentationStyle: .fullScreen)
        homeCoord.routeToHome(feedback: feedback)
    }
}

private class LauncherCoordinatorRouter: RouterProtocol {}
