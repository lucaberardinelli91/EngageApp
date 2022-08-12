//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

struct WelcomeFooterItemModel: Hashable {
    var title: String
    var type: WelcomeFooterItem

    init(type: WelcomeFooterItem) {
        self.type = type
        switch type {
        case .PrivacyPolicy:
            title = L10n.privacyPolicyTitle
        case .TermsAndConditions:
            title = L10n.privacyTermsTitle
        }
    }
}

enum WelcomeFooterItem {
    case PrivacyPolicy
    case TermsAndConditions
}
