//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public extension Double {
    func formatDecimal(_ decimal: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.locale = .current
        formatter.maximumFractionDigits = decimal
        return formatter.string(from: self as NSNumber)!
    }
}
