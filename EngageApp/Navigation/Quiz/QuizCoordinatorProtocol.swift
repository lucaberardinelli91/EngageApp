//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol QuizCoordinatorProtocol: Coordinator {
    func routeToHome(feedback: (Bool, String))
}
