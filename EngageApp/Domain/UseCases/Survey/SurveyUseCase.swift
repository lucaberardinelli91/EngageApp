//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol GetSurveyQuestionsProtocol {
    func execute(surveyId: String) -> AnyPublisher<[SurveyQuestion]?, CustomError>
}

public protocol SendSurveyQuestionsProtocol {
    func execute(surveyId: String, surveyRequest: SurveyPostRequest) -> AnyPublisher<EmptyResponse, CustomError>
}

enum SurveyUseCase {
    public class GetSurveyQuestions: GetSurveyQuestionsProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var surveyRepository: SurveyRepositoryProtocol

        public init(surveyRepository: SurveyRepositoryProtocol) {
            self.surveyRepository = surveyRepository
        }

        func execute(surveyId: String) -> AnyPublisher<[SurveyQuestion]?, CustomError> {
            surveyRepository.getSurveyQuestions(surveyId: surveyId)
        }
    }

    public class SendSurveyQuestions: SendSurveyQuestionsProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var surveyRepository: SurveyRepositoryProtocol

        public init(surveyRepository: SurveyRepositoryProtocol) {
            self.surveyRepository = surveyRepository
        }

        func execute(surveyId: String, surveyRequest: SurveyPostRequest) -> AnyPublisher<EmptyResponse, CustomError> {
            surveyRepository.surveySend(surveyId: surveyId, surveyRequest: surveyRequest)
        }
    }
}
