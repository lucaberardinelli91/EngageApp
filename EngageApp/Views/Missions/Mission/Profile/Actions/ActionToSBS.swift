//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public class ActionToSBS: BottomSheet {
    @objc var deleteAccountTap: (() -> Void)?
    @objc var tosTap: ((URL) -> Void)?

    private var privacy: [Privacy]? {
        didSet {
            refreshUI()
            refreshConstraints()
        }
    }

    @objc var signupTap: ((_ marketing: Bool, _ marketingExtra: Bool, _ newsLetter: Bool, _ profiling: Bool, _ profilingExtra: Bool) -> Void)?

    private let tosTitleLbl: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        LabelStyle.accountTitle.apply(to: label)
        label.text = L10n.privacyTitleBS

        return label
    }()

    private let tosSubTitleLbl: UILabel = {
        var label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        LabelStyle.accountSubTitle.apply(to: label)
        label.text = L10n.privacySubTitleBS

        return label
    }()

    private let deleteAccountBtn: UIButton = {
        var button = UIButton(frame: .zero)
        ButtonStyle.dangerReverseButton.apply(to: button)
        button.setTitle(L10n.deleteAccount, for: .normal)
        button.addTarget(self, action: #selector(deleteAccountDidTap), for: .touchUpInside)

        return button
    }()

    private var pullView: UIView = {
        var containerView = UIView(frame: .zero)
        containerView.backgroundColor = .clear

        var pullView = UIView(frame: .zero)
        pullView.backgroundColor = AppAsset.lighGray.color
        pullView.layer.cornerRadius = 3
        containerView.addSubview(pullView)

        pullView.centerAnchors /==/ containerView.centerAnchors
        pullView.widthAnchor /==/ 50
        pullView.heightAnchor /==/ 6

        return containerView
    }()

    let privacyMarketingContainerView: SignupPrivacyCustomView = {
        var privacyContainer = SignupPrivacyCustomView(privacyString: L10n.privacyMarketing, labelStyle: LabelStyle.signupPrivacyLabel, selectionStyle: .checkBox)
        privacyContainer.setValidations(validations: [.privacy(type: .marketing)])
        privacyContainer.setViewToObserve(view: privacyContainer.checkBox)

        return privacyContainer
    }()

    let privacyMarketingExtraContainerView: SignupPrivacyCustomView = {
        var privacyContainer = SignupPrivacyCustomView(privacyString: L10n.privacyMarketingExtra, labelStyle: LabelStyle.signupPrivacyLabel, selectionStyle: .checkBox)
        privacyContainer.setValidations(validations: [.privacy(type: .marketingThirdParty)])
        privacyContainer.setViewToObserve(view: privacyContainer.checkBox)

        return privacyContainer
    }()

    let privacyNewsletterContainerView: SignupPrivacyCustomView = {
        var privacyContainer = SignupPrivacyCustomView(privacyString: L10n.privacyNewsletter, labelStyle: LabelStyle.signupPrivacyLabel, selectionStyle: .checkBox)
        privacyContainer.setValidations(validations: [.privacy(type: .newsletter)])
        privacyContainer.setViewToObserve(view: privacyContainer.checkBox)

        return privacyContainer
    }()

    let privacyProfilingContainerView: SignupPrivacyCustomView = {
        var privacyContainer = SignupPrivacyCustomView(privacyString: L10n.privacyProfiling, labelStyle: LabelStyle.signupPrivacyLabel, selectionStyle: .checkBox)
        privacyContainer.setValidations(validations: [.privacy(type: .profiling)])
        privacyContainer.setViewToObserve(view: privacyContainer.checkBox)

        return privacyContainer
    }()

    lazy var privacyTermsContainerView: SignupPrivacyCustomView = {
        var privacyContainer = SignupPrivacyCustomView(privacyString: L10n.privacyProfilingExtra, labelStyle: LabelStyle.tosPrivacy, selectionStyle: .checkBox, isTappable: true, isCheckBoxRounded: true)
        privacyContainer.setValidations(validations: [.privacy(type: .profilingThirdParty)])
        privacyContainer.setViewToObserve(view: privacyContainer.checkBox)

        privacyContainer.urlDidTap = { url in
            self.tosTap?(url)
        }

        return privacyContainer
    }()

    private var privacyStackView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually

        return stackView
    }()

    init() {
        super.init(height: 595)

        configureUI()
        configureConstraints()
    }

    override func configureUI() {
        backgroundColor = .white

        addSubview(pullView)
        addSubview(tosTitleLbl)
        addSubview(tosSubTitleLbl)
        addSubview(deleteAccountBtn)
    }

    override func configureConstraints() {
        pullView.topAnchor /==/ topAnchor + 10
        pullView.centerXAnchor /==/ centerXAnchor
        pullView.heightAnchor /==/ 5
        pullView.widthAnchor /==/ 55

        tosTitleLbl.topAnchor /==/ pullView.bottomAnchor + 15
        tosTitleLbl.leftAnchor /==/ leftAnchor + 60
        tosTitleLbl.rightAnchor /==/ rightAnchor - 60
        tosTitleLbl.centerXAnchor /==/ centerXAnchor
        tosTitleLbl.heightAnchor /==/ 40

        tosSubTitleLbl.topAnchor /==/ tosTitleLbl.bottomAnchor + 5
        tosSubTitleLbl.leftAnchor /==/ leftAnchor + 48
        tosSubTitleLbl.rightAnchor /==/ rightAnchor - 48
        tosSubTitleLbl.heightAnchor /==/ 25
    }

    private func refreshUI() {
        guard let configurator = privacy else { return }
        addSubview(privacyStackView)

        for privacyView in configurator {
            switch privacyView.type {
            case .newsletter:
                privacyStackView.addArrangedSubview(privacyNewsletterContainerView)

            case .marketing:
                privacyStackView.addArrangedSubview(privacyMarketingContainerView)

            case .marketingThirdParty:
                privacyStackView.addArrangedSubview(privacyMarketingExtraContainerView)

            case .profiling:
                privacyStackView.addArrangedSubview(privacyProfilingContainerView)

            case .profilingThirdParty:
                privacyStackView.addArrangedSubview(privacyTermsContainerView)

            default:
                break
            }
        }

        addSubview(deleteAccountBtn)
    }

    private func refreshConstraints() {
        privacyStackView.topAnchor /==/ tosSubTitleLbl.bottomAnchor + 10
        privacyStackView.leftAnchor /==/ leftAnchor + 15
        privacyStackView.rightAnchor /==/ rightAnchor - 15
        privacyStackView.bottomAnchor /==/ deleteAccountBtn.topAnchor - 15

        deleteAccountBtn.bottomAnchor /==/ bottomAnchor - 25
        deleteAccountBtn.leftAnchor /==/ leftAnchor + 15
        deleteAccountBtn.rightAnchor /==/ rightAnchor - 15
        deleteAccountBtn.heightAnchor /==/ 55
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }

    func setConfigurator(privacy: [Privacy]?, privacyFlags: PrivacyFlags?) {
        self.privacy = privacy

        guard let privacyFlags = privacyFlags else { return }
        privacyNewsletterContainerView.checkBox.isChecked = privacyFlags.agreeNewsletter
        privacyMarketingContainerView.checkBox.isChecked = privacyFlags.agreeMarketing
        privacyMarketingExtraContainerView.checkBox.isChecked = privacyFlags.agreeMarketingThirdParty
        privacyProfilingContainerView.checkBox.isChecked = privacyFlags.agreeProfiling
        privacyTermsContainerView.checkBox.isChecked = privacyFlags.agreeTerms
    }

    @objc func deleteAccountDidTap() {
        deleteAccountBtn.tapAnimation {
            self.deleteAccountTap?()
        }
    }
}
