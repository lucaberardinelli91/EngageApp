//
//  EngageApp
//  Created by Luca Berardinelli
//

public struct QuizResponse {
    public let correct: Bool?
    public let points: Int?

    public init(quizResponseDataSource: QuizResponseDataSource) {
        correct = quizResponseDataSource.correct
        points = quizResponseDataSource.points
    }
}
