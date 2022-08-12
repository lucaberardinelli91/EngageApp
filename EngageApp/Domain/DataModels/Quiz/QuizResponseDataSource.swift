//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct QuizResponseDataSource: Decodable {
    let correct: Bool?
    let points: Int?

    private enum RootKeys: String, CodingKey {
        case data
    }

    private enum CodingKeys: String, CodingKey {
        case correct
        case points
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        correct = try data.decodeIfPresent(Bool.self, forKey: .correct)
        points = try data.decodeIfPresent(Int.self, forKey: .points)
    }
}
