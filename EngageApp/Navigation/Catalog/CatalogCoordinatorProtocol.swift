//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol CatalogCoordinatorProtocol: Coordinator {
    func routeToMissions()
    func getCatalogVC() -> CatalogViewController
    func routeToHome()
    func routeToWallet(_ coins: Int)
    func routeToReward(_ reward: Reward)
}
