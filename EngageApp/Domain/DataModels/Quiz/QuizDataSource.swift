//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct QuizDataSource: Decodable {
    let contest: ContestDataSource?
    let slot: SlotDataSource?
    let question: QuestionQuizDataSource?

    private enum CodingKeys: String, CodingKey {
        case slot = "currentSlot"
        case question = "questions"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        contest = try? ContestDataSource(from: decoder)
        slot = try? values.decodeIfPresent(SlotDataSource.self, forKey: .slot)
        question = try? values.decodeIfPresent(QuestionQuizDataSource.self, forKey: .question)
    }
}
