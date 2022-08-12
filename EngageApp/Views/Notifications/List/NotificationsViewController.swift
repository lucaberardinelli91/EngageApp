//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import Foundation
import UIKit

public class NotificationsViewController: BasePackedViewController<NotificationsView, NotificationsViewModel> {
    public weak var notificationsCoordinator: NotificationsCoordinatorProtocol?
    private var notificationsDataProvider: NotificationsDataProvider?
    private var refreshControl = UIRefreshControl()
    public var coins: Int?

    override public init(viewModel: NotificationsViewModel) {
        super.init(viewModel: viewModel)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        setDataProvider()
        configureBinds()
        setInteractions()
        getNotifications()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    public func getNotifications() {
        viewModel.getNotifications()
    }
}

extension NotificationsViewController {
    private func configureBinds() {
        handle(viewModel.$getNotificationsState, success: { notifications in
            self.refreshControl.endRefreshing()
            notifications.isEmpty ? (self.parent as! HomeViewController).isNotificatonsHidden = true : self.notificationsDataProvider?.applySnapshot(entries: notifications)
        }, failure: { _ in
            self.refreshControl.endRefreshing()
        })
    }

    private func setInteractions() {
        interaction(_view.notificationDidTap) { indexPath in
            let itemSelected = self.notificationsDataProvider?.dataSource.itemIdentifier(for: indexPath)

            guard let type = itemSelected?.model.notification?.type else { return }

            switch type {
            case NotificationType.missionList.rawValue:
                self.notificationsCoordinator?.routeToMissionList(self.coins ?? 0)
            case NotificationType.rewardList.rawValue:
                self.notificationsCoordinator?.routeToCatalog(self.coins ?? 0)
            case NotificationType.profile.rawValue:
                self.notificationsCoordinator?.routeToProfile()
            default:
                break
            }
        }
    }

    private func setDataProvider() {
        let collectionView = _view.notificationsCollView
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        notificationsDataProvider = NotificationsDataProvider(collectionView: collectionView)
    }

    @objc private func refresh(_: AnyObject) {
        getNotifications()
    }
}
