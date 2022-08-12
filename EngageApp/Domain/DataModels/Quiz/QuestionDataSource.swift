//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct QuestionDataSource: Decodable {
    let id: String?
    let question: String?
    let image: String?
    let answers: [AnswerDataSource]?

    private enum RootKeys: String, CodingKey {
        case data
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case question
        case image
        case answers
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        id = try data.decodeIfPresent(String.self, forKey: .id)
        question = try data.decodeIfPresent(String.self, forKey: .question)
        image = try data.decodeIfPresent(String.self, forKey: .image)
        answers = try data.decode([AnswerDataSource].self, forKey: .answers)
    }
}
