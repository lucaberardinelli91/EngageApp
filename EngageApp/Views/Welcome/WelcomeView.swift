//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Anchorage
import AuthenticationServices
import Combine
import Hero
import UIKit

public class WelcomeView: BaseView {
    var continueButtonDidTap = PassthroughSubject<String, Never>()
    var urlDidTap = PassthroughSubject<URL, Never>()
    var readEmailDidTap = PassthroughSubject<Void, Never>()
    var count = 0

    private var backgroundImgView: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.image = AppAsset.imgWelcomeBackground.image

        return imageView
    }()

    private lazy var brandImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.brandNameColor.image
        imgView.contentMode = .scaleAspectFill

        return imgView
    }()

    private lazy var titleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.welcomeTitle.apply(to: label)
        label.text = L10n.welcomeTitle

        return label
    }()

    private lazy var subTitleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = L10n.welcomeSubTitle
        LabelStyle.welcomeSubTitle.apply(to: label)
        label.numberOfLines = 0

        return label
    }()

    private lazy var emailTitleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = L10n.welcomeEmailBooking
        LabelStyle.welcomeEmailTitle.apply(to: label)
        label.numberOfLines = 0

        return label
    }()

    lazy var emailTextField: SignInTextFieldView = {
        var textField = SignInTextFieldView(floatingTextField: FloatingTextField(placeholder: L10n.welcomeTypeEmail))
        textField.floatingTextField.textField.autocapitalizationType = .none
        textField.setValidations(validations: [.email])
        textField.setViewToObserve(view: textField.floatingTextField.textField)
        textField.floatingTextField.textField.keyboardType = .emailAddress
        textField.backgroundColor = .white
        textField.hero.id = Constants.HeroTransitionsID.welcomeTextField
        textField.isLoginBtnEnabled = isLoginBtnEnabled

        return textField
    }()

    private lazy var emailNotFoundBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.backgroundColor = UIColor.lightGray
        button.setTitle(L10n.welcomeEmailNotFound, for: .normal)
        button.addTarget(self, action: #selector(emailNotFoundDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = AppAsset.backgroundColor.color
        button.setTitleColor(UIColor.black, for: .normal)
        ButtonStyle.welcomeEmailNotFoundButton.apply(to: button)
        return button
    }()

    private lazy var loginBtn: UIButton = {
        var button = UIButton(frame: .zero)
        ButtonStyle.secondaryButton.apply(to: button)
        button.setTitle(L10n.login.uppercased(), for: .normal)
        button.hero.id = Constants.HeroTransitionsID.welcomeContinueButton
        button.addTarget(self, action: #selector(continueWelcomeButtonDidTap), for: .touchUpInside)

        return button
    }()

    private lazy var noBookingTxtView: UITextView = {
        var label = UITextView(frame: .zero)
        label.isEditable = false
        label.textAlignment = .center
        label.linkTextAttributes = [NSAttributedString.Key.foregroundColor: ThemeManager.currentTheme().secondaryColor]
        label.isScrollEnabled = false
        label.text = L10n.welcomeBookingNotFound
        LabelStyle.welcomeNoBooking.apply(to: label)

        return label
    }()

    var confirmEmailView: WelcomeConfirmEmailBS = {
        var view = WelcomeConfirmEmailBS()

        return view
    }()

    private let blackLayerView: UIView = {
        var view = UIView()
        view.backgroundColor = AppAsset.brandPrimary.color.withAlphaComponent(0.5)

        return view
    }()

    private lazy var shadowView: UIView = {
        var view = UIView(frame: .zero)

        return view
    }()

    override func configureUI() {
        super.configureUI()

        backgroundColor = ThemeManager.currentTheme().backgroundColor
        hero.id = Constants.HeroTransitionsID.welcomeTransition
        hero.modifiers = [.backgroundColor(ThemeManager.currentTheme().secondaryColor), .duration(0.3), .fade, .shadowColor(ThemeManager.currentTheme().secondaryColor)]

        addSubview(backgroundImgView)
        addSubview(brandImgView)
        addSubview(titleLbl)
        addSubview(subTitleLbl)
        addSubview(emailTitleLbl)
        addSubview(emailTextField)
        addSubview(emailNotFoundBtn)
        addSubview(loginBtn)
        addSubview(noBookingTxtView)

        backgroundImgView.addSubview(shadowView)
    }

    override func configureConstraints() {
        super.configureConstraints()

        backgroundImgView.leadingAnchor /==/ leadingAnchor
        backgroundImgView.trailingAnchor /==/ trailingAnchor
        backgroundImgView.bottomAnchor /==/ bottomAnchor

        shadowView.leadingAnchor /==/ backgroundImgView.leadingAnchor
        shadowView.trailingAnchor /==/ backgroundImgView.trailingAnchor

        brandImgView.centerXAnchor /==/ centerXAnchor
        brandImgView.heightAnchor /==/ 10
        brandImgView.widthAnchor /==/ 240

        titleLbl.leftAnchor /==/ leftAnchor + 24
        titleLbl.heightAnchor /==/ 30

        subTitleLbl.leftAnchor /==/ leftAnchor + 24
        subTitleLbl.rightAnchor /==/ rightAnchor - 24
        subTitleLbl.heightAnchor /==/ 40

        emailTitleLbl.leftAnchor /==/ leftAnchor + 24
        emailTitleLbl.heightAnchor /==/ 20

        emailTextField.leftAnchor /==/ leftAnchor + 15
        emailTextField.rightAnchor /==/ rightAnchor - 15
        emailTextField.heightAnchor /==/ 55

        emailNotFoundBtn.topAnchor /==/ emailTextField.bottomAnchor + 18 // 15
        emailNotFoundBtn.centerXAnchor /==/ centerXAnchor
        emailNotFoundBtn.heightAnchor == 20

        loginBtn.leftAnchor /==/ leftAnchor + 37
        loginBtn.rightAnchor /==/ rightAnchor - 38
        loginBtn.heightAnchor /==/ 55

        noBookingTxtView.topAnchor /==/ loginBtn.bottomAnchor + 10
        noBookingTxtView.centerXAnchor /==/ centerXAnchor
        noBookingTxtView.heightAnchor /==/ 60

        if UIScreen.main.bounds.height < Constants.screenHeightSmall {
            backgroundImgView.heightAnchor /==/ heightAnchor * 0.41
            shadowView.heightAnchor == backgroundImgView.heightAnchor
            shadowView.topAnchor /==/ centerYAnchor - 15
            brandImgView.topAnchor /==/ topAnchor + 40
            titleLbl.topAnchor /==/ brandImgView.bottomAnchor + 35
            subTitleLbl.topAnchor /==/ titleLbl.bottomAnchor + 5
            emailTitleLbl.topAnchor /==/ subTitleLbl.bottomAnchor + 25
            emailTextField.topAnchor /==/ emailTitleLbl.bottomAnchor + 4
            loginBtn.bottomAnchor /==/ noBookingTxtView.topAnchor - 10
            noBookingTxtView.bottomAnchor /==/ bottomAnchor - 5
        } else {
            backgroundImgView.heightAnchor /==/ heightAnchor * 0.51
            shadowView.heightAnchor == backgroundImgView.heightAnchor * 0.6
            brandImgView.topAnchor /==/ topAnchor + 100
            titleLbl.topAnchor /==/ brandImgView.bottomAnchor + 55
            subTitleLbl.topAnchor /==/ titleLbl.bottomAnchor + 22
            emailTitleLbl.topAnchor /==/ subTitleLbl.bottomAnchor + 35
            emailTextField.topAnchor /==/ emailTitleLbl.bottomAnchor + 14
            loginBtn.bottomAnchor /==/ noBookingTxtView.topAnchor - 10
            noBookingTxtView.bottomAnchor /==/ bottomAnchor - 60
        }
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        shadowView.removeGradient()
        shadowView.setGradientBackground(locations: [0.0, 0.5], colorTop: ThemeManager.currentTheme().backgroundColor, colorBottom: AppAsset.clear.color)
    }

    func refreshView() {
        emailTextField.floatingTextField.textField.delegate = self
        noBookingTxtView.delegate = self
    }

    func refreshConstraints() {}

    override public func layoutSubviews() {
        super.layoutSubviews()

        emailTextField.layer.cornerRadius = 10
    }

    func setConfigurator() {
        refreshView()
        refreshConstraints()
    }

    func emailError() {
        emailTextField.emailError = true
    }

    override public func keyboardWillShow(notification _: NSNotification) {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, animations: { () in
            switch UIScreen.main.bounds.height {
            case let h where h < Constants.screenHeightSmall:
                let constant = self.bounds.height * 0.28
                self.loginBtn.transform = .init(translationX: 0, y: -constant)
            case let h where h < Constants.screenHeightMedium:
                let constant = self.bounds.height * 0.24
                self.loginBtn.transform = .init(translationX: 0, y: -constant)
            case let h where h >= Constants.screenHeightMedium:
                let constant = self.bounds.height * 0.2
                self.loginBtn.transform = .init(translationX: 0, y: -constant)
            default: break
            }
            self.backgroundImgView.image = nil
        })
    }

    override public func keyboardWillHide(notification _: NSNotification) {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, animations: { () in
            self.loginBtn.transform = .identity
            self.backgroundImgView.image = AppAsset.imgWelcomeBackground.image
        })
    }

    func showEmailError() {
        emailTextField.showError(text: L10n.singupValidationEmail)
    }

    func sendUrlAndTitle(URL: URL) {
        urlDidTap.send(URL)
    }

    @objc func emailNotFoundDidTap(_: UITapGestureRecognizer) {
        // TODO:
    }

    @objc func continueWelcomeButtonDidTap() {
        loginBtn.tapAnimation { [self] in
            emailTextField.endEditing(true)
            loginBtn.tapAnimation {
                guard let email = self.emailTextField.floatingTextField.textField.text else { return }
                self.continueButtonDidTap.send(email)
            }
        }
    }

    @objc func isLoginBtnEnabled(isEnabled: Bool) {
        isEnabled ? ButtonStyle.secondaryButton.apply(to: loginBtn) : ButtonStyle.secondaryDisabledButton.apply(to: loginBtn)
        loginBtn.isEnabled = isEnabled
    }
}

extension WelcomeView: UITextFieldDelegate {
    public func textFieldShouldReturn(_: UITextField) -> Bool {
        continueWelcomeButtonDidTap()
        return false
    }
}

extension WelcomeView: UITextViewDelegate {
    public func textView(_: UITextView, shouldInteractWith URL: URL, in _: NSRange, interaction _: UITextItemInteraction) -> Bool {
        noBookingTxtView.tapAnimation {
            self.sendUrlAndTitle(URL: URL)
        }
        return false
    }
}

extension WelcomeView {
    func presentConfirmEmailView() {
        addSubview(blackLayerView)
        blackLayerView.edgeAnchors /==/ edgeAnchors
        blackLayerView.alpha = 0
        layoutIfNeeded()

        UIView.animate(withDuration: 0.3) {
            self.blackLayerView.alpha = 1
        } completion: { _ in
            self.blackLayerView.addSubview(self.confirmEmailView)

            self.confirmEmailView.dismiss = {
                self.dismissConfirmEmailView()
            }

            self.confirmEmailView.continueButtonTap = {
                self.readEmailDidTap.send()
            }

            self.confirmEmailView.topAnchor /==/ self.blackLayerView.bottomAnchor
            self.confirmEmailView.rightAnchor /==/ self.blackLayerView.rightAnchor
            self.confirmEmailView.leftAnchor /==/ self.blackLayerView.leftAnchor
            self.confirmEmailView.heightAnchor /==/ self.confirmEmailView.getHeight()
            self.layoutIfNeeded()

            self.confirmEmailView.clipsToBounds = true

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 1) {
                self.confirmEmailView.transform = .init(translationX: 0, y: -self.confirmEmailView.getHeight())
            }
        }
    }

    func dismissConfirmEmailView() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, animations: {
            self.confirmEmailView.transform = .identity
        }) { _ in
            self.blackLayerView.removeFromSuperview()
        }
    }
}
