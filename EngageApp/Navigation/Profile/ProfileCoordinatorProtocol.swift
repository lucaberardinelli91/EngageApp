//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol ProfileCoordinatorProtocol: Coordinator {
    func start(_ userInfo: UserInfo)
    func routeToHelp()
    func routeTowebView(url: URL)
    func routeToWelcome()
}
