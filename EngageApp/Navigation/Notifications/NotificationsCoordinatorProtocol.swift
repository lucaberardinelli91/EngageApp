//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol NotificationsCoordinatorProtocol: Coordinator {
    func getNotificationsVC() -> NotificationsViewController
    func routeToMissionList(_ coins: Int)
    func routeToCatalog(_ coins: Int)
    func routeToProfile()
}
