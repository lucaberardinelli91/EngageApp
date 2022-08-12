//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

// MARK: - RouterMode

public enum RouterMode {
    case present
    case push
}

// MARK: - PresentationStyle

public enum PresentationStyle {
    case automatic
    case currentContext
    case custom
    case formSheet
    case fullScreen
    case none
    case overCurrentContext
    case overFullScreen
    case pageSheet
    case popover
}

// MARK: - TransitionStyle

public enum TransitionStyle {
    case coverVertical
    case crossDissolve
    case flipHorizontal
    case partialCurl
}

// MARK: - RouterProtocol

public protocol RouterProtocol {
    func route(to: UIViewController, from: UINavigationController, mode: RouterMode, animated: Bool, modalPresentationStyle: PresentationStyle?, modalTransitionStyle: TransitionStyle, presentingViewController: Bool, completion: (() -> Void)?)

    func dismiss(from: UIViewController)
}

public extension RouterProtocol {
    func route(to: UIViewController, from: UINavigationController, mode: RouterMode, animated: Bool = true, modalPresentationStyle: PresentationStyle? = .automatic, modalTransitionStyle: TransitionStyle = .coverVertical, presentingViewController: Bool = false, completion: (() -> Void)? = nil) {
        switch mode {
        case .present:
            DispatchQueue.main.async {
                to.modalTransitionStyle = mapTransitionStyle(transitionStyle: modalTransitionStyle)
                to.modalPresentationStyle = mapPresentationStyle(presentationStyle: modalPresentationStyle ?? .none)
                if presentingViewController {
                    from.presentingViewController?.present(to, animated: animated, completion: completion)
                } else {
                    from.present(to, animated: animated, completion: completion)
                }
            }
        case .push:
            DispatchQueue.main.async {
                from.pushViewController(to, animated: animated)
            }
        }
    }

    func dismiss(from: UIViewController) {
        DispatchQueue.main.async {
            from.dismiss(animated: true, completion: nil)
        }
    }

    private func mapPresentationStyle(presentationStyle: PresentationStyle) -> UIModalPresentationStyle {
        switch presentationStyle {
        case .automatic:
            return .automatic
        case .currentContext:
            return .currentContext
        case .custom:
            return .custom
        case .formSheet:
            return .formSheet
        case .fullScreen:
            return .fullScreen
        case .none:
            return .none
        case .overCurrentContext:
            return .overCurrentContext
        case .overFullScreen:
            return .overFullScreen
        case .pageSheet:
            return .pageSheet
        case .popover:
            return .popover
        }
    }

    private func mapTransitionStyle(transitionStyle: TransitionStyle) -> UIModalTransitionStyle {
        switch transitionStyle {
        case .coverVertical:
            return .coverVertical
        case .crossDissolve:
            return .crossDissolve
        case .flipHorizontal:
            return .flipHorizontal
        case .partialCurl:
            return .partialCurl
        }
    }
}
