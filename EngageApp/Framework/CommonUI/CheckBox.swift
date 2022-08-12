//
//  EngageApp
//  Created by Luca Berardinelli
//

import UIKit

// MARK: - CheckBoxDelegate

public protocol CheckBoxDelegate: NSObject {
    func didSelect(selected: Bool)
}

// MARK: - CheckBox

public class CheckBox: UIButton {
    /// Bool property
    public var isChecked = false {
        didSet {
            if isChecked {
                tapAnimation {
                    UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve) {
                        self.setImage((!self.isRounded ? AppAsset.checkboxChecked.image : AppAsset.radiobuttonChecked.image), for: UIControl.State.normal)
                    }
                }
            } else {
                if !isRounded {
                    tapAnimation {
                        UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve) {
                            self.setImage((!self.isRounded ? AppAsset.checkbox.image : AppAsset.radiobutton.image), for: UIControl.State.normal)
                        }
                    }
                }
            }
        }
    }

    public var isRounded: Bool

    public var delegate: CheckBoxDelegate?

    public init(isRounded: Bool = false) {
        self.isRounded = isRounded

        super.init(frame: .zero)
        addTarget(self, action: #selector(checkBoxDidTap), for: .touchUpInside)
        isChecked = false

        configureUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI() {
        setImage((!isRounded ? AppAsset.checkbox.image : AppAsset.radiobutton.image), for: .normal)
    }

    /// Actions
    @objc func checkBoxDidTap() {
        isChecked = !isChecked
        delegate?.didSelect(selected: isChecked)
    }
}
