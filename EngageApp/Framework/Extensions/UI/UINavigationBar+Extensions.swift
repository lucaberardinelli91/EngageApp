//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public extension UINavigationBar {
    func _setGradientBackground(
        colors: [UIColor],
        startPoint: UINavigationBarGradientView.Point = .topLeft,
        endPoint: UINavigationBarGradientView.Point = .bottomLeft,
        locations: [NSNumber] = [0, 1]
    ) {
        guard let backgroundView = value(forKey: "backgroundView") as? UIView else { return }
        guard let gradientView = backgroundView.subviews.first(where: { $0 is UINavigationBarGradientView }) as? UINavigationBarGradientView else {
            let gradientView = UINavigationBarGradientView(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint,
                locations: locations
            )
            backgroundView.addSubview(gradientView)
            gradientView.setupConstraints()
            return
        }
        gradientView.set(colors: colors, startPoint: startPoint, endPoint: endPoint, locations: locations)
    }
}
