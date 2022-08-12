//
//  EngageApp
//  Created by Luca Berardinelli
//

public struct Question {
    public let id: String?
    public let question: String?
    public let image: String?
    public let answers: [Answer]?

    public init(questionDataSource: QuestionDataSource) {
        id = questionDataSource.id
        question = questionDataSource.question
        image = questionDataSource.image
        answers = questionDataSource.answers.map { answersDataSource in
            answersDataSource.map { answerDataSourceModel in
                Answer(answerDataSource: answerDataSourceModel)
            }
        }
    }
}
