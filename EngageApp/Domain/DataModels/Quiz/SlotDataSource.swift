//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

struct SlotDataSource: Decodable {
    let id: Int?
    let totalQuestions: Int?

    private enum CodingKeys: String, CodingKey {
        case id
        case totalQuestions
    }

    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(Int.self, forKey: .id)
        totalQuestions = try? values?.decodeIfPresent(Int.self, forKey: .totalQuestions)
    }
}
