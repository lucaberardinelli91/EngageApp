//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import Foundation
import UIKit

public class WalletListViewController: BasePackedViewController<WalletListView, WalletListViewModel> {
    private var walletDataProvider: WalletListDataProvider?
    private var refreshControl = UIRefreshControl()
    var isInMission: Bool = false
    var coins: Int?

    public weak var walletCoordinator: WalletCoordinatorProtocol?

    override public init(viewModel: WalletListViewModel) {
        super.init(viewModel: viewModel)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        setDataProvider()
        setInteractions()
        configureBinds()
        getWallet()
        setCoins()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    public func getWallet() {
        viewModel.getWallet()
    }

    private func setInteractions() {
        interaction(_view.earnCoinsTap) {
            self.dismiss(animated: true) {
                self.isInMission ? self.dismiss(animated: true, completion: nil) : self.walletCoordinator?.routeToMissions()
            }
        }

        interaction(_view.dismiss) {
            self.dismiss(animated: true, completion: nil)
        }
    }

    private func setCoins() {
        _view.coins = viewModel.coins
    }
}

extension WalletListViewController {
    private func configureBinds() {
        handle(viewModel.$getWalletState, success: { transactions in
            self.refreshControl.endRefreshing()
            self.walletDataProvider?.applySnapshot(entries: transactions)
        }, failure: { _ in
            self.refreshControl.endRefreshing()
        })
    }

    private func setDataProvider() {
        let collectionView = _view.walletView.walletCollView
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        walletDataProvider = WalletListDataProvider(collectionView: collectionView)
    }

    @objc private func refresh(_: AnyObject) {
        getWallet()
    }
}
