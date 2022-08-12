//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct SurveyQuestionsDataSourceModel: Decodable, Hashable {
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

    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case order
        case attribute
        case extends_profile
        case label
        case parent_survey_question_id
        case survey_id
        case created_at
        case updated_at
        case deleted_at
        case image
        case text
        case options
    }

    public init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
        type = try? values?.decodeIfPresent(String.self, forKey: .type)
        order = try? values?.decodeIfPresent(Int.self, forKey: .order)
        attribute = try? values?.decodeIfPresent(String.self, forKey: .attribute)
        extendsProfile = try? values?.decodeIfPresent(Bool.self, forKey: .extends_profile)
        label = try? values?.decodeIfPresent(String.self, forKey: .label)
        parentSurveyQuestionId = try? values?.decodeIfPresent(String.self, forKey: .parent_survey_question_id)
        surveyId = try? values?.decodeIfPresent(String.self, forKey: .survey_id)
        createdAt = try? values?.decodeIfPresent(String.self, forKey: .created_at)
        updatedAt = try? values?.decodeIfPresent(String.self, forKey: .updated_at)
        deletedAt = try? values?.decodeIfPresent(String.self, forKey: .deleted_at)
        image = try? values?.decodeIfPresent(String.self, forKey: .image)
        text = try? values?.decodeIfPresent(String.self, forKey: .text)
        options = try? values?.decodeIfPresent([SurveyQuestionOption].self, forKey: .options)
    }

    public static func == (lhs: SurveyQuestionsDataSourceModel, rhs: SurveyQuestionsDataSourceModel) -> Bool {
        return lhs.id == rhs.id
    }
}

public struct SurveyQuestionOption: Decodable, Hashable {
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

    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case order
        case attribute
        case extends_profile
        case label
        case parent_survey_question_id
        case survey_id
        case created_at
        case updated_at
        case deleted_at
        case image
        case text
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        attribute = try values.decodeIfPresent(String.self, forKey: .attribute)
        extendsProfile = try values.decodeIfPresent(Bool.self, forKey: .extends_profile)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        parentSurveyQuestionId = try values.decodeIfPresent(String.self, forKey: .parent_survey_question_id)
        surveyId = try values.decodeIfPresent(String.self, forKey: .survey_id)
        createdAt = try values.decodeIfPresent(String.self, forKey: .created_at)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updated_at)
        deletedAt = try values.decodeIfPresent(String.self, forKey: .deleted_at)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        text = try values.decodeIfPresent(String.self, forKey: .text)
    }
}
