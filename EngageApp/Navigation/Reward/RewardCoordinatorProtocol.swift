//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol RewardCoordinatorProtocol: Coordinator {
    func start(_ reward: Reward)
    func routeToHome()
    func routeToMissions()
    func routeToCatalog(_ coins: Int)
}
