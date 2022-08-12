//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol HomeCoordinatorProtocol: Coordinator {
    func routeToWallet(_ coins: Int)
    func routeToProfile(_ userInfo: UserInfo)
    func routeToMissions(_ coins: Int)
    func routeToMission(_ mission: Mission?)
    func routeToCatalog(_ coins: Int)
    func routeToReward(_ reward: Reward, _ coins: Int)
}
