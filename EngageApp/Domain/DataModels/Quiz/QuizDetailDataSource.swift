//
//  EngageApp
//  Created by Luca Berardinelli
//

public struct QuizDetailDataSource: Decodable {
    let questions_count: Int?
    let max_seconds_per_question: Int?

    private enum RootKeys: String, CodingKey {
        case data
    }

    private enum CodingKeys: String, CodingKey {
        case questions_count
        case max_seconds_per_question
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        questions_count = try data.decodeIfPresent(Int.self, forKey: .questions_count)
        max_seconds_per_question = try data.decodeIfPresent(Int.self, forKey: .max_seconds_per_question)
    }
}
