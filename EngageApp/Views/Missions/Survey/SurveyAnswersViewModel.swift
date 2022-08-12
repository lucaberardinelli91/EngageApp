//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import UIKit

public protocol SurveyAnswersViewModelProtocol {
    func getSurveyQuestions()
    func getQuestionsNumber() -> Int
    func insertAnswerToSend(answerToSend: AnswerToSend)
    func sendSurvey()
}

public class SurveyAnswersViewModel: BaseViewModel, SurveyAnswersViewModelProtocol {
    @Published var sendSurveyState: LoadingState<Void, CustomError> = .idle
    @Published var getSurveyQuestionsState: LoadingState<[SurveyQuestion]?, CustomError> = .idle

    private var getSurveyQuestionsUseCase: GetSurveyQuestionsProtocol
    private var sendSurveyQuestionsUseCase: SendSurveyQuestionsProtocol

    private var answersToSend: [AnswerToSend] = []
    private var questionsNumber = 0
    private var surveyID: String

    public init(surveyID: String, getSurveyQuestionsUseCase: GetSurveyQuestionsProtocol, sendSurveyQuestionsUseCase: SendSurveyQuestionsProtocol) {
        self.surveyID = surveyID
        self.getSurveyQuestionsUseCase = getSurveyQuestionsUseCase
        self.sendSurveyQuestionsUseCase = sendSurveyQuestionsUseCase
    }

    public func getSurveyQuestions() {
        getSurveyQuestionsState = .loading

        getSurveyQuestionsUseCase.execute(surveyId: surveyID)
            .receive(on: RunLoop.main)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.getSurveyQuestionsState = .failure(error)
            } receiveValue: { [self] questions in
                guard let questions = questions else { return }
                questionsNumber = questions.count
                getSurveyQuestionsState = .success(questions)
            }.store(in: &cancellables)
    }

    public func getQuestionsNumber() -> Int {
        return questionsNumber
    }

    public func insertAnswerToSend(answerToSend: AnswerToSend) {
        if answersToSend.contains(where: { _answerToSend in
            answerToSend.questionId == _answerToSend.questionId
        }) {
            answersToSend.removeAll { _answerToSend in
                answerToSend.questionId == _answerToSend.questionId
            }
            answersToSend.append(answerToSend)
        } else {
            answersToSend.append(answerToSend)
        }
    }

    public func sendSurvey() {
        var answersToSendPost: [SurveyPostRequestModel] = []
        answersToSend.forEach { answerToSend in
            if answerToSend.type == .text {
                answersToSendPost.append(SurveyPostRequestSingleModel(id: answerToSend.questionId,
                                                                      answer: answerToSend.answerText ?? ""))
            } else if answerToSend.type == .select {
                answersToSendPost.append(SurveyPostRequestSingleModel(id: answerToSend.questionId,
                                                                      answer: answerToSend.answerIDs?[0] ?? ""))
            } else {
                /// multiselect
                if answerToSend.answerIDs?.count ?? 0 > 1 {
                    answersToSendPost.append(SurveyPostRequestMultiModel(id: answerToSend.questionId,
                                                                         answer: answerToSend.answerIDs ?? []))
                } else {
                    answersToSendPost.append(SurveyPostRequestSingleModel(id: answerToSend.questionId,
                                                                          answer: answerToSend.answerIDs?[0] ?? ""))
                }
            }
        }

        let surveyPostRequest = SurveyPostRequest(answers: answersToSendPost)

        sendSurveyQuestionsUseCase.execute(surveyId: surveyID, surveyRequest: surveyPostRequest)
            .receive(on: RunLoop.main)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.sendSurveyState = .failure(error)
            } receiveValue: { _ in
                self.sendSurveyState = .success(())
            }
            .store(in: &cancellables)
    }

    public func getSurveyID() -> String {
        return surveyID
    }
}
