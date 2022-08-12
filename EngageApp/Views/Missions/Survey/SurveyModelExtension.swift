//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
extension SurveyAnswer: Hashable {
    public static func == (lhs: SurveyAnswer, rhs: SurveyAnswer) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
