//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

class QuizRepository: QuizRepositoryProtocol {
    private var networkingWorker: NetworkingDataSourceProtocol
    private var localStorageWorker: UserProtocol
    private var cancellables = Set<AnyCancellable>()

    public init(networkingWorker: NetworkingDataSourceProtocol, localStorageWorker: UserProtocol) {
        self.networkingWorker = networkingWorker
        self.localStorageWorker = localStorageWorker
    }

    func getDetailQuiz(quizId: String) -> AnyPublisher<QuizDetail, CustomError> {
        let campaignId = localStorageWorker.getCampaignId()
        return networkingWorker.getDetailQuiz(campaignId: campaignId, quizId: quizId)
    }

    func getNextQuestion(quizId: String) -> AnyPublisher<Question, CustomError> {
        let campaignId = localStorageWorker.getCampaignId()
        return networkingWorker.getNextQuestion(campaignId: campaignId, quizId: quizId)
    }

    func postAnswer(answer: AnswerRequest, quizId: String) -> AnyPublisher<QuizResponse, CustomError> {
        let campaignId = localStorageWorker.getCampaignId()
        return networkingWorker.postAnswer(campaignId: campaignId, quizId: quizId, answer: answer)
    }
}
