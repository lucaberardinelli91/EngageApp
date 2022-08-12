//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Foundation

public class FloatingTextField: BaseView {
    public let textField = UITextField(frame: .zero)

    private let stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal

        return stackView
    }()

    let placeholderLbl: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        LabelStyle.welcomeSignInEmailPlaceholder.apply(to: label)
        return label
    }()

    private let accessoryBtn: UIButton = {
        var button = UIButton()
        button.addTarget(self, action: #selector(accessoryImageDidTap), for: .touchUpInside)
        button.tintColor = ThemeManager.currentTheme().primaryColor
        button.contentMode = .scaleAspectFit

        return button
    }()

    /// Boolean used to design a secury TextField
    var isPasswordTextField = false

    /// Boolean used to hide or not the secury entry text
    var isPasswordHidden = true {
        didSet {
            refreshUI()
        }
    }

    public init(placeholder: String, textColor: UIColor = .black, tintColor: UIColor = .black, isPasswordTextField: Bool = false) {
        placeholderLbl.text = placeholder
        textField.textColor = textColor
        textField.tintColor = tintColor
        textField.autocorrectionType = .no
        textField.returnKeyType = .next

        self.isPasswordTextField = isPasswordTextField

        super.init(frame: CGRect.zero)

        configureUI()
        configureConstraints()

        textField.addTarget(self, action: #selector(animateDidBegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(animateDidEnd), for: .editingDidEnd)
    }

    override func configureUI() {
        super.configureUI()

        addSubview(stackView)
        stackView.addArrangedSubview(textField)

        textField.addSubview(placeholderLbl)
        textField.leftViewMode = .always
        if isPasswordTextField {
            textField.rightViewMode = .always
            textField.rightView = accessoryBtn
            refreshUI()
        }
    }

    override func configureConstraints() {
        super.configureConstraints()

        stackView.edgeAnchors /==/ edgeAnchors

        textField.topAnchor /==/ stackView.topAnchor + 3
        textField.leftAnchor /==/ stackView.leftAnchor
        textField.rightAnchor /==/ stackView.rightAnchor
        textField.bottomAnchor /==/ stackView.bottomAnchor

        placeholderLbl.centerYAnchor /==/ centerYAnchor - 3
        placeholderLbl.leftAnchor /==/ textField.leftAnchor
        placeholderLbl.widthAnchor /==/ 250

        if isPasswordTextField {
            accessoryBtn.widthAnchor /==/ 25
            accessoryBtn.heightAnchor /==/ 25
        }
    }

    private func refreshUI() {
        if isPasswordHidden {
            textField.isSecureTextEntry = true
            accessoryBtn.setImage(AppAsset.eyeClosed.image.withTintColor(ThemeManager.currentTheme().primaryColor, renderingMode: .alwaysTemplate), for: .normal)
        } else {
            textField.isSecureTextEntry = false
            accessoryBtn.setImage(AppAsset.eyeOpen.image.withTintColor(ThemeManager.currentTheme().primaryColor,
                                                                       renderingMode: .alwaysTemplate), for: .normal)
        }
    }

    @objc public func animateDidBegin() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.placeholderLbl.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -10)
                self.placeholderLbl.textAlignment = .left
            }
        }
    }

    @objc public func animateDidEnd() {
        if textField.text?.isEmpty ?? false {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    self.placeholderLbl.transform = .identity
                }
            }
        }
    }

    // MARK: - Private methods

    /// Action to change the boolean `isPasswordHidden`
    @objc private func accessoryImageDidTap() {
        isPasswordHidden = !isPasswordHidden
    }
}
