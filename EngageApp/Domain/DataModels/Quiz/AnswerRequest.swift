//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct AnswerRequest: Encodable {
    public var answer: String
    public var seconds: Int

    public init(answer: String, seconds: Int) {
        self.answer = answer
        self.seconds = seconds
    }
}
