//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Foundation
import UIKit

public class SignInTextFieldView: BaseView, Validable {
    public var floatingTextField: FloatingTextField
    private var errorColor: UIColor = AppAsset.brandDanger.color

    private let errorLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.alpha = 0.0
        LabelStyle.signupErrorLabel.apply(to: label)
        return label
    }()

    private var errorBackground: UIView = {
        var view = UIView(frame: .zero)
        return view
    }()

    private var emailImgView: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.image = AppAsset.emailOff.image
        return imageView
    }()

    public var validations: [ValidationType] = [.none]
    public var viewToObserve: UIView?
    var isLoginBtnEnabled: ((Bool) -> Void)?
    var email: String? { didSet { didSetEmail() }}
    var emailError: Bool? { didSet { didSetEmailError() }}

    public init(floatingTextField: FloatingTextField) {
        self.floatingTextField = floatingTextField

        super.init(frame: CGRect.zero)

        self.floatingTextField.textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.floatingTextField.textField.addTarget(self, action: #selector(textFieldDidEndEditing(textField:)), for: .editingDidEnd)
        self.floatingTextField.textField.addTarget(self, action: #selector(textFieldDidBeginEditing(textField:)), for: .editingDidBegin)

        configureUI()
        configureConstraints()
    }

    override func configureUI() {
        super.configureUI()

        addSubview(emailImgView)
        addSubview(floatingTextField)
        addSubview(errorLabel)

        TextFieldsStyle.signup.apply(to: floatingTextField.textField)

        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.lightGray.cgColor

        guard let text = floatingTextField.textField.text else { return }
        checkEmail(text)
    }

    override func configureConstraints() {
        super.configureConstraints()

        emailImgView.centerYAnchor /==/ centerYAnchor
        emailImgView.leftAnchor /==/ leftAnchor + 14
        emailImgView.widthAnchor /==/ 36
        emailImgView.heightAnchor /==/ 36

        floatingTextField.leftAnchor /==/ emailImgView.rightAnchor + 10
        floatingTextField.rightAnchor /==/ rightAnchor - 15
        floatingTextField.topAnchor /==/ topAnchor + 5
        floatingTextField.bottomAnchor /==/ bottomAnchor

        floatingTextField.textField.becomeFirstResponder()

        errorLabel.topAnchor /==/ floatingTextField.bottomAnchor + 5
        errorLabel.leftAnchor /==/ leftAnchor
        errorLabel.rightAnchor /==/ rightAnchor
        errorLabel.heightAnchor /==/ 15
    }

    public func setValidations(validations: [ValidationType]) {
        self.validations = validations
    }

    public func setViewToObserve(view: UIView) {
        viewToObserve = view
    }

    public func showError(text: String) {
        errorLabel.text = text
        UIView.animate(withDuration: 0.25) {
            /// Error background
            self.errorBackground.backgroundColor = self.errorColor.withAlphaComponent(0.1)
            self.insertSubview(self.errorBackground, belowSubview: self.floatingTextField)
            self.errorBackground.layer.cornerRadius = 10
            self.errorBackground.edgeAnchors /==/ self.edgeAnchors

            self.errorLabel.alpha = 1.0

            self.floatingTextField.placeholderLbl.textColor = self.errorColor
            self.layer.borderWidth = 1
            self.layer.borderColor = AppAsset.errorColor.color.cgColor
        }
    }

    public func hideError() {
        UIView.animate(withDuration: 0.25) {
            self.errorBackground.removeFromSuperview()
            self.errorLabel.alpha = 0.0
            LabelStyle.signupPlaceholderLabel.apply(to: self.floatingTextField.placeholderLbl)

            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.clear.cgColor
        }
    }

    private func didSetEmail() {
        guard let email = email else { return }
        floatingTextField.textField.text = email
        checkEmail(email)
    }

    private func didSetEmailError() {
        self.layer.borderWidth = 1
        self.layer.borderColor = AppAsset.brandDanger.color.cgColor
        backgroundColor = AppAsset.brandDanger.color.withAlphaComponent(0.1)
    }

    private func checkEmail(_ text: String) {
        if text.isEmpty {
            emailImgView.image = AppAsset.emailOff.image
            floatingTextField.placeholderLbl.text = "Inserisci la tua email"
            isLoginBtnEnabled?(false)
        } else {
            emailImgView.image = AppAsset.emailOn.image
            floatingTextField.placeholderLbl.text = ""
            floatingTextField.textField.centerYAnchor /==/ floatingTextField.centerYAnchor - 3
            isLoginBtnEnabled?(true)
        }
    }
}

extension SignInTextFieldView {
    @objc func textFieldDidChange(textField: UITextField) {
        guard let text = textField.text else { return }
        checkEmail(text)

        if !text.isEmpty, layer.borderColor == errorColor.cgColor {
            /// It's in error mode
            hideError()
        }
    }

    @objc func textFieldDidEndEditing(textField _: UITextField) {
        UIView.transition(with: self, duration: 0.1, options: .transitionCrossDissolve) {
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.clear.cgColor
        }
    }

    @objc func textFieldDidBeginEditing(textField _: UITextField) {
        if layer.borderColor == errorColor.cgColor { hideError() }

        UIView.transition(with: self, duration: 0.1, options: .transitionCrossDissolve) {
            self.layer.borderWidth = 1
            self.layer.borderColor = ThemeManager.currentTheme().secondaryColor.cgColor
        }
    }
}
