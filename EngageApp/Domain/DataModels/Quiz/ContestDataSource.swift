//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct ContestDataSource: Decodable {
    private(set) var id: Int?
    private(set) var maxTimeSeconds: Int?
    private(set) var pointsAnswer: Int?
    private(set) var pointsCorrectAnswer: Int?
    private(set) var pointsAllCorrectAnswer: Int?
    private(set) var userCanPlay: Bool?
    private(set) var userAlreadyPlayed: Bool?
    private(set) var nextSlot: SlotDataSource?

    private enum RootKeys: String, CodingKey {
        case nextSlot
        case quiz
    }

    private enum QuizCodingKeys: String, CodingKey {
        case id
        case maxTimeSeconds
        case pointsAnswer
        case pointsCorrectAnswer
        case pointsAllCorrectAnswer
        case userCanPlay
        case userAlreadyPlayed
    }

    public init(from decoder: Decoder) throws {
        if let values = try? decoder.container(keyedBy: RootKeys.self), let quizContainer = try? values.nestedContainer(keyedBy: QuizCodingKeys.self, forKey: .quiz) {
            decode(quizContainer: quizContainer, nextSlotContainer: values)
        } else {
            if let values = try? decoder.container(keyedBy: QuizCodingKeys.self) {
                decode(quizContainer: values, nextSlotContainer: nil)
            }
        }
    }

    private mutating func decode(quizContainer: KeyedDecodingContainer<QuizCodingKeys>, nextSlotContainer: KeyedDecodingContainer<RootKeys>?) {
        id = try? quizContainer.decodeIfPresent(Int.self, forKey: .id)
        maxTimeSeconds = try? quizContainer.decodeIfPresent(Int.self, forKey: .maxTimeSeconds)
        pointsAnswer = try? quizContainer.decodeIfPresent(Int.self, forKey: .pointsAnswer)
        pointsCorrectAnswer = try? quizContainer.decodeIfPresent(Int.self, forKey: .pointsCorrectAnswer)
        pointsAllCorrectAnswer = try? quizContainer.decodeIfPresent(Int.self, forKey: .pointsAllCorrectAnswer)
        userCanPlay = try? quizContainer.decodeIfPresent(Bool.self, forKey: .userCanPlay) ?? false
        userAlreadyPlayed = try? quizContainer.decodeIfPresent(Bool.self, forKey: .userAlreadyPlayed) ?? false
        nextSlot = try? nextSlotContainer?.decodeIfPresent(SlotDataSource.self, forKey: .nextSlot)
    }
}
