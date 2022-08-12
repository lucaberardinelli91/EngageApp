//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol GetNotificationsProtocol {
    func execute() -> AnyPublisher<[Notification]?, CustomError>
}

enum NotificationsUseCase {
    class GetNotifications: GetNotificationsProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var notificationsRepository: NotificationsRepositoryProtocol

        public init(notificationsRepository: NotificationsRepositoryProtocol) {
            self.notificationsRepository = notificationsRepository
        }

        func execute() -> AnyPublisher<[Notification]?, CustomError> {
            notificationsRepository.getNotifications()
        }
    }
}
