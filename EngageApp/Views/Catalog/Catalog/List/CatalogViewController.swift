//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import Foundation
import UIKit
public class CatalogViewController: BasePackedViewController<CatalogView, CatalogViewModel> {
    public weak var catalogCoordinator: CatalogCoordinatorProtocol?
    public weak var homeCoordinator: HomeCoordinatorProtocol?
    private var catalogDataProvider: CatalogDataProvider?
    private var refreshControl = UIRefreshControl()
    public var coins: Int?

    override public init(viewModel: CatalogViewModel) {
        super.init(viewModel: viewModel)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        setDataProvider()
        configureBinds()
        setInteractions()
        getCatalog()
        bindView()
        setCoins()

        /// pull to refrsh home
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        _view.catalogCollView.addSubview(refreshControl)
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    public func getCatalog() {
        viewModel.getCatalog()
    }

    private func bindView() {
        _view.inHome = false
    }

    @objc func pullToRefresh() {
        getCatalog()
        refreshControl.endRefreshing()
    }

    private func setCoins() {
        _view.coins = viewModel.coins
    }
}

extension CatalogViewController {
    private func configureBinds() {
        handle(viewModel.$getCatalogState, success: { rewards in
            self.refreshControl.endRefreshing()
            self.catalogDataProvider?.applySnapshot(entries: rewards)
        }, failure: { _ in
            self.refreshControl.endRefreshing()
        })
    }

    private func setInteractions() {
        interaction(_view.rewardDidTap) { indexPath in
            let itemSelected = self.catalogDataProvider?.dataSource.itemIdentifier(for: indexPath)

            guard let reward = itemSelected?.model.reward else { return }

            /// Check if catalog controller is used in home
            (self.homeCoordinator == nil) ?
                self.catalogCoordinator?.routeToReward(reward) :
                self.homeCoordinator?.routeToReward(reward, self.coins ?? 0)
        }

        interaction(_view.walletTap) {
            self.catalogCoordinator?.routeToWallet(self.viewModel.coins ?? 0)
        }

        interaction(_view.closeTap) {
            self.viewModel.fromRedeem ? self.catalogCoordinator?.routeToHome() : self.dismiss(animated: true)
        }
    }

    private func setDataProvider() {
        let collectionView = _view.catalogCollView
        catalogDataProvider = CatalogDataProvider(collectionView: collectionView)
    }

    @objc private func refresh(_: AnyObject) {
        getCatalog()
    }
}
