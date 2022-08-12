//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

struct QuestionQuizDataSource: Decodable {
    let id: String?
    let text: String?
    let answers: [AnswerDataSource]?

    private enum CodingKeys: String, CodingKey {
        case id
        case text
        case answers = "quizAnswers"
    }

    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
        text = try? values?.decodeIfPresent(String.self, forKey: .text)
        answers = try? values?.decodeIfPresent([AnswerDataSource].self, forKey: .answers)
    }
}
