//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public extension UICollectionView {
    func register(_ type: AnyClass) {
        register(type.self, forCellWithReuseIdentifier: type.description())
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, for: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.description(), for: `for`) as! T
    }
}

public extension IndexPath {
    func isLastItem(at collectionView: UICollectionView) -> Bool {
        return item == (collectionView.numberOfItems(inSection: 0) - 1)
    }
}
