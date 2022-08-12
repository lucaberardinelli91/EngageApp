//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol GetQuizDetailProtocol {
    func execute(quizId: String) -> AnyPublisher<QuizDetail, CustomError>
}

public protocol GetNextQuestionProtocol {
    func execute(quizId: String) -> AnyPublisher<Question, CustomError>
}

public protocol PostAnswerProtocol {
    func execute(answerRequest: AnswerRequest, quizId: String) -> AnyPublisher<QuizResponse, CustomError>
}

enum QuizUseCase {
    public class GetQuizDetail: GetQuizDetailProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var quizRepository: QuizRepositoryProtocol

        public init(quizRepository: QuizRepositoryProtocol) {
            self.quizRepository = quizRepository
        }

        public func execute(quizId: String) -> AnyPublisher<QuizDetail, CustomError> {
            quizRepository.getDetailQuiz(quizId: quizId)
        }
    }

    public class NextQuestion: GetNextQuestionProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var quizRepository: QuizRepositoryProtocol

        public init(quizRepository: QuizRepositoryProtocol) {
            self.quizRepository = quizRepository
        }

        public func execute(quizId: String) -> AnyPublisher<Question, CustomError> {
            quizRepository.getNextQuestion(quizId: quizId)
        }
    }

    public class PostAnswer: PostAnswerProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var quizRepository: QuizRepositoryProtocol

        public init(quizRepository: QuizRepositoryProtocol) {
            self.quizRepository = quizRepository
        }

        public func execute(answerRequest: AnswerRequest, quizId: String) -> AnyPublisher<QuizResponse, CustomError> {
            quizRepository.postAnswer(answer: answerRequest, quizId: quizId)
        }
    }
}
