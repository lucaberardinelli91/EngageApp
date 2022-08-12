//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

// MARK: - BottomSheet

open class BottomSheet: BaseView {
    private var height: CGFloat

    public var dismiss: (() -> Void)?

    fileprivate let panGestureRecognizer: UIPanGestureRecognizer = {
        let gestureRecognizer = UIPanGestureRecognizer()
        return gestureRecognizer
    }()

    fileprivate var moveRange: (down: CGFloat, up: CGFloat) {
        return (height / 6, height / 3)
    }

    public init(height: CGFloat) {
        self.height = height
        super.init(frame: .zero)

        /// Configure gesture
        addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.addTarget(self, action: #selector(handleGestureDragging(_:)))
    }
}

extension BottomSheet {
    @objc dynamic func handleGestureDragging(_ gestureRecognizer: UIPanGestureRecognizer) {
        let gestureView = gestureRecognizer.view
        let point = gestureRecognizer.translation(in: gestureView)
        let originY = UIScreen.main.bounds.height - height
        let newY = -height + point.y

        switch gestureRecognizer.state {
        case .began:
            break
        case .changed:
            if newY > -height - 10 {
                transform = .init(translationX: 0, y: newY)
            }
        case .cancelled,
             .ended:
            if newY < -height {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 2) {
                    self.transform = .init(translationX: 0, y: -self.height)
                }
            }
            if frame.origin.y - originY > moveRange.down {
                dismiss?()
            }
        default:
            break
        }
    }

    public func getHeight() -> CGFloat {
        return height
    }
}
