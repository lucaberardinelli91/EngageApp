//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public enum SurveyAnswerType: String {
    case select
    case multiSelect
    case text
    case unknown

    init(_ string: String) {
        switch string {
        case "select":
            self = .select
        case "multi-select":
            self = .multiSelect
        case "text":
            self = .text
        default:
            self = .unknown
        }
    }
}

public struct SurveyQuestion: Decodable, Hashable {
    public let id: String?
    public let type: String?
    public let order: Int?
    public let attribute: String?
    public let extendsProfile: Bool?
    public let label: String?
    public let parentSurveyQuestionId: String?
    public let surveyId: String?
    public let createdAt: String?
    public let updatedAt: String?
    public let deletedAt: String?
    public let image: String?
    public let text: String?
    public let options: [SurveyQuestionOption]?
    public var answers: [SurveyAnswer] = []

    public init(surveyQuestionDataSource: SurveyQuestionsDataSourceModel) {
        id = surveyQuestionDataSource.id
        type = surveyQuestionDataSource.type
        order = surveyQuestionDataSource.order
        attribute = surveyQuestionDataSource.attribute
        extendsProfile = surveyQuestionDataSource.extendsProfile
        label = surveyQuestionDataSource.label
        parentSurveyQuestionId = surveyQuestionDataSource.parentSurveyQuestionId
        surveyId = surveyQuestionDataSource.surveyId
        createdAt = surveyQuestionDataSource.createdAt
        updatedAt = surveyQuestionDataSource.updatedAt
        deletedAt = surveyQuestionDataSource.deletedAt
        image = surveyQuestionDataSource.image
        text = surveyQuestionDataSource.text
        options = surveyQuestionDataSource.options
        options?.forEach { option in
            let answer = SurveyAnswer(id: option.id ?? "",
                                      text: option.text!,
                                      media: option.image ?? "",
                                      percentage: 0.25)
            self.answers.append(answer)
        }
    }

    public static func == (lhs: SurveyQuestion, rhs: SurveyQuestion) -> Bool {
        return lhs.id == rhs.id
    }

    /// Return sorted answers by percentage
    public func getSortedAnswers() -> [SurveyAnswer]? {
        let sortedAnswers = answers.sorted(by: { answer0, answer1 in
            answer0.percentage > answer1.percentage
        })

        return sortedAnswers
    }

    /// Return `true` if the first and the second answers have the same `percentage`
    public func isAnswersDrawn() -> Bool {
        let sortedAnswers = getSortedAnswers()

        return sortedAnswers?.getElement(at: 0)?.percentage == sortedAnswers?.getElement(at: 1)?.percentage
    }
}
