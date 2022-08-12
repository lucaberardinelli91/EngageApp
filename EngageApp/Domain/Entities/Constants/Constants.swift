//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public enum Constants {
    public static var segmentedControlContainerHeight: Float = 40
    public static var homeHeaderHeight: Float = 200
    public static var appBundle: String = DataBundleResolver.returnMainBundle().bundleIdentifier ?? "com.engageapp"

    public enum HeroTransitionsID {
        public static let splashLogo = "splashTeamLogo"
        public static let welcomeTextField = "welcomeTextField"
        public static let welcomeContinueButton = "welcomeContinueButton"
        public static let welcomeTransition = "welcomeTransition"
        public static let quizTransition = "quizTransition"
    }

    public enum PlistNames {
        public static let fullNameKey = "TeamName"
        public static let shortNameKey = "ShortTeamName"
    }

    public enum PlistURLs {
        public static let downloadURL = "downloadURL"
        public static let buyTicketsURL = "buyTicketsURL"
        public static let tos = "TermsOfService"
        public static let privacyTerms = "PrivacyTerms"
        public static let appStoreURL = "appStoreURL"
    }

    public enum UserDefaultsKey {
        public static let onBoardingKey = "onBoardingConfigurationKey"
        public static let welcomeKey = "welcomeKey"
        public static let signupKey = "signupKey"
        public static let tabBarKey = "tabBarKey"
        public static let membershipADVKey = "membershipADVKey"
        public static let environmentKey = "environmentKey"
        public static let otherKey = "otherKey"
        public static let userPreferencesKey = "userPreferencesKey"
        public static let triggersKey = "triggersKey"
        public static let myTeamId = "myTeamId"
    }
}

public extension Constants {
    static var tabBarHeight: Float = UIDevice.current.hasNotch ? 105 : 85
    static var screenHeightSmall: CGFloat = 750 // 8, 8Plus, SE
    static var screenHeightMedium: CGFloat = 900 // 11Pro, 12, 12mini, 12Pro, 13, 13mini, 13Pro
    static var screenHeightLarge: CGFloat = 1000 // 11, 11ProMax, 12ProMax, 13ProMax
}
