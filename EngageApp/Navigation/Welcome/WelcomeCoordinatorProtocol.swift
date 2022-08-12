//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol WelcomeCoordinatorProtocol: Coordinator {
    func routeToHome()
    func routeTowebView(url: URL)
}
