//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

// MARK: - Coordinator

public protocol Coordinator: AnyObject {
    var childrenCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }

    func start()
    func end()
    func destroyChildren(completion: (() -> Void)?)
}

public extension Coordinator {
    /// The func `end()` dismiss all coordinator, included that of the `parentCoordinator`, if exist.
    func end() {
        childrenCoordinators.removeAll()
        navigationController.dismiss(animated: true, completion: nil)
        parentCoordinator?.end()
    }

    /// This func dismiss all children coordinator
    func destroyChildren(completion: (() -> Void)?) {
        for child in childrenCoordinators {
            DispatchQueue.main.async {
                child.navigationController.dismiss(animated: true, completion: completion)
            }
        }
    }
}
