//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public extension UIStackView {
    private func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { view in
            removeFully(view: view)
        }
    }
}
