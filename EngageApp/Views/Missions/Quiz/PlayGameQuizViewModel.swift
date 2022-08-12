//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import UIKit

public protocol PlayGameQuizViewModelProtocol {
    func getQuizDetail()
    func getNextQuestion()
    func postAnswer(answerId: String, timeMilliseconds: Int)
}

public class PlayGameQuizViewModel: BaseViewModel, PlayGameQuizViewModelProtocol {
    @Published var getQuizDetailState: LoadingState<Void, CustomError> = .idle
    @Published var nextQuestionState: LoadingState<Quiz?, CustomError> = .idle
    @Published var postAnswerState: LoadingState<Void, CustomError> = .idle
    private let nextQuestionUseCase: GetNextQuestionProtocol
    private let postAnswerUseCase: PostAnswerProtocol
    private let getQuizDetailUseCase: GetQuizDetailProtocol
    var mission: Mission
    var quizId: String
    var seconds: Int
    var totalQuestions: Int
    /// Points
    var isAllAnswersCorrect = true
    let pointsAllAnswersCorrect: Int
    let pointsAnswered: Int
    let pointsCorrect: Int
    let pointsMax: Int
    var totalPointsWin: Int = 0
    var counterQuestions: Int = 0
    
    public init(getQuizDetailUseCase: GetQuizDetailProtocol, nextQuestionUseCase: GetNextQuestionProtocol, postAnswerUseCase: PostAnswerProtocol, mission: Mission) {
        self.getQuizDetailUseCase = getQuizDetailUseCase
        self.nextQuestionUseCase = nextQuestionUseCase
        self.postAnswerUseCase = postAnswerUseCase
        self.mission = mission
        quizId = mission.data?.id ?? ""
        totalQuestions = mission.data?.totalQuestions ?? 0
        seconds = mission.data?.seconds ?? 0
        /// points
        pointsAllAnswersCorrect = mission.data?.points ?? 0
        pointsAnswered = mission.data?.answeredPoints ?? 0
        pointsCorrect = mission.data?.correctPoints ?? 0
        pointsMax = mission.data?.maxPoints ?? 0
    }
    
    public func getQuizDetail() {
        getQuizDetailState = .loading
        
        getQuizDetailUseCase.execute(quizId: quizId)
            .receive(on: RunLoop.main)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.getQuizDetailState = .failure(error)
            } receiveValue: { [self] _ in
                getQuizDetailState = .success(())
            }.store(in: &cancellables)
    }
    
    public func getNextQuestion() {
        // MOCK API
        self.counterQuestions += 1
        
        let textQuestion = "Domanda \(self.counterQuestions)"
        var answers: [Answer]?
        if self.counterQuestions == 1 {
            answers = [Answer(id: "1", text: "risposta 1", correct: true),
                       Answer(id: "2", text: "risposta 2", correct: false),
                       Answer(id: "3", text: "risposta 3", correct: false),
                       Answer(id: "4", text: "risposta 4", correct: false)]
        } else {
            answers = [Answer(id: "1", text: "risposta 1", correct: false),
                       Answer(id: "2", text: "risposta 2", correct: false),
                       Answer(id: "3", text: "risposta 3", correct: true),
                       Answer(id: "4", text: "risposta 4", correct: false)]
        }
        
        let contest = Contest(last: false, totalQuestions: 2, maxTimeSeconds: 5, pointsAnswer: 10, pointsCorrectAnswer: 20, pointsAllCorrectAnswer: 130)
        let slot = Slot(totalQuestions: 130)
        
        let question2 = QuestionQuiz(id: "\(self.counterQuestions)", text: textQuestion, answers: answers)
        let instantWinPlay = Quiz(contest: contest, slot: slot, question: question2)
        
        nextQuestionState = .success(instantWinPlay)
        
        
        //        nextQuestionState = .loading
        //
        //        nextQuestionUseCase.execute(quizId: quizId)
        //            .receive(on: RunLoop.main)
        //            .sink { completion in
        //                guard case let .failure(error) = completion else { return }
        //                self.nextQuestionState = .failure(error)
        //            } receiveValue: { [self] question in
        //                guard let id = question.id, let text = question.question else { return }
        //
        //                let contest = Contest(last: false, totalQuestions: totalQuestions, maxTimeSeconds: seconds, pointsAnswer: self.pointsAnswered, pointsCorrectAnswer: self.pointsCorrect, pointsAllCorrectAnswer: self.pointsAllAnswersCorrect)
        //                let slot = Slot(totalQuestions: self.totalQuestions)
        //
        //                let question2 = QuestionQuiz(id: id, text: text, answers: question.answers)
        //                let instantWinPlay = Quiz(contest: contest, slot: slot, question: question2)
        //
        //                nextQuestionState = .success(instantWinPlay)
        //            }.store(in: &cancellables)
    }
    
    public func postAnswer(answerId: String, timeMilliseconds: Int = 0) {
        // MOCK API
        postAnswerState = .success(())
        
        //        postAnswerState = .loading
        //
        //        let answerRequest = AnswerRequest(answer: answerId, seconds: timeMilliseconds)
        //
        //        postAnswerUseCase.execute(answerRequest: answerRequest, quizId: quizId)
        //            .receive(on: RunLoop.main)
        //            .sink { completion in
        //                guard case let .failure(error) = completion else { return }
        //                self.postAnswerState = .failure(error)
        //            } receiveValue: { [self] resultAnswer in
        //                totalPointsWin += pointsAnswered
        //
        //                if let result = resultAnswer.correct, result {
        //                    totalPointsWin += pointsCorrect
        //                } else {
        //                    isAllAnswersCorrect = false
        //                }
        //
        //                postAnswerState = .success(())
        //            }.store(in: &cancellables)
    }
}
