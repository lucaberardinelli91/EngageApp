//
//  EngageApp
//  Created by Luca Berardinelli
//

import CoreTelephony
import Foundation
import UIKit

public enum Utility {
    public enum ApplicationHelper {
        public static func getCurrentVisbileController() -> BaseViewController? {
            return UIApplication.shared.visibleViewController as? BaseViewController
        }

        public static let keyWindow = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter { $0.isKeyWindow }.first

        static func resignFirstResponder() {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil
            )
        }

        static func block(view: UIView, time _: Double) {
            view.isUserInteractionEnabled = false
            DispatchQueue.main.async {
                view.isUserInteractionEnabled = true
            }
        }

        static var hasTopNotch: Bool {
            return UIApplication.shared.appWindow?.safeAreaInsets.top ?? 0 > 20
        }

        static var hasHomeIndicator: Bool {
            return UIApplication.shared.appWindow?.safeAreaInsets.bottom ?? 0 > 0
        }

        static func getVisibleViewController() -> BaseViewController? {
            return UIApplication.shared.visibleViewController as? BaseViewController
        }
    }
}
