//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol SurveyCoordinatorProtocol: Coordinator {
    func routeToHome(feedback: (Bool, String))
}
