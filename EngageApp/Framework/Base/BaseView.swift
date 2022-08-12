//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

open class BaseView: UIView {
    private var toast: Toast!

    public init() {
        super.init(frame: CGRect.zero)

        /// Add keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        /// Hide keyboard when touch outside
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)

        configureUI()
        configureConstraints()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configureUI() {}

    func configureConstraints() {}

    @objc open func keyboardWillShow(notification _: NSNotification) {}

    @objc open func keyboardWillHide(notification _: NSNotification) {}

    @objc func dismissKeyboard() {
        endEditing(true)
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension BaseView: UIGestureRecognizerDelegate {}
