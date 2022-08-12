//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct NotificationDataSource: Decodable, Hashable {
    public var id: String?
    public var type: String?
    public var external_id: String?
    public var campaign_id: String?
    public var created_at: String?
    public var updated_at: String?
    public var deleted_at: String?
    public var text: String?

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case external_id
        case campaign_id
        case created_at
        case updated_at
        case deleted_at
        case text
    }

    public init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
        type = try? values?.decodeIfPresent(String.self, forKey: .type)
        external_id = try? values?.decodeIfPresent(String.self, forKey: .external_id)
        campaign_id = try? values?.decodeIfPresent(String.self, forKey: .campaign_id)
        created_at = try? values?.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try? values?.decodeIfPresent(String.self, forKey: .updated_at)
        deleted_at = try? values?.decodeIfPresent(String.self, forKey: .deleted_at)
        text = try? values?.decodeIfPresent(String.self, forKey: .text)
    }

    public static func == (lhs: NotificationDataSource, rhs: NotificationDataSource) -> Bool {
        return lhs.id == rhs.id
    }
}
