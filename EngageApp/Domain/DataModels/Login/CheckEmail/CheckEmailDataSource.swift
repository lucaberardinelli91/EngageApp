//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct CheckEmailDataSource: Decodable {
    public let otp: String

    private enum RootKeys: String, CodingKey {
        case data
    }

    private enum NestedKeys: String, CodingKey {
        case otp
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        let data = try container.nestedContainer(keyedBy: NestedKeys.self, forKey: .data)
        otp = try data.decode(String.self, forKey: .otp)
    }
}
