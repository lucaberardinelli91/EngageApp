//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import AVFoundation
import Foundation

public class HomeViewController: BasePackedViewController<HomeView, HomeViewModel> {
    public weak var homeCoordinator: HomeCoordinatorProtocol?

    public var notificationsVC: NotificationsViewController?
    public var catalogVC: CatalogViewController?
    public var missionsVC: MissionsListViewController?
    public var isNotificatonsHidden: Bool = false { didSet { didSetIsNotificatonsHidden() }}
    public var numMissions: Int? { didSet { didSetNumMissions() }}
    var feedback: (Bool?, String)? { didSet { didSetFeedback() }}
    var refreshControl = UIRefreshControl()
    var userInfo: UserInfo?

    override public init(viewModel: HomeViewModel) {
        super.init(viewModel: viewModel)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setInteractions()

        showLoader()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.hideLoader()
        }

//        getCampaign()
        loadHome()
        loadUserImage()
        configureBinds()

        /// pull to refresh home
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        _view.homeScrollView.addSubview(refreshControl)
    }

    override public func viewDidAppear(_: Bool) {
        loadUserImage()
    }

    private func didSetFeedback() {
        if let feedback = feedback {
            _view.presentFeedback(result: feedback)
        }
    }

    private func getCampaign() {
        viewModel.getCampaignId()
    }

    private func getUser() {
        viewModel.getUser()
    }

    private func setInteractions() {
        interaction(_view.walletTap) {
            self.homeCoordinator?.routeToWallet(self.userInfo?.coins ?? 0)
        }

        interaction(_view.profileTap) {
//            guard let userInfo = self.userInfo else { return }
//            self.homeCoordinator?.routeToProfile(userInfo)
            self.homeCoordinator?.routeToProfile(UserInfo())
        }

        interaction(_view.catalogShowAllTap) {
            self.homeCoordinator?.routeToCatalog(self.userInfo?.coins ?? 0)
        }

        interaction(_view.missionsShowAllTap) {
            self.homeCoordinator?.routeToMissions(self.userInfo?.coins ?? 0)
        }

        interaction(_view.shareTap) { _ in
            self.viewModel.shareFeedback()
        }
    }

    private func didSetIsNotificatonsHidden() {
        _view.isNotificatonsHidden = isNotificatonsHidden
    }

    private func didSetNumMissions() {
        guard let numMissions = numMissions else { return }
        _view.noMissions = numMissions == 0 ? true : false
    }

    private func loadHome() {
        guard let notificationsVC = notificationsVC,
              let catalogVC = catalogVC,
              let missionsVC = missionsVC
        else { return }

        /// Notifications section
        addChild(notificationsVC)
        _view.notificationsView = (notificationsVC.view as! NotificationsView)

        /// Catalog section
        addChild(catalogVC)
        _view.catalogView = (catalogVC.view as! CatalogView)

        /// Missions section
        missionsVC.inHome = true
        missionsVC.getMissions()
        addChild(missionsVC)
        _view.missionsView = (missionsVC.view as! MissionsListView)
        _view.buildHome = true
    }

    @objc func pullToRefresh() {
        notificationsVC?.getNotifications()
        catalogVC?.getCatalog()
        missionsVC?.getMissions()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.missionsVC?.getMissions()
            self.refreshControl.endRefreshing()
        }
    }

    private func setCoins() {
        self._view.coins = 5700
//        guard let userInfo = userInfo else { return }
//        self._view.coins = userInfo.coins
    }

    private func loadUserImage() {
        guard let userImg = UIImage.loadImageFromDocumentDirectory(nameOfImage: "user_image") else { return }
        _view.userImg = userImg
    }
}

extension HomeViewController {
    private func configureBinds() {
        /// Check if campaign id already exists
        handle(viewModel.$getCampaignIdState, success: { [self] _ in
            getUser()
            loadHome()
        }, failure: { [self] _ in
            viewModel.getCampaign()
        })

        /// Retrieve campaign info
        handle(viewModel.$getCampaignState, success: { [self] campaign in
            viewModel.saveCampaignId(id: campaign.id ?? "")
        }, failure: { error in
            print("[ERROR] get campaign: \(error)")
        })

        /// Save campaign info locally
        handle(viewModel.$saveCampaignIdState, success: { [self] _ in
            getUser()
            loadHome()
        }, failure: { error in
            print("[ERROR] save campaign id: \(error)")
        })

        /// Get user info from api
        handle(viewModel.$getUserState, success: { [self] user in
            userInfo = user
            setCoins()
            catalogVC?.coins = user.coins
            notificationsVC?.coins = user.coins
            viewModel.saveUserLocal()
        }, failure: { error in
            print("[ERROR] get user info: \(error)")
        })
    }
}
