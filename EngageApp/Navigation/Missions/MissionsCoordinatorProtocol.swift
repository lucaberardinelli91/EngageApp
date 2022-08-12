//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol MissionsCoordinatorProtocol: Coordinator {
    func routeToMission(_ mission: Mission?)
    func getMissionsVC() -> MissionsListViewController
    func routeToWallet(_ coins: Int)
    func routeToHome()
}
