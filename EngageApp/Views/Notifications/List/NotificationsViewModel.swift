//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import UIKit

public protocol NotificationsViewModelProtocol {
    func getNotifications()
}

public class NotificationsViewModel: BaseViewModel, NotificationsViewModelProtocol {
    @Published var getNotificationsState: LoadingState<[Notification], CustomError> = .idle
    private let getNotificationsUseCase: GetNotificationsProtocol

    public init(getNotificationsUseCase: GetNotificationsProtocol) {
        self.getNotificationsUseCase = getNotificationsUseCase
    }

    public func getNotifications() {
        // MOCK API
        getNotificationsState = .success(Notification.getNotifications())
//        getNotificationsState = .loading
//
//        getNotificationsUseCase.execute()
//            .receive(on: RunLoop.main)
//            .sink { completion in
//                guard case let .failure(error) = completion else { return }
//                self.getNotificationsState = .failure(error)
//            } receiveValue: { [self] notifications in
//                guard let notifications = notifications else { return }
//                getNotificationsState = .success(notifications)
//            }.store(in: &cancellables)
    }
}
