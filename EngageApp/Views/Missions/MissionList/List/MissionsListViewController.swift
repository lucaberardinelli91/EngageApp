//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import Foundation
import UIKit

public class MissionsListViewController: BasePackedViewController<MissionsListView, MissionsListViewModel> {
    public weak var missionsCoordinator: MissionsCoordinatorProtocol?
    public weak var homeCoordinator: HomeCoordinatorProtocol?
    public weak var launcherCoordinator: LauncherCoordinatorProtocol?
    private var missionsDataProvider: MissionsListDataProvider?
    public var inHome = false
    private var refreshControl = UIRefreshControl()

    override public init(viewModel: MissionsListViewModel) {
        super.init(viewModel: viewModel)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        setDataProvider()
        configureBinds()
        setInteractions()
        getMissions()
        bindView()
        setCoins()

        /// pull to refrsh home
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        _view.missionsCollView.addSubview(refreshControl)
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    public func getMissions() {
        viewModel.getMissions()
    }

    private func bindView() {
        _view.isHeaderHidden = false
    }

    @objc func pullToRefresh() {
        getMissions()
        refreshControl.endRefreshing()
    }

    private func setCoins() {
        _view.coins = viewModel.coins
    }
}

extension MissionsListViewController {
    private func configureBinds() {
        handle(viewModel.$getMissionsState, success: { [self] missions in
            self.missionsDataProvider?.applySnapshot(entries: missions, inHome: inHome)
            self.missionsDataProvider?.numItems = { numItems in
                self._view.numMissions = numItems
                (self.parent as? HomeViewController)?.numMissions = numItems
            }
        }, failure: { error in
            print("[ERROR] get missions: \(error)")
        })
    }

    private func setInteractions() {
        interaction(_view.missionDidTap) { indexPath in
            let itemSelected = self.missionsDataProvider?.dataSource.itemIdentifier(for: indexPath)

            /// Check if missions controller is used in home
            (self.homeCoordinator == nil) ?
                self.missionsCoordinator?.routeToMission(itemSelected?.model.mission) :
                self.homeCoordinator?.routeToMission(itemSelected?.model.mission)
        }

        interaction(_view.collectionViewScroll) { scrollDirection in
            self._view.scrollByView(direction: scrollDirection)
        }

        interaction(_view.walletTap) {
            self.missionsCoordinator?.routeToWallet(self.viewModel.coins ?? 0)
        }

        interaction(_view.closeTap) {
            self.dismiss(animated: true)
        }
    }

    private func setDataProvider() {
        let collectionView = _view.missionsCollView
        missionsDataProvider = MissionsListDataProvider(collectionView: collectionView)
    }

    @objc private func refresh(_: AnyObject) {
        getMissions()
    }
}
