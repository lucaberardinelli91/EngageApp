//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct Answer {
    public let id: String?
    public let text: String?
    public let correct: Bool?
    
    public init(id: String, text: String, correct: Bool){
        self.id = id
        self.text = text
        self.correct = correct
    }

    init(answerDataSource: AnswerDataSource) {
        id = answerDataSource.id
        text = answerDataSource.text
        correct = answerDataSource.correct
    }
}
