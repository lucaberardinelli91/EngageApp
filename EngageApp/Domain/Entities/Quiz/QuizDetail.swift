//
//  EngageApp
//  Created by Luca Berardinelli
//

public struct QuizDetail {
    public let questionsCount: Int?
    public let maxSecondsPerQuestion: Int?

    public init(quizDetailDataSource: QuizDetailDataSource) {
        questionsCount = quizDetailDataSource.questions_count
        maxSecondsPerQuestion = quizDetailDataSource.max_seconds_per_question
    }
}
