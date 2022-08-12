//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public extension UIApplication {
    var visibleViewController: UIViewController? {
        return getVisibleViewController(nil)
    }

    private func getVisibleViewController(_ rootViewController: UIViewController?) -> UIViewController? {
        let rootVC = rootViewController ?? UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController

        if rootVC!.isKind(of: UINavigationController.self) {
            let navigationController = rootVC as! UINavigationController
            return getVisibleViewController(navigationController.viewControllers.last!)
        }

        if rootVC!.isKind(of: UITabBarController.self) {
            let tabBarController = rootVC as! UITabBarController
            return getVisibleViewController(tabBarController.selectedViewController!)
        }

        if let presentedVC = rootVC?.presentedViewController {
            return getVisibleViewController(presentedVC)
        }

        return rootVC
    }

    var appWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .first // We are working only with one window iPhone apps
                .map { $0 as? UIWindowScene }
                .map { $0?.windows.last } ?? UIApplication.shared.delegate?.window ?? nil
        }

        return UIApplication.shared.delegate?.window ?? nil
    }
}
