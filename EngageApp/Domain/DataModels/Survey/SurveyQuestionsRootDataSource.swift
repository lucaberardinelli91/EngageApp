//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct SurveyQuestionsRootDataSource: Decodable {
    public let questions: [SurveyQuestionsDataSourceModel]?

    private enum RootKeys: String, CodingKey {
        case data
    }

    public init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: RootKeys.self)
        questions = try? container?.decode([SurveyQuestionsDataSourceModel].self, forKey: .data)
    }
}
