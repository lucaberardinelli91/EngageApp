//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol NotificationsRepositoryProtocol {
    func getNotifications() -> AnyPublisher<[Notification]?, CustomError>
}
