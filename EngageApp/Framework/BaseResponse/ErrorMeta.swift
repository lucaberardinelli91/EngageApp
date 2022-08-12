//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

struct ErrorMeta: Codable {
    let status: Int
    let errorName: String
    let errorDescription: String

    private enum CodingKeys: String, CodingKey {
        case status
        case errorName
        case errorDescription
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decode(Int.self, forKey: .status)
        errorName = try values.decode(String.self, forKey: .errorName)
        errorDescription = try values.decode(String.self, forKey: .errorDescription)
    }
}
