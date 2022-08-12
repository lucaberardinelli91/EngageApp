//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol NotificationsAssemblerInjector {
    func resolve() -> NotificationsViewController

    func resolve() -> NotificationsViewModel
}

public class NotificationsAssembler: NSObject, NotificationsAssemblerInjector {
    var container: MainContainerProtocol

    public init(container: MainContainerProtocol) {
        self.container = container
    }
}

public extension NotificationsAssembler {
    func resolve() -> NotificationsViewController {
        return NotificationsViewController(viewModel: resolve())
    }

    func resolve() -> NotificationsViewModel {
        return NotificationsViewModel(getNotificationsUseCase: container.getNotifications)
    }
}
