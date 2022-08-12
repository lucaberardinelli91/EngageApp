//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public class HomeView: BaseView {
    var walletTap = PassthroughSubject<Void, Never>()
    var profileTap = PassthroughSubject<Void, Never>()
    var missionsShowAllTap = PassthroughSubject<Void, Never>()
    var catalogShowAllTap = PassthroughSubject<Void, Never>()
    var shareTap = PassthroughSubject<Void, Never>()
    var coins: Int? { didSet { didSetCoins() }}

    public var buildHome: Bool? { didSet { didSetBuildHome() }}

    lazy var homeScrollView: UIScrollView = {
        var scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = AppAsset.background.color
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.bounces = true

        return scrollView
    }()

    // MARK: Header

    private lazy var walletBtn: WalletButton = {
        let wallet = WalletButton()
        wallet.btnTapped = walletBtnTapped

        return wallet
    }()

    private lazy var logoImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.brandNameColor.image
        imgView.contentMode = .scaleAspectFill

        return imgView
    }()

    private var profileBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.hero.id = Constants.HeroTransitionsID.welcomeTransition
        button.addTarget(self, action: #selector(profileDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    // MARK: Notifications

    public var notificationsView: NotificationsView?
    public var isNotificatonsHidden: Bool = false { didSet { didSetIsNotificatonsHidden() }}

    // MARK: Catalog

    public var catalogView: CatalogView?

    private lazy var catalogHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = AppAsset.background.color

        return view
    }()

    private lazy var catalogTitleLbl: UILabel = {
        var label = UILabel()
        LabelStyle.homeListTitle.apply(to: label)
        label.textAlignment = .left
        label.text = L10n.homeCatalog
        label.numberOfLines = 0

        return label
    }()

    private lazy var catalogShowAllLbl: UILabel = {
        var label = UILabel()
        LabelStyle.homeTitleShowAll.apply(to: label)
        label.textAlignment = .right
        label.text = L10n.homeShowAllCatalog
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(catalogShowAllDidTap(recognizer:)))
        tapGesture.delegate = self
        label.addGestureRecognizer(tapGesture)

        return label
    }()

    // MARK: Missions

    public var missionsView: MissionsListView?

    private lazy var noMissionsEmptyView: UIView = {
        let view = UIView()
        view.backgroundColor = AppAsset.background.color

        var label = UILabel()
        LabelStyle.noMissionsAvailable.apply(to: label)
        label.textAlignment = .center
        label.text = L10n.noMissionsAvailable

        view.addSubview(label)
        label.topAnchor /==/ view.topAnchor + 30
        label.centerXAnchor /==/ view.centerXAnchor

        return view
    }()

    private lazy var missionsHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = AppAsset.background.color

        return view
    }()

    lazy var missionsTitleLbl: UILabel = {
        var label = UILabel()
        LabelStyle.homeListTitle.apply(to: label)
        label.textAlignment = .left
        label.text = L10n.missions
        label.numberOfLines = 0

        return label
    }()

    private lazy var missionsShowAllLbl: UILabel = {
        var label = UILabel()
        LabelStyle.homeTitleShowAll.apply(to: label)
        label.textAlignment = .right
        label.text = L10n.homeShowAll
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(missionsShowAllDidTap(recognizer:)))
        tapGesture.delegate = self
        label.addGestureRecognizer(tapGesture)

        return label
    }()

    private lazy var missionsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppAsset.background.color

        return view
    }()

    private lazy var missionsBodyContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppAsset.background.color

        return view
    }()

    var noMissions: Bool? { didSet { didSetNoMissions() }}
    var userImg: UIImage? { didSet { didSetUserImg() }}

    private func didSetNoMissions() {
        guard let noMissions = noMissions else { return }

        if noMissions {
            missionsBodyContainerView.addSubview(noMissionsEmptyView)
            noMissionsEmptyView.topAnchor /==/ missionsHeaderView.bottomAnchor
            noMissionsEmptyView.widthAnchor /==/ missionsBodyContainerView.widthAnchor
            noMissionsEmptyView.bottomAnchor /==/ missionsBodyContainerView.bottomAnchor
            noMissionsEmptyView.heightAnchor /==/ 300
        } else {
            noMissionsEmptyView.removeFromSuperview()
        }
    }

    override func configureUI() {
        super.configureUI()

        backgroundColor = AppAsset.background.color

        addSubview(walletBtn)
        addSubview(logoImgView)
        addSubview(profileBtn)
        addSubview(homeScrollView)

        profileBtn.setImage(AppAsset.profilePlaceholder.image, for: .normal)

        missionsContainerView.addSubview(missionsBodyContainerView)
    }

    override func configureConstraints() {
        super.configureConstraints()

        UIDevice.current.hasNotch ? walletBtn.topAnchor /==/ topAnchor + 54 : walletBtn.topAnchor /==/ topAnchor + 40

        walletBtn.leadingAnchor /==/ leadingAnchor + 20
        walletBtn.heightAnchor /==/ 47

        logoImgView.topAnchor /==/ walletBtn.topAnchor
        logoImgView.centerXAnchor /==/ centerXAnchor
        logoImgView.heightAnchor /==/ 60
        logoImgView.widthAnchor /==/ 120

        profileBtn.topAnchor /==/ walletBtn.topAnchor
        profileBtn.trailingAnchor /==/ trailingAnchor - 20
        profileBtn.widthAnchor /==/ 47
        profileBtn.heightAnchor /==/ profileBtn.widthAnchor

        homeScrollView.topAnchor /==/ walletBtn.bottomAnchor + 25
        homeScrollView.leadingAnchor /==/ leadingAnchor
        homeScrollView.trailingAnchor /==/ trailingAnchor
        homeScrollView.bottomAnchor /==/ bottomAnchor
    }

    private func didSetBuildHome() {
        guard let notificationsView = notificationsView,
              let catalogView = catalogView,
              let missionsView = missionsView
        else { return }

        // MARK: - Notifications

        /// Add notifications section
        homeScrollView.addSubview(notificationsView)

        notificationsView.topAnchor /==/ homeScrollView.topAnchor
        notificationsView.widthAnchor /==/ homeScrollView.widthAnchor

        // MARK: - Catalog rewards

        // Catalog
        catalogHeaderView.addSubview(catalogTitleLbl)
        catalogHeaderView.addSubview(catalogShowAllLbl)

        homeScrollView.addSubview(catalogHeaderView)

        catalogHeaderView.topAnchor /==/ notificationsView.bottomAnchor
        catalogHeaderView.widthAnchor == homeScrollView.widthAnchor
        catalogHeaderView.heightAnchor /==/ 30

        catalogTitleLbl.topAnchor /==/ catalogHeaderView.topAnchor
        catalogTitleLbl.leadingAnchor /==/ catalogHeaderView.leadingAnchor + 20

        catalogShowAllLbl.centerYAnchor /==/ catalogTitleLbl.centerYAnchor
        catalogShowAllLbl.trailingAnchor /==/ catalogHeaderView.trailingAnchor - 20

        /// Add catalog section
        homeScrollView.addSubview(catalogView)

        catalogView.inHome = true
        catalogView.topAnchor /==/ catalogHeaderView.bottomAnchor + 10
        catalogView.heightAnchor /==/ 230
        catalogView.widthAnchor /==/ homeScrollView.widthAnchor
        catalogView.leadingAnchor /==/ homeScrollView.leadingAnchor + 20

        // MARK: - Missions

        missionsHeaderView.addSubview(missionsTitleLbl)
        missionsHeaderView.addSubview(missionsShowAllLbl)

        missionsBodyContainerView.addSubview(missionsHeaderView)
        missionsBodyContainerView.addSubview(missionsView)

        missionsHeaderView.topAnchor /==/ missionsBodyContainerView.topAnchor
        missionsHeaderView.leadingAnchor /==/ missionsBodyContainerView.leadingAnchor + 25
        missionsHeaderView.trailingAnchor /==/ missionsBodyContainerView.trailingAnchor - 25
        missionsHeaderView.heightAnchor /==/ 70

        missionsTitleLbl.centerYAnchor /==/ missionsHeaderView.centerYAnchor + 5
        missionsTitleLbl.leadingAnchor /==/ missionsHeaderView.leadingAnchor

        missionsShowAllLbl.centerYAnchor /==/ missionsTitleLbl.centerYAnchor
        missionsShowAllLbl.trailingAnchor /==/ missionsHeaderView.trailingAnchor

        missionsView.isHeaderHidden = true
        missionsView.missionsCollView.isScrollEnabled = false
        missionsView.topAnchor /==/ missionsHeaderView.bottomAnchor
        missionsView.widthAnchor /==/ missionsBodyContainerView.widthAnchor
        missionsView.bottomAnchor /==/ missionsBodyContainerView.bottomAnchor

        /// Add missions section
        homeScrollView.addSubview(missionsContainerView)

        missionsContainerView.topAnchor /==/ catalogView.bottomAnchor
        missionsContainerView.widthAnchor /==/ homeScrollView.widthAnchor
        missionsContainerView.bottomAnchor /==/ homeScrollView.bottomAnchor

        missionsBodyContainerView.topAnchor /==/ missionsContainerView.topAnchor + 35
        missionsBodyContainerView.leadingAnchor /==/ missionsContainerView.leadingAnchor
        missionsBodyContainerView.trailingAnchor /==/ missionsContainerView.trailingAnchor
        missionsBodyContainerView.bottomAnchor /==/ missionsContainerView.bottomAnchor
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        guard let catalogView = catalogView else { return }

        catalogView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 12)
        missionsBodyContainerView.roundCorners(corners: [.topLeft, .topRight], radius: 30)

        profileBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: profileBtn.bounds.width - profileBtn.bounds.height)
        profileBtn.imageView?.layer.cornerRadius = profileBtn.bounds.height / 2.0

        missionsContainerView.setGradientBackground(locations: [0.0, 1.0], colorTop: .clear, colorBottom: AppAsset.brandPositiveInfo.color.withAlphaComponent(0.10))
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    private func didSetIsNotificatonsHidden() {
        notificationsView?.removeFromSuperview()

        catalogHeaderView.topAnchor /==/ homeScrollView.topAnchor
    }

    private func didSetCoins() {
        walletBtn.coins = "5.700"
//        guard let coins = coins else { return }
//        walletBtn.coins = "\(coins)"
    }

    private func didSetUserImg() {
        guard let userImg = userImg else { return }

        profileBtn.setImage(userImg, for: .normal)
    }
}

extension HomeView {
    @objc func walletBtnTapped() {
        walletBtn.tapAnimation {
            self.walletTap.send()
        }
    }

    @objc func profileDidTap(_: UITapGestureRecognizer) {
        profileBtn.tapAnimation {
            self.profileTap.send()
        }
    }

    @objc func missionsShowAllDidTap(recognizer _: UIPanGestureRecognizer) {
        missionsShowAllLbl.tapAnimation {
            self.missionsShowAllTap.send()
        }
    }

    @objc func catalogShowAllDidTap(recognizer _: UIPanGestureRecognizer) {
        catalogShowAllLbl.tapAnimation {
            self.catalogShowAllTap.send()
        }
    }
}

public extension HomeView {
    func presentFeedback(result: (Bool?, String)) {
        var blackLayerView = UIView()
        blackLayerView.backgroundColor = AppAsset.brandPrimary.color.withAlphaComponent(0.5)

        var feedback: Feedback
        if let isSuccess = result.0, isSuccess {
            feedback = Feedback(height: 0.64)
            feedback.feedback = (true, result.1)

        } else {
            feedback = Feedback(height: 0.52)
            feedback.feedback = (false, "")
        }

        addSubview(blackLayerView)
        blackLayerView.edgeAnchors /==/ edgeAnchors
        blackLayerView.alpha = 0
        layoutIfNeeded()

        UIView.animate(withDuration: 0.3) {
            blackLayerView.alpha = 1
        } completion: { _ in
            blackLayerView.addSubview(feedback)

            feedback.closeButtonTap = {
                blackLayerView.removeFromSuperview()
            }

            feedback.shareButtonTap = {
                self.shareTap.send()
            }

            feedback.rightAnchor /==/ blackLayerView.rightAnchor - 20
            feedback.leftAnchor /==/ blackLayerView.leftAnchor + 20
            feedback.centerXAnchor /==/ blackLayerView.centerXAnchor
            feedback.centerYAnchor /==/ blackLayerView.centerYAnchor
            feedback.heightAnchor /==/ feedback.getHeight()

//            self.layoutIfNeeded()
        }
    }
}
