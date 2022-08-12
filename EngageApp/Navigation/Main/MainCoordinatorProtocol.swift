//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol MainCoordinatorProtocol: Coordinator {
    func routeToWelcome(withFade: Bool)
    func routeToOnboarding()
    func routeToHome()

    func processRoute(route: RouteBySplash)
}
