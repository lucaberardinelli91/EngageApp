//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct Slot {
    public let id: Int?
    public var totalQuestions: Int

    init(slotDataSource: SlotDataSource?) {
        id = slotDataSource?.id
        totalQuestions = slotDataSource?.totalQuestions ?? 0
    }

    init(totalQuestions: Int) {
        id = 1
        self.totalQuestions = totalQuestions
    }
}
