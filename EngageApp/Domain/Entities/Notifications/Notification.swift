//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct Notification: Decodable, Hashable {
    public var id: String?
    public var type: String?
    public var external_id: String?
    public var campaign_id: String?
    public var created_at: String?
    public var updated_at: String?
    public var deleted_at: String?
    public var text: String?
    
    public init(notificationDataSource: NotificationDataSource) {
        id = notificationDataSource.id
        type = notificationDataSource.type
        external_id = notificationDataSource.external_id
        campaign_id = notificationDataSource.campaign_id
        created_at = notificationDataSource.created_at
        updated_at = notificationDataSource.updated_at
        deleted_at = notificationDataSource.deleted_at
        text = notificationDataSource.text
    }
    
    static func getNotifications() -> [Notification] {
        return [Notification(1),
                Notification(2),
                Notification(3)]
    }
    
    public init(_ count: Int) {
        switch count {
        case 1:
            self.id = "f1903890-0033-11ed-ac35-594281c7fd87"
            self.type = "mission-general"
            self.external_id = ""
            self.campaign_id = "bc4fec10-e744-11ec-affa-1329312dd338"
            self.created_at = "2022-07-10 09:37:41"
            self.updated_at = "2022-07-10 09:37:41"
            self.deleted_at = ""
            self.text = "Gioca ad una nuova missione"
        case 2:
            self.id = "f1903890-0033-11ed-ac35-594281c7fd87"
            self.type = "reward-general"
            self.external_id = ""
            self.campaign_id = "bc4fec10-e744-11ec-affa-1329312dd338"
            self.created_at = "2022-07-10 09:37:41"
            self.updated_at = "2022-07-10 09:37:41"
            self.deleted_at = ""
            self.text = "Scopri i nuovi premi"
        case 3:
            self.id = "f1903890-0033-11ed-ac35-594281c7fd87"
            self.type = "profile-general"
            self.external_id = ""
            self.campaign_id = "bc4fec10-e744-11ec-affa-1329312dd338"
            self.created_at = "2022-07-10 09:37:41"
            self.updated_at = "2022-07-10 09:37:41"
            self.deleted_at = ""
            self.text = "Aggiorna il tuo proifilo"
        default: break
        }
    }
    
    public static func == (lhs: Notification, rhs: Notification) -> Bool {
        return lhs.id == rhs.id
    }
}
