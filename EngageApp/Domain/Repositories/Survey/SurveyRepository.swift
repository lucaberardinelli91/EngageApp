//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

class SurveyRepository: SurveyRepositoryProtocol {
    private var networkingWorker: NetworkingDataSourceProtocol
    private var localStorageWorker: UserProtocol

    private var cancellables = Set<AnyCancellable>()

    public init(networkingWorker: NetworkingDataSourceProtocol, localStorageWorker: UserProtocol) {
        self.networkingWorker = networkingWorker
        self.localStorageWorker = localStorageWorker
    }

    func getSurveyQuestions(surveyId: String) -> AnyPublisher<[SurveyQuestion]?, CustomError> {
        let campaignId = localStorageWorker.getCampaignId()
        return networkingWorker.getSurveyQuestions(campaignId: campaignId, surveyId: surveyId)
    }

    func surveySend(surveyId: String, surveyRequest: SurveyPostRequest) -> AnyPublisher<EmptyResponse, CustomError> {
        let campaignId = localStorageWorker.getCampaignId()
        return networkingWorker.surveySend(campaignId: campaignId, surveyId: surveyId, surveyRequest: surveyRequest)
    }
}
