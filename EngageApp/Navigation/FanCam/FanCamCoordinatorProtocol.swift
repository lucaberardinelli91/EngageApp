//
//  EngageApp
//  Created by Luca Berardinelli
//
import Foundation

public protocol FanCamCoordinatorProtocol: Coordinator {
    func routeToHome(feedback: (Bool, String))
}
