//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct SurveyAnswer: Decodable {
    public let id: String?
    public let text: String?
    public let media: String?
    public let percentage: Float

    public init(id: String, text: String, media: String, percentage: Float) {
        self.id = id
        self.text = text
        self.media = media
        self.percentage = percentage
    }

    public init(surveyAnswerDataSourceModel: SurveyAnswerDataSourceModel) {
        id = surveyAnswerDataSourceModel.id
        text = surveyAnswerDataSourceModel.text
        media = surveyAnswerDataSourceModel.image
        percentage = surveyAnswerDataSourceModel.percentage ?? 0
    }
}
