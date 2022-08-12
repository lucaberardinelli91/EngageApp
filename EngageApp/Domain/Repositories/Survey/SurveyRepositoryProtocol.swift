//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol SurveyRepositoryProtocol {
    func getSurveyQuestions(surveyId: String) -> AnyPublisher<[SurveyQuestion]?, CustomError>
    func surveySend(surveyId: String, surveyRequest: SurveyPostRequest) -> AnyPublisher<EmptyResponse, CustomError>
}
