//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

// MARK: - SurveyPostRequest

public struct SurveyPostRequest: Encodable {
    var answers: [SurveyPostRequestModel]

    init(answers: [SurveyPostRequestModel]) {
        self.answers = answers
    }
}

class SurveyPostRequestModel: Encodable {}

class SurveyPostRequestSingleModel: SurveyPostRequestModel {
    var id: String
    var answer: String

    init(id: String, answer: String) {
        self.id = id
        self.answer = answer
    }

    public enum CodingKeys: String, CodingKey {
        case id, answer
    }

    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encodeIfPresent(id, forKey: .id)
        try? container.encodeIfPresent(answer, forKey: .answer)
    }
}

class SurveyPostRequestMultiModel: SurveyPostRequestModel {
    var id: String
    var answer: [String]

    init(id: String, answer: [String]) {
        self.id = id
        self.answer = answer
    }

    public enum CodingKeys: String, CodingKey {
        case id, answer
    }

    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encodeIfPresent(id, forKey: .id)
        try? container.encodeIfPresent(answer, forKey: .answer)
    }
}
