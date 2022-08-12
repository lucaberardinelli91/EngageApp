//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct AnswerToSend {
    public var type: SurveyAnswerType
    public var questionId: String
    public var answerIDs: [String]?
    public var answerText: String?

    public init(type: SurveyAnswerType, questionId: String, answerIDs: [String]?, answerText: String?) {
        self.type = type
        self.questionId = questionId
        self.answerIDs = answerIDs
        self.answerText = answerText
    }
}
