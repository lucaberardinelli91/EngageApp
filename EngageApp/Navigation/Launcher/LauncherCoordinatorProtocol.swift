//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol LauncherCoordinatorProtocol: Coordinator {
    func start(mission: Mission)
    func routeToQuiz(mission: Mission)
    func routeToSurvey(surveyId: String, points: Int)
    func routeToFancam(mission: Mission)
    func routeToLauncherInfo(_ info: LauncherInfo?)
    func routeToHome(feedback: (Bool, String))
    func routeToMissions()
    func getLauncherVC() -> LauncherViewController
}
