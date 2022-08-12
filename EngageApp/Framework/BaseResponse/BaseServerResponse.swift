//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

struct BaseServerResponse: Decodable {
    let meta: ErrorMeta

    private enum CodingKeys: String, CodingKey {
        case meta
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        meta = try values.decode(ErrorMeta.self, forKey: .meta)
    }
}
