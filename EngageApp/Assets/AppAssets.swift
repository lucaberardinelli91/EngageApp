//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public typealias AssetAppImageTypeAlias = ImageAppAsset.ImageApp

// MARK: - AppAsset

public enum AppAsset {
    // MARK: - Images

    public static let backgroundSplash = ImageAppAsset(name: "backgroundSplash")
    public static let brandLogo = ImageAppAsset(name: "brandLogo")
    public static let brandLogo2 = ImageAppAsset(name: "brandLogo2")
    public static let brandName = ImageAppAsset(name: "brandName")
    public static let brandNameColor = ImageAppAsset(name: "brandNameColor")
    public static let icnNext = ImageAppAsset(name: "icnNext")
    public static let onboarding = ImageAppAsset(name: "onboarding")
    public static let imgWelcomeBackground = ImageAppAsset(name: "imgWelcomeBackground")
    public static let surveyBackground = ImageAppAsset(name: "surveyBackground")
    public static let notificationImage = ImageAppAsset(name: "task_image")
    public static let notificationBackground = ImageAppAsset(name: "task_background")
    public static let quizBackground = ImageAppAsset(name: "quizBackground")
    public static let imgLoginBackground = ImageAppAsset(name: "imgLoginBackground")
    public static let eyeOpen = ImageAppAsset(name: "eyeOpen")
    public static let eyeClosed = ImageAppAsset(name: "eyeClosed")
    public static let emailConfirm = ImageAppAsset(name: "emailConfirm")
    public static let emailOn = ImageAppAsset(name: "emailOn")
    public static let emailOff = ImageAppAsset(name: "emailOff")
    public static let imgCrown = ImageAppAsset(name: "imgCrown")
    public static let imgSplashTeamLogo = ImageAppAsset(name: "img_splash_teamLogo")
    public static let icnAvatarHome = ImageAppAsset(name: "icn_avatar_home")
    public static let questionSurvey = ImageAppAsset(name: "question_survey")
    public static let quizCorrectOn = ImageAppAsset(name: "quiz_correct_on")
    public static let quizCurrent = ImageAppAsset(name: "quiz_current")
    public static let quizWrongOn = ImageAppAsset(name: "quiz_wrong_on")
    public static let quizWrongOff = ImageAppAsset(name: "quiz_wrong_off")
    public static let quizCorrectOff = ImageAppAsset(name: "quiz_correct_off")
    public static let quizNext = ImageAppAsset(name: "quiz_next")
    public static let profilePlaceholder = ImageAppAsset(name: "profile_placeholder")
    public static let headerClose = ImageAppAsset(name: "header_close")
    public static let reward = ImageAppAsset(name: "reward")
    public static let rewardRedeem = ImageAppAsset(name: "reward_redeem")
    public static let close = ImageAppAsset(name: "close")
    public static let share = ImageAppAsset(name: "share")
    public static let missionSuccess = ImageAppAsset(name: "mission_success")
    public static let missionFailure = ImageAppAsset(name: "mission_failure")

    public static let swipeBack = ImageAppAsset(name: "swipe_back")
    public static let swipeIcon = ImageAppAsset(name: "swipe_icon")

    // Reward
    public static let reward1 = ImageAppAsset(name: "reward1")
    public static let reward2 = ImageAppAsset(name: "reward2")
    public static let reward3 = ImageAppAsset(name: "reward3")
    public static let reward4 = ImageAppAsset(name: "reward4")
    public static let reward5 = ImageAppAsset(name: "reward5")
    public static let reward6 = ImageAppAsset(name: "reward6")
    public static let reward7 = ImageAppAsset(name: "reward7")
    public static let reward8 = ImageAppAsset(name: "reward8")
    
    // Fancam
    public static let fancamCancel = ImageAppAsset(name: "fancam_cancel")
    public static let fancamFlashFilled = ImageAppAsset(name: "fancam_flash_filled")
    public static let fancamFlash = ImageAppAsset(name: "fancam_flash")
    public static let fancamFront = ImageAppAsset(name: "fancam_front")
    public static let fancamGalleryImages = ImageAppAsset(name: "fancam_galleryImages")
    public static let fancamLogo = ImageAppAsset(name: "fancam_logo")
    public static let fancamRear = ImageAppAsset(name: "fancam_rear")
    public static let fancamRetake = ImageAppAsset(name: "fancam_retake")
    public static let fancamSave = ImageAppAsset(name: "fancam_save")
    public static let fancamSingle = ImageAppAsset(name: "fancam_single")
    public static let fancamTrash = ImageAppAsset(name: "fancam_trash")
    public static let fancamCheese = ImageAppAsset(name: "fancam_cheese")
    public static let fancamHashtag = ImageAppAsset(name: "fancam_hashtag")
    public static let fancamShare = ImageAppAsset(name: "fancam_share")
    public static let fancamClose = ImageAppAsset(name: "fancam_close")
    public static let fancamCloseCaptured = ImageAppAsset(name: "fancam_close_captured")
    public static let fancamInfoOn = ImageAppAsset(name: "fancam_info_on")
    public static let fancamInfoOff = ImageAppAsset(name: "fancam_info_off")
    public static let fancamFlashOn = ImageAppAsset(name: "fancam_flash_on")
    public static let fancamFlashOff = ImageAppAsset(name: "fancam_flash_off")
    public static let fancamSend = ImageAppAsset(name: "fancam_send")
    public static let fancamBack = ImageAppAsset(name: "fancam_back")
    public static let fancamBackCaptured = ImageAppAsset(name: "fancam_back_captured")
    public static let timerMission = ImageAppAsset(name: "timer_mission")
    public static let userBackground = ImageAppAsset(name: "user_background")
    public static let userPlaceholder = ImageAppAsset(name: "user_placeholder")
    public static let userArrowRight = ImageAppAsset(name: "user_arrow_right")
    public static let userMyAccount = ImageAppAsset(name: "user_my_account")
    public static let userTermsConditions = ImageAppAsset(name: "user_terms_conditions")
    public static let userHow = ImageAppAsset(name: "user_how")
    public static let userHelp = ImageAppAsset(name: "user_help")
    public static let userBrand = ImageAppAsset(name: "user_brand")
    public static let userBack = ImageAppAsset(name: "user_back")
    public static let userForeMyAccount = ImageAppAsset(name: "user_fore_my_account")
    public static let userMyAccountCruise = ImageAppAsset(name: "user_my_account_cruise")
    public static let userMyAccountPlaceholder = ImageAppAsset(name: "user_my_account_placeholder")
    public static let userBackHelp = ImageAppAsset(name: "user_back_help")
    public static let userBackHelpGradient = ImageAppAsset(name: "user_back_help_gradient")
    public static let closeHelp = ImageAppAsset(name: "close_help")
    public static let tosHelp = ImageAppAsset(name: "tos_help")
    public static let phoneHelp = ImageAppAsset(name: "phone_help")
    public static let emailHelp = ImageAppAsset(name: "email_help")

    // Launcher
    public static let launcherBackground = ImageAppAsset(name: "launcherBackground")
    public static let launcherTypeQuiz = ImageAppAsset(name: "launcherTypeQuiz")
    public static let launcherTypeInstantwin = ImageAppAsset(name: "launcherTypeInstantwin")
    public static let launcherTypeSurvey = ImageAppAsset(name: "launcherTypeSurvey")
    public static let launcherTypeSocialGoogle = ImageAppAsset(name: "launcherTypeSocialGoogle")
    public static let launcherTypeSocialFacebook = ImageAppAsset(name: "launcherTypeSocialFacebook")
    public static let launcherTypeSocialTwitter = ImageAppAsset(name: "launcherTypeSocialTwitter")
    public static let launcherTypeSocialLinkedin = ImageAppAsset(name: "launcherTypeSocialLinkedin")
    public static let launcherTypeFancam = ImageAppAsset(name: "launcherTypeFancam")
    public static let backLauncherFancam = ImageAppAsset(name: "backLauncherFancam")
    public static let frontLauncherFancam = ImageAppAsset(name: "frontLauncherFancam")

    // Missions
    public static let missionTypeQuiz = ImageAppAsset(name: "mission_type_quiz")
    public static let missionTypeSurvey = ImageAppAsset(name: "mission_type_survey")
    public static let missionTypeInfo = ImageAppAsset(name: "mission_type_info")
    public static let missionTypeFancam = ImageAppAsset(name: "mission_type_fancam")
    public static let missionTypeInstantwin = ImageAppAsset(name: "mission_type_instantwin")
    public static let missionTypeSocialGoogle = ImageAppAsset(name: "mission_type_social_google")
    public static let missionTypeSocialFacebook = ImageAppAsset(name: "mission_type_social_facebook")
    public static let missionTypeSocialTwitter = ImageAppAsset(name: "mission_type_social_twitter")
    public static let missionTypeSocialLinkedin = ImageAppAsset(name: "mission_type_social_linkedin")

    // Wallet
    public static let walletButton = ImageAppAsset(name: "wallet_button")
    public static let walletButtonSmall = ImageAppAsset(name: "wallet_button_small")
    public static let walletMissionOk = ImageAppAsset(name: "wallet_mission_ok")
    public static let walletMissionKo = ImageAppAsset(name: "wallet_mission_ko")
    public static let walletRedeem = ImageAppAsset(name: "wallet_redeem")
    public static let walletWaiting = ImageAppAsset(name: "wallet_waiting")

    public static let imageTest = ImageAppAsset(name: "imageTest")

    // MARK: - Colors

    // Theme
    public static let brandPrimary = ColorAppAsset(name: "brand_primary")
    public static let brandSecondary = ColorAppAsset(name: "brand_secondary")
    public static let brandTertiary = ColorAppAsset(name: "brand_tertiary")

    // Brand Gradient
    public static let brandTertiaryGradient = ColorAppAsset(name: "brand_tertiary_gradient")

    // Wallet
    public static let walletBackButton = ColorAppAsset(name: "wallet_back_button")
    public static let walletBackEndButton = ColorAppAsset(name: "wallet_back_end_button")

    // Grays
    public static let grayBase = ColorAppAsset(name: "gray_base")
    public static let grayDarker = ColorAppAsset(name: "gray_darker")
    public static let grayDark = ColorAppAsset(name: "gray_dark")
    public static let gray = ColorAppAsset(name: "gray")
    public static let grayFancam = ColorAppAsset(name: "gray_fancam")
    public static let grayInput = ColorAppAsset(name: "gray_input")
    public static let grayLight = ColorAppAsset(name: "gray_light")
    public static let grayLighter = ColorAppAsset(name: "gray_lighter")
    public static let grayLighter2 = ColorAppAsset(name: "gray_lighter2")
    public static let grayPull = ColorAppAsset(name: "gray_pull")
    public static let grayOpaque = ColorAppAsset(name: "gray_opaque")

    // Alerts
    public static let brandSuccess = ColorAppAsset(name: "brand_success")
    public static let brandWarning = ColorAppAsset(name: "brand_warning")
    public static let brandDanger = ColorAppAsset(name: "brand_danger")
    public static let brandPositiveInfo = ColorAppAsset(name: "brand_positive_info")
    public static let brandInfo = ColorAppAsset(name: "brand_info")

    // Messages
    public static let brandSuccessLight = ColorAppAsset(name: "brand_success_light")
    public static let brandWarningLight = ColorAppAsset(name: "brand_warning_light")
    public static let brandDangerLight = ColorAppAsset(name: "brand_danger_light")
    public static let brandPositiveInfoLight = ColorAppAsset(name: "brand_positive_info_light")

    // Text
    public static let textColor = ColorAppAsset(name: "text_color")
    public static let textColorDark = ColorAppAsset(name: "text_color_dark")
    public static let textColorLight = ColorAppAsset(name: "text_color_light")

    // Mixed
    public static let borderColorBase = ColorAppAsset(name: "border_color_base")
    public static let linkColor = ColorAppAsset(name: "link_color")
    public static let brandPrimaryDarker = ColorAppAsset(name: "brand_primary_darker")
    public static let bodyBg = ColorAppAsset(name: "body_bg")

    // Checkbox
    public static let checkbox = ImageAppAsset(name: "checkbox")
    public static let checkboxSuccess = ImageAppAsset(name: "checkbox_success")
    public static let checkboxError = ImageAppAsset(name: "checkbox_error")
    public static let checkboxDisabled = ImageAppAsset(name: "checkbox_disabled")
    public static let checkboxChecked = ImageAppAsset(name: "checkbox_checked")
    public static let checkboxCheckedDisabled = ImageAppAsset(name: "checkbox_checked_disabled")

    // Radiobutton
    public static let radiobutton = ImageAppAsset(name: "radiobutton")
    public static let radiobuttonError = ImageAppAsset(name: "radiobutton_error")
    public static let radiobuttonDisabled = ImageAppAsset(name: "radiobutton_disabled")
    public static let radiobuttonChecked = ImageAppAsset(name: "radiobutton_checked")
    public static let radiobuttonCheckedDIsabled = ImageAppAsset(name: "radiobutton_checked_disabled")
    // Others
    public static let navigationBarBackgroundColor = ColorAppAsset(name: "NavigationBackground")
    public static let navigationBarForegroundColor = ColorAppAsset(name: "NavigationForeground")
    public static let tabBarBackgroundColor = ColorAppAsset(name: "TabBarBackground")
    public static let tabBarForegroundColor = ColorAppAsset(name: "TabBarForeground")
    public static let gradientSecondaryColor = ColorAppAsset(name: "GradientSecondaryColor")
    public static let backgroundColor = ColorAppAsset(name: "Background")
    public static let clear = ColorAppAsset(name: "Clear")
    public static let blueLight = ColorAppAsset(name: "BlueLight")
    public static let orangeLight = ColorAppAsset(name: "OrangeLight")
    public static let background = ColorAppAsset(name: "Background")
    public static let correctAnswer = ColorAppAsset(name: "CorrectAnswer")
    public static let buttonCoins = ColorAppAsset(name: "ButtonCoins")
    public static let correctAnswerAlternative = ColorAppAsset(name: "CorrectAnswerAlternative")
    public static let correctAnswerBorder = ColorAppAsset(name: "CorrectAnswerBorder")
    public static let darkGray = ColorAppAsset(name: "Dark Gray")
    public static let darkBlue = ColorAppAsset(name: "DarkBlue")
    public static let doveColor = ColorAppAsset(name: "DoveColor")
    public static let errorColor = ColorAppAsset(name: "ErrorColor")
    public static let facebook = ColorAppAsset(name: "Facebook")
    public static let firstRank = ColorAppAsset(name: "FirstRank")
    public static let firstRankAlternative = ColorAppAsset(name: "FirstRankAlternative")
    public static let fuelYellow = ColorAppAsset(name: "FuelYellow")
    public static let lighGray = ColorAppAsset(name: "LighGray")
    public static let lightningYellow = ColorAppAsset(name: "Lightning Yellow")
    public static let offWhite = ColorAppAsset(name: "OffWhite")
    public static let red = ColorAppAsset(name: "Red")
    public static let redOrange = ColorAppAsset(name: "RedOrange")
    public static let royalBlue = ColorAppAsset(name: "RoyalBlue")
    public static let secondRank = ColorAppAsset(name: "SecondRank")
    public static let secondRankAlternative = ColorAppAsset(name: "SecondRankAlternative")
    public static let similarBlack = ColorAppAsset(name: "SimilarBlack")
    public static let thirdRank = ColorAppAsset(name: "ThirdRank")
    public static let thirdRankAlternative = ColorAppAsset(name: "ThirdRankAlternative")
    public static let warmBrown = ColorAppAsset(name: "WarmBrown")
    public static let whatsapp = ColorAppAsset(name: "Whatsapp")
    public static let whisper = ColorAppAsset(name: "Whisper")
    public static let wrongAnswer = ColorAppAsset(name: "WrongAnswer")
    public static let wrongAnswerBorder = ColorAppAsset(name: "WrongAnswerBorder")
    public static let YellowCoin = ColorAppAsset(name: "YellowCoin")
}

// MARK: - ColorAppAsset

public final class ColorAppAsset {
    public fileprivate(set) var name: String
    public typealias ColorApp = UIColor

    public private(set) lazy var color: ColorApp = {
        guard let color = ColorApp(asset: self) else {
            fatalError("Unable to load color asset named \(name).")
        }
        return color
    }()

    fileprivate init(name: String) {
        self.name = name
    }
}

public extension ColorAppAsset.ColorApp {
    convenience init?(asset: ColorAppAsset) {
        let bundle = DataBundleResolver.returnMainBundle()
        self.init(named: asset.name, in: bundle, compatibleWith: nil)
    }
}

// MARK: - ImageAppAsset

public struct ImageAppAsset {
    public fileprivate(set) var name: String
    public typealias ImageApp = UIImage

    public var image: ImageApp {
        let bundle = DataBundleResolver.returnMainBundle()
        let image = ImageApp(named: name, in: bundle, compatibleWith: nil)
        guard let result = image else {
            print("❌❌❌❌❌Unable to load image asset named \(name).❌❌❌❌❌")
            return UIImage()
        }
        return result
    }
}

public extension ImageAppAsset.ImageApp {
    convenience init?(asset: ImageAppAsset) {
        let bundle = DataBundleResolver.returnMainBundle()
        self.init(named: asset.name, in: bundle, compatibleWith: nil)
    }
}
