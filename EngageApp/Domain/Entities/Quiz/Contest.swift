//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct Contest {
    public let id: Int?
    public var maxTimeSeconds: Int?
    public let pointsAnswer: Int?
    public let pointsCorrectAnswer: Int?
    public let pointsAllCorrectAnswer: Int?
    public var userCanPlay = false
    public var userAlreadyPlayed = false
    public var nextSlot: Slot?

    public init(contestDataSource: ContestDataSource?) {
        id = contestDataSource?.id
        maxTimeSeconds = contestDataSource?.maxTimeSeconds
        pointsAnswer = contestDataSource?.pointsAnswer
        pointsCorrectAnswer = contestDataSource?.pointsCorrectAnswer
        pointsAllCorrectAnswer = contestDataSource?.pointsAllCorrectAnswer
        userCanPlay = contestDataSource?.userCanPlay ?? false
        userAlreadyPlayed = contestDataSource?.userAlreadyPlayed ?? false
        if let nextSlotDataSourceModel = contestDataSource?.nextSlot {
            nextSlot = Slot(slotDataSource: nextSlotDataSourceModel)
        }
    }

    public init(last: Bool, totalQuestions: Int, maxTimeSeconds: Int, pointsAnswer: Int, pointsCorrectAnswer: Int, pointsAllCorrectAnswer: Int) {
        id = 1
        self.maxTimeSeconds = maxTimeSeconds
        self.pointsAnswer = pointsAnswer
        self.pointsCorrectAnswer = pointsCorrectAnswer
        self.pointsAllCorrectAnswer = pointsAllCorrectAnswer
        if last {
            userCanPlay = false
            userAlreadyPlayed = true
        } else {
            userCanPlay = true
            userAlreadyPlayed = false
        }
        nextSlot = Slot(totalQuestions: totalQuestions)
    }
}
