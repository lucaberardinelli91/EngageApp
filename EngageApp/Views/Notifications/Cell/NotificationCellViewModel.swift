//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol NotificationsCellViewModelProtocol {
    func getInfo()
}

public class NotificationCellViewModel: NotificationsCellViewModelProtocol {
    private var notifications: Notification

    @Published var notificationCollectionViewCellState: LoadingState<Notification, CustomError> = .idle

    public init(configurator: Notification) {
        notifications = configurator
    }

    public func getInfo() {
        notificationCollectionViewCellState = .success(notifications)
    }
}
