//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct SurveyQuestionDataSourceModel: Decodable {
    let id: Int?
    let answers: [SurveyAnswerDataSourceModel]?
    let text: String?
    let answerType: String?
    let image: String?

    private enum CodingKeys: String, CodingKey {
        case answers = "surveyAnswers"
        case text
        case answerType = "type"
        case image
        case id
    }

    public init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        answers = try? values?.decodeIfPresent([SurveyAnswerDataSourceModel].self, forKey: .answers)
        text = try? values?.decodeIfPresent(String.self, forKey: .text)
        answerType = try? values?.decodeIfPresent(String.self, forKey: .answerType)
        image = try? values?.decodeIfPresent(String.self, forKey: .image)
        id = try? values?.decodeIfPresent(Int.self, forKey: .id)
    }
}
