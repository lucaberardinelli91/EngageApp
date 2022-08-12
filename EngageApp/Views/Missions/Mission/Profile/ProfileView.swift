//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public class ProfileView: BaseView {
    var backTap = PassthroughSubject<Void, Never>()
    var helpTap = PassthroughSubject<Void, Never>()
    var tosTap = PassthroughSubject<Void, Never>()
    var logoutTap = PassthroughSubject<Void, Never>()
    var userImgTap = PassthroughSubject<Void, Never>()
    var tosUrlTap = PassthroughSubject<URL, Never>()
    var dismiss = PassthroughSubject<PrivacyFlags, Never>()
    var cruise = ("MSC Cruises", "La tua prossima crociera è tra 5 giorni!")
    var privacyFlags: PrivacyFlags? { didSet { didSetPrivacyFlags() } }
    var userInfo: UserInfo? { didSet { didSetUserInfo() }}

    lazy var backgroundImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.userBackground.image
        imgView.contentMode = .scaleToFill
        return imgView
    }()

    private var backBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.setImage(AppAsset.userBack.image, for: .normal)
        button.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        button.isUserInteractionEnabled = true

        return button
    }()

    private lazy var userLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.userTitle.apply(to: label)
        label.text = L10n.profileTitle

        return label
    }()

    lazy var userImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.borderWidth = 0.6
        imgView.layer.borderColor = UIColor.white.cgColor

        return imgView
    }()

    private lazy var userBrandImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.userBrand.image
        imgView.contentMode = .scaleToFill
        return imgView
    }()

    private lazy var nameLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.userName.apply(to: label)
        label.text = "NOME"

        return label
    }()

    private lazy var subTitleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.userCruise.apply(to: label)

        return label
    }()

    private lazy var cruiseView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeManager.currentTheme().secondaryColor.withAlphaComponent(0.2)

        let title = UILabel()
        title.numberOfLines = 1
        LabelStyle.userCruiseTitle.apply(to: title)

        let subTitle = UILabel()
        subTitle.numberOfLines = 1
        LabelStyle.userCruiseSubTitle.apply(to: subTitle)
        subTitle.text = L10n.profileCruiseChange

        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = ContentMode.scaleAspectFill
        imgView.image = AppAsset.notificationImage.image

        view.addSubview(title)
        view.addSubview(subTitle)
        view.addSubview(imgView)

        title.topAnchor /==/ view.topAnchor + 15
        title.leadingAnchor /==/ view.leadingAnchor + 15

        subTitle.topAnchor /==/ title.bottomAnchor + 5
        subTitle.leadingAnchor /==/ title.leadingAnchor

        imgView.widthAnchor /==/ 45
        imgView.heightAnchor /==/ imgView.widthAnchor
        imgView.centerYAnchor /==/ view.centerYAnchor
        imgView.trailingAnchor /==/ view.trailingAnchor - 15

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cruiseDidTap(recognizer:)))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)

        return view
    }()

    lazy var backLayerView: UIView = {
        var view = UIView()
        view.backgroundColor = AppAsset.brandPrimary.color.withAlphaComponent(0.5)

        return view
    }()

    private lazy var bodyScrollView: UIScrollView = {
        var scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false

        return scrollView
    }()

    private lazy var accountLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.userAccountSupport.apply(to: label)
        label.text = L10n.profileAccount

        return label
    }()

    private lazy var myAccountView: ActionMyAccountBS = {
        let view = ActionMyAccountBS()
        view.logoutBtnTap = {
            self.logoutTap.send()
        }
        view.userImgTap = {
            self.userImgTap.send()
        }

        return view
    }()

    private lazy var myAccountAction: ProfileAction = {
        let view = ProfileAction()
        view.actionUser = ActionUser(icon: AppAsset.userMyAccount.image,
                                     title: L10n.profileMyAccount,
                                     subTitle: "Sottotitolo my account")
        view.actionTap = {
            self.myAccountDidTap()
        }

        return view
    }()

    private lazy var tosAction: ProfileAction = {
        let view = ProfileAction()
        view.actionUser = ActionUser(icon: AppAsset.userTermsConditions.image,
                                     title: L10n.profileToS,
                                     subTitle: "Sottotitolo tos")
        view.actionTap = {
            self.tosDidTap()
        }

        return view
    }()

    private lazy var supportLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.userAccountSupport.apply(to: label)
        label.text = L10n.profileSupport

        return label
    }()

    private lazy var howAction: ProfileAction = {
        let view = ProfileAction()
        view.actionUser = ActionUser(icon: AppAsset.userHow.image,
                                     title: L10n.profileHow,
                                     subTitle: "Sottotitolo come funziona")
        view.actionTap = {
            self.howDidTap()
        }

        return view
    }()

    private lazy var helpAction: ProfileAction = {
        let view = ProfileAction()
        view.actionUser = ActionUser(icon: AppAsset.userHelp.image,
                                     title: L10n.profileHelp,
                                     subTitle: "Sottotitolo di aiuto")
        view.actionTap = {
            self.helpDidTap()
        }

        return view
    }()

    private lazy var actionTosBS: ActionToSBS = {
        let view = ActionToSBS()

        return view
    }()

    var userImg: UIImage? { didSet { didSetUserImg() }}

    override func configureUI() {
        super.configureUI()

        backgroundColor = .white

        addSubview(backgroundImgView)
        addSubview(backBtn)
        addSubview(userLbl)
        addSubview(userImgView)
        addSubview(userBrandImgView)
        addSubview(nameLbl)
        addSubview(subTitleLbl)
        addSubview(cruiseView)

        bodyScrollView.addSubview(accountLbl)
        bodyScrollView.addSubview(myAccountAction)
        bodyScrollView.addSubview(tosAction)
        bodyScrollView.addSubview(supportLbl)
        bodyScrollView.addSubview(howAction)
        bodyScrollView.addSubview(helpAction)
        addSubview(bodyScrollView)

        setSwipeGesture()

//        myAccountView.account = Account(name: userInfo?.profile?.firstName ?? "aa",
//                                        surname: userInfo?.profile?.lastName ?? "bb",
//                                        email: userInfo?.profile?.email?.email ?? "cc")

        // TEST
        myAccountView.account = Account(name: "Mario",
                                        surname: "Rossi",
                                        email: "mario.rossi@gmail.com")
    }

    override func configureConstraints() {
        super.configureConstraints()

        backgroundImgView.topAnchor /==/ topAnchor
        backgroundImgView.widthAnchor /==/ widthAnchor
        backgroundImgView.centerXAnchor /==/ centerXAnchor

        backBtn.centerYAnchor /==/ backgroundImgView.centerYAnchor + 5
        backBtn.leadingAnchor /==/ leadingAnchor + 20

        userLbl.topAnchor /==/ backBtn.topAnchor
        userLbl.centerXAnchor /==/ centerXAnchor

        userImgView.topAnchor /==/ userLbl.bottomAnchor + 20
        userImgView.centerXAnchor /==/ centerXAnchor
        userImgView.centerYAnchor /==/ backgroundImgView.bottomAnchor
        userImgView.widthAnchor /==/ 85
        userImgView.heightAnchor /==/ userImgView.heightAnchor

        userBrandImgView.widthAnchor /==/ 37
        userBrandImgView.heightAnchor /==/ userBrandImgView.widthAnchor
        userBrandImgView.bottomAnchor /==/ userImgView.bottomAnchor
        userBrandImgView.trailingAnchor /==/ userImgView.trailingAnchor

        nameLbl.centerXAnchor /==/ centerXAnchor
        nameLbl.topAnchor /==/ userImgView.bottomAnchor + 10

        subTitleLbl.centerXAnchor /==/ centerXAnchor
        subTitleLbl.topAnchor /==/ nameLbl.bottomAnchor + 5

        cruiseView.topAnchor /==/ subTitleLbl.bottomAnchor + 20
        cruiseView.leadingAnchor /==/ leadingAnchor + 20
        cruiseView.trailingAnchor /==/ trailingAnchor - 20
        cruiseView.heightAnchor /==/ 75
        cruiseView.centerXAnchor /==/ centerXAnchor

        // With scroll --------------------------------------------------
        bodyScrollView.topAnchor /==/ cruiseView.bottomAnchor + 25
        bodyScrollView.leadingAnchor /==/ leadingAnchor
        bodyScrollView.trailingAnchor /==/ trailingAnchor
        bodyScrollView.bottomAnchor /==/ bottomAnchor

        accountLbl.topAnchor /==/ bodyScrollView.topAnchor
        accountLbl.leadingAnchor /==/ leadingAnchor + 35
        accountLbl.heightAnchor /==/ 30

        myAccountAction.topAnchor /==/ accountLbl.bottomAnchor + 10
        myAccountAction.leadingAnchor /==/ accountLbl.leadingAnchor
        myAccountAction.trailingAnchor /==/ trailingAnchor - 35

        tosAction.topAnchor /==/ myAccountAction.bottomAnchor + 10
        tosAction.leadingAnchor /==/ accountLbl.leadingAnchor
        tosAction.trailingAnchor /==/ myAccountAction.trailingAnchor

        supportLbl.topAnchor /==/ tosAction.bottomAnchor + 20
        supportLbl.leadingAnchor /==/ accountLbl.leadingAnchor
        supportLbl.heightAnchor /==/ 30

        howAction.topAnchor /==/ supportLbl.bottomAnchor + 10
        howAction.leadingAnchor /==/ accountLbl.leadingAnchor
        howAction.trailingAnchor /==/ myAccountAction.trailingAnchor

        helpAction.topAnchor /==/ howAction.bottomAnchor + 10
        helpAction.leadingAnchor /==/ accountLbl.leadingAnchor
        helpAction.trailingAnchor /==/ myAccountAction.trailingAnchor
        helpAction.bottomAnchor /==/ bodyScrollView.bottomAnchor - 20
        // With scroll --------------------------------------------------

        // Without scroll -----------------------------------------------
        //        helpView.heightAnchor /==/ myAccountView.heightAnchor
        //        helpView.bottomAnchor /==/ bottomAnchor - 20

        //        accountLbl.topAnchor /==/ cruiseView.bottomAnchor + 25
        //        accountLbl.leadingAnchor /==/ leadingAnchor + 35
        //        accountLbl.heightAnchor /==/ 30
        //
        //        myAccountView.topAnchor /==/ accountLbl.bottomAnchor + 10
        //        myAccountView.leadingAnchor /==/ accountLbl.leadingAnchor
        //        myAccountView.trailingAnchor /==/ trailingAnchor - 35
        ////        myAccountView.heightAnchor /==/ 70
        //
        //        tosView.topAnchor /==/ myAccountView.bottomAnchor + 10
        //        tosView.leadingAnchor /==/ accountLbl.leadingAnchor
        //        tosView.trailingAnchor /==/ myAccountView.trailingAnchor
        ////        tosView.heightAnchor /==/ myAccountView.heightAnchor
        //
        //        supportLbl.topAnchor /==/ tosView.bottomAnchor + 20
        //        supportLbl.leadingAnchor /==/ accountLbl.leadingAnchor
        //        supportLbl.heightAnchor /==/ 30
        //
        //        howView.topAnchor /==/ supportLbl.bottomAnchor + 10
        //        howView.leadingAnchor /==/ accountLbl.leadingAnchor
        //        howView.trailingAnchor /==/ myAccountView.trailingAnchor
        ////        howView.heightAnchor /==/ myAccountView.heightAnchor
        //
        //        helpView.topAnchor /==/ howView.bottomAnchor + 10
        //        helpView.leadingAnchor /==/ accountLbl.leadingAnchor
        //        helpView.trailingAnchor /==/ myAccountView.trailingAnchor
        ////        helpView.heightAnchor /==/ myAccountView.heightAnchor
        ////        helpView.bottomAnchor /==/ bottomAnchor - 20
        // Without scroll -----------------------------------------------

        userImgView.image = AppAsset.userPlaceholder.image
        (cruiseView.subviews[0] as! UILabel).text = cruise.0
        subTitleLbl.text = cruise.1
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        userImgView.layer.cornerRadius = userImgView.bounds.width / 2
        cruiseView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
    }

    private func didSetUserImg() {
        guard let userImg = userImg else { return }

        userImgView.image = userImg
        userImgView.widthAnchor /==/ 85
        userImgView.heightAnchor /==/ userImgView.widthAnchor

        myAccountView.userImgView.image = userImg
        myAccountView.userImgView.widthAnchor /==/ 90
        myAccountView.userImgView.heightAnchor /==/ myAccountView.userImgView.widthAnchor
    }

    @objc func backButtonDidTap() {
        backBtn.tapAnimation {
            self.backTap.send()
        }
    }

    @objc func cruiseDidTap(recognizer _: UIPanGestureRecognizer) {
        cruiseView.tapAnimation { [self] in
            let view = CruiseBS()
            view.cruise = cruise
            presentAction(view)
            view.helpButtonTap = {
                cruiseHelpDidTap()
            }
            view.exitButtonTap = {
                cruiseExitDidTap()
            }
        }
    }

    private func cruiseHelpDidTap() {
        helpTap.send()
    }

    private func cruiseExitDidTap() {
        logoutTap.send()
    }

    private func myAccountDidTap() {
        presentAction(myAccountView)
    }

    private func tosDidTap() {
        tosTap.send()
    }

    func presentPrivacyTermsView(with configurator: [Privacy]?, privacyFlags: PrivacyFlags?) {
        actionTosBS.setConfigurator(privacy: configurator, privacyFlags: privacyFlags)
        actionTosBS.deleteAccountTap = {
            let view = ActionDeleteAccountBS()
            self.presentAction(view)
        }
        actionTosBS.tosTap = { url in
            self.tosUrlTap.send(url)
        }
        presentAction(actionTosBS)
    }

    private func howDidTap() {
        let view = ActionHowBS()
        presentAction(view)
    }

    private func helpDidTap() {
        helpTap.send()
    }

    func setSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        addGestureRecognizer(swipeRight)
    }

    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                backTap.send()
            default:
                break
            }
        }
    }

    private func didSetPrivacyFlags() {
        guard let privacyFlags = privacyFlags else { return }

        actionTosBS.privacyNewsletterContainerView.checkBox.isChecked = privacyFlags.agreeNewsletter
        actionTosBS.privacyMarketingContainerView.checkBox.isChecked = privacyFlags.agreeMarketing
        actionTosBS.privacyMarketingExtraContainerView.checkBox.isChecked = privacyFlags.agreeMarketingThirdParty
        actionTosBS.privacyProfilingContainerView.checkBox.isChecked = privacyFlags.agreeProfiling
        actionTosBS.privacyTermsContainerView.checkBox.isChecked = privacyFlags.agreeTerms
    }

    private func didSetUserInfo() {
        guard let userInfo = userInfo else { return }
        nameLbl.text = "Mario Rossi" // userInfo.profile?.firstName ?? ""
    }
}

extension ProfileView {
    func presentAction(_ view: BottomSheet) {
        backLayerView.removeFromSuperview()
        backLayerView.subviews.forEach { s in
            s.removeFromSuperview()
        }

        addSubview(backLayerView)
        backLayerView.edgeAnchors /==/ edgeAnchors
        backLayerView.alpha = 0
        layoutIfNeeded()

        UIView.animate(withDuration: 0.3) { [self] in
            backLayerView.alpha = 1
        } completion: { [self] _ in
            backLayerView.addSubview(view)

            view.dismiss = {
                dismissAction(view)
            }

            view.topAnchor /==/ backLayerView.bottomAnchor
            view.rightAnchor /==/ backLayerView.rightAnchor
            view.leftAnchor /==/ backLayerView.leftAnchor
            view.centerXAnchor /==/ backLayerView.centerXAnchor
            view.heightAnchor /==/ view.getHeight()
            layoutIfNeeded()

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 1) {
                view.transform = .init(translationX: 0, y: -view.getHeight())
            }
        }
    }

    func dismissAction(_ view: BottomSheet) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, animations: {
            view.transform = .identity
        }) { _ in
            let privacyFlgs = PrivacyFlags(agreeNewsletter: self.actionTosBS.privacyNewsletterContainerView.checkBox.isChecked,
                                           agreeMarketing: self.actionTosBS.privacyMarketingContainerView.checkBox.isChecked,
                                           agreeMarketingThirdParty: self.actionTosBS.privacyMarketingExtraContainerView.checkBox.isChecked,
                                           agreeProfiling: self.actionTosBS.privacyProfilingContainerView.checkBox.isChecked,
                                           agreeTerms: true)
            self.dismiss.send(privacyFlgs)
            self.backLayerView.removeFromSuperview()
        }
    }
}
