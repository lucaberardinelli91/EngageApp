//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol QuizRepositoryProtocol {
    func getDetailQuiz(quizId: String) -> AnyPublisher<QuizDetail, CustomError>
    func getNextQuestion(quizId: String) -> AnyPublisher<Question, CustomError>
    func postAnswer(answer: AnswerRequest, quizId: String) -> AnyPublisher<QuizResponse, CustomError>
}
