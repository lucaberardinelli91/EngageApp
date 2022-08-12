//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct Missions: Decodable {
    public let tasks: [Mission]?

    enum RootKeys: String, CodingKey {
        case data
    }

    enum CodingKeys: String, CodingKey {
        case tasks
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        tasks = try data.decodeIfPresent([Mission].self, forKey: .tasks)
    }
}
