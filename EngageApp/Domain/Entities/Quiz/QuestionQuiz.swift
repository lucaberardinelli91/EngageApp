//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct QuestionQuiz {
    public let id: String?
    public let text: String?
    public let answers: [Answer]?

    init(questionQuizDataSource: QuestionQuizDataSource?) {
        id = questionQuizDataSource?.id
        text = questionQuizDataSource?.text
        answers = questionQuizDataSource?.answers.map { answersDataSource in
            answersDataSource.map { answerDataSource in
                Answer(answerDataSource: answerDataSource)
            }
        }
    }

    init(id: String?, text: String?, answers: [Answer]?) {
        self.id = id
        self.text = text
        self.answers = answers
    }
}
