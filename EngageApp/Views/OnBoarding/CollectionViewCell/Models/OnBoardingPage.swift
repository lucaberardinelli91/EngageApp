//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Foundation

// MARK: - OnBoardingPageConfiguration

public struct OnBoardingPage: Hashable {
    let index: Int?
    let title, description: String?

    static func getOnBoardingPages() -> [OnBoardingPage] {
        return [OnBoardingPage(1),
                OnBoardingPage(2),
                OnBoardingPage(3)]
    }

    init(_ step: Int) {
        switch step {
        case 1:
            index = 1
            title = L10n.onBoardingStep1Title
            description = L10n.onBoardingstep1SubTitle
        case 2:
            index = 2
            title = L10n.onBoardingStep2Title
            description = L10n.onBoardingstep2SubTitle
        case 3:
            index = 3
            title = L10n.onBoardingStep3Title
            description = L10n.onBoardingstep3SubTitle
        default:
            index = 0
            title = L10n.onBoardingStep3Title
            description = L10n.onBoardingstep3SubTitle
        }
    }

    public static func == (lhs: OnBoardingPage, rhs: OnBoardingPage) -> Bool {
        return lhs.index == rhs.index
    }
}
