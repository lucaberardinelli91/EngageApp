//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public extension Array {
    /// Return the element if exist at `index`, else return nil
    func getElement(at index: Int) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }

    func unique<T: Hashable>(by: (Element) -> (T)) -> [Element] {
        var set = Set<T>() /// The unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() /// Keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(by(value)) {
                set.insert(by(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }
}
