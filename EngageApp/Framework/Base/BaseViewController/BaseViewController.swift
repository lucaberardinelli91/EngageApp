//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import Foundation
import UIKit

open class BaseViewController: UIViewController {
    var modalViews: [ModalView] = []
    /// If this variable is `true`, then in `viewWillAppear` will be added a button which action is dismiss or pop the controller
    public var addsCloseButton = false

    /// This is the error handler that handle ONLY the `CustomError`
    public var errorHandler: ErrorHandleable?

    /// Cancellables for `Combine`
    public var cancellables = Set<AnyCancellable>()

    override open func viewDidLoad() {
        super.viewDidLoad()

        observeError()

        extendedLayoutIncludesOpaqueBars = true

        /// When a custom transition it's used, the interactive pop gesture seems not works. This fix this problem. See `https://github.com/HeroTransitions/Hero/issues/143`
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if addsCloseButton {
            addCloseButton()
        }
    }

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    public func showToast(color: UIColor, text: String, fromCurrentContext: Bool = false, finally: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let toast = Toast(frame: .zero, color: color, text: text)

            toast.dismiss = {
                dismiss()
            }

            if fromCurrentContext {
                self.view.addSubview(toast)
                setToastConstraints(_view: self.view)
            } else if let frontWindow = UIWindow.frontWindow {
                frontWindow.addSubview(toast)
                setToastConstraints(_view: frontWindow)
            }

            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut) {
                toast.transform = .init(translationX: 0, y: 80 + (UIWindow.frontWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 50))
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                dismiss()
            }

            func setToastConstraints(_view: UIView) {
                toast.bottomAnchor /==/ _view.topAnchor
                toast.leftAnchor /==/ _view.leftAnchor + 15
                toast.rightAnchor /==/ _view.rightAnchor - 15
                toast.heightAnchor /==/ 80
                _view.layoutIfNeeded()
            }

            func dismiss() {
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    toast.transform = .identity
                }) { _ in
                    toast.removeFromSuperview()
                    finally?()
                }
            }
        }
    }

    open func showLoader() {
        DispatchQueue.main.async {
            self.showModal(modalView: CustomLoader(frame: self.view.bounds, from: self))
        }
    }

    public func hideLoader() {
        DispatchQueue.main.async {
            self.hideModal()
        }
    }

    open func closeAction() {
        DispatchQueue.main.async {
            if self.isModal {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
