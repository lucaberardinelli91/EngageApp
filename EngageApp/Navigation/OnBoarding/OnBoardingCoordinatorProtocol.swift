//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol OnBoardingCoordinatorProtocol: Coordinator {
    func routeToWelcome(withFade: Bool)
}
