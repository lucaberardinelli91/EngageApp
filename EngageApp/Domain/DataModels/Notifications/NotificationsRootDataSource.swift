//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct NotificationsRootDataSource: Decodable {
    public let notifications: [NotificationDataSource]?

    private enum RootKeys: String, CodingKey {
        case data
    }

    public init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: RootKeys.self)
        notifications = try? container?.decode([NotificationDataSource].self, forKey: .data)
    }
}
