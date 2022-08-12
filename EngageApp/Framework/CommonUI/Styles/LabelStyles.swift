//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import SwiftRichString
import UIKit

// MARK: - LabelStyles

public struct LabelStyles {
    private let backgroundColor: UIColor?
    private let font: UIFont?
    private let fontColor: UIColor
    private let minimumScaleFactor: CGFloat
    private let adjustsFontSizeToFitWidth: Bool
    private let attributedTextStyle: StyleGroup?

    public init(
        backgroundColor: UIColor? = nil,
        font: UIFont? = nil,
        fontColor: UIColor = .black,
        attributedTextStyle: StyleGroup? = nil,
        minimumScaleFactor: CGFloat = 0.6,
        adjustsFontSizeToFitWidth: Bool = true
    ) {
        self.backgroundColor = backgroundColor
        self.font = font
        self.fontColor = fontColor
        self.attributedTextStyle = attributedTextStyle
        self.minimumScaleFactor = minimumScaleFactor
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
    }

    public func apply(to label: UILabel?) {
        guard let label = label else { return }

        label.font = font
        label.textColor = fontColor
        label.minimumScaleFactor = minimumScaleFactor
        label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth

        if let attributedTextStyle = attributedTextStyle {
            label.attributedText = label.text?.set(style: attributedTextStyle)
        }

        if let backgroundColor = backgroundColor {
            label.backgroundColor = backgroundColor
        }
    }

    public func apply(to textView: UITextView?) {
        guard let textView = textView else { return }

        textView.font = font
        textView.textColor = fontColor

        if let attributedTextStyle = attributedTextStyle {
            textView.attributedText = textView.text?.set(style: attributedTextStyle)
        }

        if let backgroundColor = backgroundColor {
            textView.backgroundColor = backgroundColor
        }
    }
}

// MARK: - LabelStyles

public enum LabelStyle {
    // Onboarding
    public static let onBoardingTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 33), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let onBoardingSubTitle = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 16), fontColor: AppAsset.grayLighter2.color)

    // User
    public static let userTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 23), fontColor: .white)

    public static let userName = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 24), fontColor: .black)

    public static let accountTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 24), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let accountSubTitle = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: AppAsset.grayDark.color)

    public static let accountName = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 14), fontColor: .black)

    public static let accountNameValue = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: .gray)

    public static let cruiseTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 24), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let cruiseSubTitle = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: AppAsset.gray.color)

    public static let cruiseDescr = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 16), fontColor: .black)

    public static let userCruise = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 14), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let userCruiseTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 17), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let userCruiseSubTitle = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 14), fontColor: AppAsset.darkGray.color)

    public static let userAccountSupport = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 16), fontColor: .black)

    public static let userActionTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 16), fontColor: .black)

    public static let userActionSubTitle = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: AppAsset.grayDark.color)

    public static let help = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 24), fontColor: .white)

    public static let helpTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 24), fontColor: .black)

    public static let helpSubTitle = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 14), fontColor: .black)

    public static let helpTos = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 16), fontColor: .black)

    public static let helpProblems = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 22), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let helpPhone = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().secondaryColor)

    // Welcome
    public static let welcomeTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 24), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let welcomeSubTitle = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 16), fontColor: AppAsset.grayDark.color)

    public static let welcomeEmailTitle = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 16), fontColor: AppAsset.grayBase.color.withAlphaComponent(0.9))

    public static let welcomeSignInEmailPlaceholder = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 14), fontColor: UIColor.lightGray)

    public static var welcomeNoBooking: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 15)
            }
            let bookURL = URL(string: "https://www.google.it")

            let book = SwiftRichString.Style {
                $0.linkURL = bookURL
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 15)
            }

            let base = StyleGroup(base: normal, ["p": book])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static var tosPrivacy: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = UIColor.black
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 15)
            }

            let tosURL = URL(string: "https://www.google.it")
            let privacyURL = URL(string: "https://www.google.it")

            let tos = SwiftRichString.Style {
                $0.linkURL = tosURL
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 15)
            }

            let privacy = SwiftRichString.Style {
                $0.linkURL = privacyURL
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 15)
            }

            let base = StyleGroup(base: normal, ["p": privacy, "t": tos])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: UIColor.black, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let limitedTitle = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 17), fontColor: UIColor.white)

    public static let listHeaderSubTitle = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: UIColor.white)

    public static let rewardBSTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 28), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let rewardBSSubTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: AppAsset.gray.color)

    public static let descriptionSubTitle = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: UIColor.black)

    public static let needMoreCoinsTextLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let needMoreCoinsValueLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: AppAsset.brandDanger.color)

    // fancam
    public static let fancamAddCommentTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 24), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let fancamAddCommentSubTitle = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 14), fontColor: AppAsset.grayLighter2.color)

    public static let fancamInfoTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: AppAsset.grayFancam.color)

    public static let fancamInfoSubTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let fancamInfoTakePhoto = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: ThemeManager.currentTheme().secondaryColor)

    // Launcher
    public static let launcherTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: UIColor.gray)

    public static let launcherSubTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 22), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let launcherDescription = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 16), fontColor: UIColor.black)

    public static let launcherBoxLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: UIColor.black)

    public static let launcherFancamTitle = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 16), fontColor: AppAsset.blueLight.color)

    public static let launcherFancamDescr = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let launcherInfoTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 25), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let launcherInfoSubTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 25), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static let launcherInfoText = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 16), fontColor: UIColor.black)

    // Wallet
    public static let coinsButton = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 14), fontColor: UIColor.white)

    public static let coinView = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 14), fontColor: UIColor.white)

    public static let rewardPrimaryCoinView = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let rewardBaseCoinView = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .white)

    public static let limitedView = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 16), fontColor: UIColor.white)

    public static let coinsWallet = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 30), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let coinsWalletSubTitle = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 17), fontColor: AppAsset.grayLighter2.color)

    public static let coinTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 13), fontColor: .white)

    public static let coinValueLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: .white)

    // Timer
    public static let timerMission = LabelStyles(font: ThemeManager.currentTheme().primaryItalicFont.font(size: 13), fontColor: UIColor.red)

    public static let timerMissionLauncher = LabelStyles(font: ThemeManager.currentTheme().primaryItalicFont.font(size: 16), fontColor: UIColor.red)

    public static let feedbackTitleSuccess = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 32), fontColor: AppAsset.brandSuccess.color)

    public static let feedbackTitleFailure = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 32), fontColor: AppAsset.brandDanger.color)

    public static let feedbackSubtitle = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 16), fontColor: UIColor.black)

    public static let feedbackCoins = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 25), fontColor: AppAsset.buttonCoins.color)

    // Home
    public static let homeListTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 24), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let homeTitleShowAll = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 16), fontColor: ThemeManager.currentTheme().secondaryColor)

    // Catalog
    public static let rewardListTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: UIColor.white)

    public static let headerListTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 23), fontColor: UIColor.white)

    // Notification
    public static let notificationTitle = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static let notificationSubTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: ThemeManager.currentTheme().primaryColor)

    // Missions
    public static let missionType = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 12), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let missionText = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: .black)

    public static let missionTime = LabelStyles(font: ThemeManager.currentTheme().primaryItalicFont.font(size: 13), fontColor: UIColor.gray)

    public static let missionCoins = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let noMissionsAvailable = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 18), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let walletCoinsEarned = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 16), fontColor: AppAsset.brandWarning.color)

    public static let walletCoinsSpent = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 16), fontColor: UIColor.red)

    public static let navigationBarLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: ThemeManager.currentTheme().navigationBarForegroundColor)

    public static let navigationBarLabelAlternative = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .white)

    public static let toastLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 17), fontColor: .white)

    public static let onboardingTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 32), fontColor: ThemeManager.currentTheme().primaryColor)

    public static var onboardingDescriptionAttributedLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = UIColor.lightGray
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 22)
            }
            let bold = SwiftRichString.Style {
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 22)
            }
            let base = StyleGroup(base: normal, ["b": bold])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 22), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static var loginDescriptionAttributedLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = UIColor.lightGray
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 15)
            }
            let bold = SwiftRichString.Style {
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 15)
            }
            let base = StyleGroup(base: normal, ["b": bold])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: UIColor.lightGray, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let messageContentBlockedLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: AppAsset.grayOpaque.color)

    public static var onboardingLongPressLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let bold = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 15)
            }

            let subtitle = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 15)
            }
            let base = StyleGroup(base: bold, ["s": subtitle])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static var signupDescriptionAttributedLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 18)
            }
            let bold = SwiftRichString.Style {
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 18)
            }
            let base = StyleGroup(base: normal, ["b": bold])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 22), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let welcomeLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 18), fontColor: .white)

    public static let signinLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 25), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static let signinDescriptionLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 18), fontColor: .white)

    public static let forgotPasswordSuggestionLabel = LabelStyles(font: ThemeManager.currentTheme().primaryItalicFont.font(size: 15), fontColor: .white)

    public static let recoverPasswordTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let socialLoginBottomSheetTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let socialLoginEmailLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: AppAsset.grayOpaque.color)

    public static let socialLoginSubtitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: .lightGray)

    public static let socialLoginDescriptionLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: AppAsset.grayOpaque.color)

    public static let termsAndConditionTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let askTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 25), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let profileNameAbbreviationLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 30), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let profileNameAbbreviationSmallLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 17), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let commentaryTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let commentaryLoggedOutLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: AppAsset.grayOpaque.color)

    public static let statsTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: .black)

    public static let placeholderSubtitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: .lightGray)

    public static var mediaPlaceholderLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let title = SwiftRichString.Style {
                $0.color = ThemeManager.currentTheme().primaryColor
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 20)
            }

            let subtitle = SwiftRichString.Style {
                $0.color = AppAsset.lighGray.color
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 18)
            }

            let base = StyleGroup(base: title, ["s": subtitle, "t": title])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor, attributedTextStyle: attributedTextStyle, minimumScaleFactor: 0.7, adjustsFontSizeToFitWidth: true)
        return style
    }

    public static var lineupSubtitleNotificationDisabled: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = UIColor.gray
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 18)
            }
            let bold = SwiftRichString.Style {
                $0.color = UIColor.darkGray
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 18)
            }
            let base = StyleGroup(base: normal, ["b": bold])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: UIColor.lightGray, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let surveyTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 25), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static let surveySubTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: .white, minimumScaleFactor: 0.5, adjustsFontSizeToFitWidth: true)

    public static let surveyQuestionsToAnswerLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: .white.withAlphaComponent(0.5))

    public static let surveyQuestionAnsweredLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static let surveyChangeAnswerLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .white)

    public static let surveyTimeExpiredLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: .white.withAlphaComponent(0.7))

    public static let surveyQuestionsAnsweredLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: .white.withAlphaComponent(0.5))

    public static let surveyProgressLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static let surveyAnswerTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 23), fontColor: ThemeManager.currentTheme().primaryColor, minimumScaleFactor: 0.6, adjustsFontSizeToFitWidth: true)

    public static let surveyAnswerSubtitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: AppAsset.grayDark.color)

    public static let surveyAnswerTextLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: .black, minimumScaleFactor: 0.5, adjustsFontSizeToFitWidth: true)

    public static var surveyAnswerPercentageLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let title = SwiftRichString.Style {
                $0.color = ThemeManager.currentTheme().primaryColor
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 15)
            }

            let symbol = SwiftRichString.Style {
                $0.color = ThemeManager.currentTheme().primaryColor
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 10)
            }

            let base = StyleGroup(base: title, ["s": symbol, "t": title])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: ThemeManager.currentTheme().primaryColor, attributedTextStyle: attributedTextStyle, minimumScaleFactor: 0.7, adjustsFontSizeToFitWidth: true)
        return style
    }

    public static let surveyAnswerTextSelectedLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: .black, minimumScaleFactor: 0.5, adjustsFontSizeToFitWidth: true)

    public static let surveyFinalTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 30), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static let surveyFinalSubtitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: .white)

    public static let surveyFinalNavigationTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: .white)

    public static let surveyResultsTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: AppAsset.grayOpaque.color)

    public static let surveyResultsInfoLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 12), fontColor: .gray)

    public static let surveyResultsAnswerTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 23), fontColor: ThemeManager.currentTheme().primaryColor, minimumScaleFactor: 0.6, adjustsFontSizeToFitWidth: true)

    public static let membershipExclusiveLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 30), fontColor: .white)

    public static let membershipPremiumLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 30), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static let membershipSmartLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 30), fontColor: ThemeManager.currentTheme().primaryColor)

    public static var profileCardNumber: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let title = SwiftRichString.Style {
                $0.color = UIColor.black.withAlphaComponent(0.7)
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 18)
            }

            let subtitle = SwiftRichString.Style {
                $0.color = UIColor.black
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 18)
            }

            let base = StyleGroup(base: title, ["v": subtitle, "t": title])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: UIColor.black, attributedTextStyle: attributedTextStyle, minimumScaleFactor: 0.7, adjustsFontSizeToFitWidth: true)
        return style
    }

    public static var profileCardNumberWhite: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let title = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 18)
            }

            let subtitle = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 18)
            }

            let base = StyleGroup(base: title, ["v": subtitle, "t": title])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle, minimumScaleFactor: 0.7, adjustsFontSizeToFitWidth: true)
        return style
    }

    public static var profileCardValidLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let title = SwiftRichString.Style {
                $0.color = UIColor.black.withAlphaComponent(0.7)
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 10)
            }

            let subtitle = SwiftRichString.Style {
                $0.color = UIColor.black
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 15)
            }

            let base = StyleGroup(base: title, ["v": subtitle, "t": title])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: UIColor.black, attributedTextStyle: attributedTextStyle, minimumScaleFactor: 0.7, adjustsFontSizeToFitWidth: true)
        return style
    }

    public static var profileCardValidLabelWhite: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let title = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 10)
            }

            let subtitle = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 15)
            }

            let base = StyleGroup(base: title, ["v": subtitle, "t": title])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle, minimumScaleFactor: 0.7, adjustsFontSizeToFitWidth: true)
        return style
    }

    public static let profileMessageContentBlockedLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: AppAsset.grayOpaque.color)

    public static let profileMembershipReadyLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let profileMembershipReadySubtitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: .white)

    public static let termsAndConditionSubtitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: .lightGray)

    public static let recoverPasswordSubtitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: .lightGray)

    public static let recoverPasswordDescriptionLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: AppAsset.grayOpaque.color)

    public static let recoverPasswordEmailLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: AppAsset.grayOpaque.color)

    public static let socialSignInTitleLable = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 20), fontColor: .white)

    public static let signupPlaceholderLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 14), fontColor: UIColor.lightGray)

    public static let signupErrorLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 14), fontColor: .red)

    public static let signupStep1TitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 25), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static let signupStep1DescriptionLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 18), fontColor: .white)

    public static let signupStep1PasswordSuggestionLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 14), fontColor: .white.withAlphaComponent(0.85))

    public static var signupStep2PasswordSuggestionLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 18)
            }
            let bold = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 18)
            }
            let base = StyleGroup(base: normal, ["b": bold])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 18), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static var completeSignupEmailLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = UIColor.black
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 18)
            }
            let bold = SwiftRichString.Style {
                $0.color = UIColor.black
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 18)
            }
            let base = StyleGroup(base: normal, ["b": bold])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 18), fontColor: UIColor.black, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static var askLimitCharMessageUnder: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = AppAsset.gray.color
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 15)
            }
            let bold = SwiftRichString.Style {
                $0.color = AppAsset.gray.color
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 15)
            }
            let base = StyleGroup(base: normal, ["b": bold])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 18), fontColor: UIColor.black, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static var askLimitCharMessageOver: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = AppAsset.red.color
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 15)
            }
            let bold = SwiftRichString.Style {
                $0.color = AppAsset.red.color
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 15)
            }
            let base = StyleGroup(base: normal, ["b": bold])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 18), fontColor: UIColor.red, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static var signupPrivacyLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: AppAsset.grayOpaque.color)

    public static var editProfilePrivacyLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: AppAsset.grayOpaque.color)

    public static var editProfileSelectedPrivacyLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: AppAsset.grayOpaque.color)

    public static var profilePrivacyLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: .white)

    public static let modalTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 18), fontColor: .black)

    public static let modalDescriptionLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: .lightGray)

    public static let fullNameLabelProfile = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor)

    public static var profilePrivacyTerms: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = AppAsset.grayOpaque.color
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 15)
            }

            // TODO:
            let privacyURL = URL(string: "https://www.google.it")
            let termsURL = URL(string: "https://www.google.it")

            let privacy = SwiftRichString.Style {
                $0.underline = (.single, AppAsset.grayOpaque.color)
                $0.linkURL = privacyURL
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 15)
            }

            let terms = SwiftRichString.Style {
                $0.underline = (.single, AppAsset.grayOpaque.color)
                $0.linkURL = termsURL
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 15)
            }

            let base = StyleGroup(base: normal, ["p": privacy, "t": terms])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryMediumFont.font(size: 13), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let notLoggedInMenuLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: .white)

    public static let labelMenu = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let labelSettings = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: .black)

    public static var labelSettingsItem: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = AppAsset.grayOpaque.color
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 15)
            }
            let bold = SwiftRichString.Style {
                $0.color = AppAsset.grayOpaque.color
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 18)
            }
            let base = StyleGroup(base: normal, ["b": bold])
            return base
        }()

        let style = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: AppAsset.grayOpaque.color, attributedTextStyle: attributedTextStyle, minimumScaleFactor: 1, adjustsFontSizeToFitWidth: false)
        return style
    }

    public static let labelManteinanceTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 25), fontColor: .white)

    public static let labelManteinanceDescription = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 18), fontColor: .white)

    public static let labelBannedUserTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 25), fontColor: .white)

    public static let labelBannedUserDescription = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 18), fontColor: .white)

    public static let labelBannedUserWriteMail = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: .white)

    public static let labelBannedUserMailValue = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: .white)

    public static let labelFeedbackTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let labelFeedbackSubtitle = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: ThemeManager.currentTheme().tertiaryColor)

    public static let membershipPromoTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 25), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let membershipPromoOptionTitleLabel =
        LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: .black)

    public static let membershipPromoOptionSubtitleLabel =
        LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: AppAsset.gray.color)

    public static let membershipTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .white)

    public static let membershipSubtitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: .white.withAlphaComponent(0.85))

    public static var homeBlockDividerLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: .black)

    public static var homeBlockCTADividerLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor)

    public static var homeBlockWelcomeLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 23), fontColor: .white)

    public static let homeBlockArticleDate = LabelStyles(font: ThemeManager.currentTheme().primaryItalicFont.font(size: 15), fontColor: .white)

    public static let homeBlockArticleTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 25), fontColor: .white, adjustsFontSizeToFitWidth: false)

    public static let homeBlockMatchStatusLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: .black)

    public static let homeSliderCardTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 23), fontColor: .white, adjustsFontSizeToFitWidth: false)

    public static let homeSplitCardTitleNews = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .black, adjustsFontSizeToFitWidth: false)

    public static let homeSplitCardTitleGallery = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .white, adjustsFontSizeToFitWidth: false)

    public static let articleListTagLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 12), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let articleDetailTagLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let tagHeaderArticleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: .lightGray)

    public static let timeAgoLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 12), fontColor: .lightGray)

    public static let photoNumberLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: .lightGray)

    public static let headerListArticlesTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 25), fontColor: .white)

    public static var homeBlockMatchDateLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 18)
            }
            let bold = SwiftRichString.Style {
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 18)
            }
            let base = StyleGroup(base: normal, ["b": bold])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 22), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let homeBlockMatchStadiumLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: .white)

    public static let homeBlockMatchResultsLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 25), fontColor: .white)

    public static let homeBlockMatchTeamLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 16), fontColor: ThemeManager.currentTheme().tertiaryColor)

    public static let homeBlockTitleMediaLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 16), fontColor: .black)

    public static let extraGalleryLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 16), fontColor: .white)

    public static let articleTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 16), fontColor: .black)

    public static let articleDetailDateLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 16), fontColor: AppAsset.lighGray.color)

    public static let articleDetailDateLabelAlternative = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 16), fontColor: .white)

    public static let articleDetailTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 22), fontColor: .black)

    public static let articleDetailTitleLabelAlternative = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 22), fontColor: .white)

    public static let articleDetailTagLabelAlternative = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: .white)

    public static let articleDetailAuthorNameLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 16), fontColor: .darkGray)

    public static let articleAbstractLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 16), fontColor: .black)

    public static var articleDetailBodyLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = UIColor.black
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 18)
            }
            let bold = SwiftRichString.Style {
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 18)
            }
            let base = StyleGroup(base: normal, ["strong": bold])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 18), fontColor: UIColor.black, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let readNextArticleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 16), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let galleryDetailTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .white)

    public static let videoGalleryCardListTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .white)

    public static let videoGalleryCategoryLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: .white.withAlphaComponent(0.70))

    public static let videoGalleryMinutesLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: .white.withAlphaComponent(0.70))

    public static let galleryDetailDateLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 14), fontColor: AppAsset.offWhite.color)

    public static let galleryCarouselTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .white)

    public static let videoGalleryDetailTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 23), fontColor: .white)

    public static let videoGalleryDetailDurationLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: .white)

    public static let fanCamTitleShareLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 35), fontColor: .black)

    public static let fanCamSendPhotoLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 16), fontColor: .white)

    public static let fanCamDescriptionShareLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: ThemeManager.currentTheme().primaryColor)

    public static var matchFinishedResultLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = AppAsset.offWhite.color
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 35)
            }

            let bold = SwiftRichString.Style {
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 35)
                $0.color = UIColor.white
            }

            let separator = SwiftRichString.Style {
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 40)
                $0.color = ThemeManager.currentTheme().tertiaryColor.withAlphaComponent(0.5)
            }

            let base = StyleGroup(base: normal, ["b": bold, "s": separator])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 22), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static var matchFinishedResultAlternativeLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = AppAsset.darkGray.color.withAlphaComponent(0.8)
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 35)
            }

            let bold = SwiftRichString.Style {
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 35)
                $0.color = AppAsset.darkGray.color
            }

            let separator = SwiftRichString.Style {
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 40)
                $0.color = AppAsset.darkGray.color.withAlphaComponent(0.5)
            }

            let base = StyleGroup(base: normal, ["b": bold, "s": separator])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 22), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let matchFinishedTeamNameLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: ThemeManager.currentTheme().tertiaryColor.withAlphaComponent(0.9))

    public static let liveMatchLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 12), fontColor: .white)

    public static let nextMatchCountdownValueLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 25), fontColor: .white)

    public static let nextMatchCountdownLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 12), fontColor: ThemeManager.currentTheme().tertiaryColor.color)

    public static let nextMatchCountdownSeparator = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: .white.withAlphaComponent(0.5))

    public static let matchCancelledLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .white)

    public static let matchPostPonedLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .white)

    public static var finishedMatchDateLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 15)
            }
            let bold = SwiftRichString.Style {
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 15)
            }
            let base = StyleGroup(base: normal, ["b": bold])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 22), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static var finishedMatchDateAlternativeLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = AppAsset.grayOpaque.color
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 15)
            }
            let bold = SwiftRichString.Style {
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 15)
            }
            let base = StyleGroup(base: normal, ["b": bold])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 22), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let galleryTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 24), fontColor: .black)

    public static let splitGalleryTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 16), fontColor: .black, adjustsFontSizeToFitWidth: false)

    public static let gallerydateLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: .darkGray)

    public static let splitGallerydateLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 12), fontColor: .darkGray)

    public static let galleryCategoryLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 12), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let galleryDetailCategoryLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: .white.withAlphaComponent(0.7))

    public static let galleryDetailHeaderLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .white)

    public static let relatedVideoGalleryDetailTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 16), fontColor: .white)

    public static let relatedVideoGalleryDetailTimeLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: .lightGray)

    public static let relatedVideoDetailCategoryLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 12), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static let moreInfoGalleryLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 25), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static let extraFollowLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: ThemeManager.currentTheme().navigationBarForegroundColor)

    public static let appVersionLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 17), fontColor: .darkGray.withAlphaComponent(0.3))

    public static let rankingLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: .black)

    public static let rankingLabelPoints = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .black)

    public static let rankingLabelWhite = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: .white)

    public static let rankingLabelMyTeam = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .white)

    public static let rankingExtraInfoLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: AppAsset.brandTertiary.color)

    public static let rankingLegendLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 13), fontColor: .white)

    public static let rankingChampionshipLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 13), fontColor: .white.withAlphaComponent(0.7), minimumScaleFactor: 1, adjustsFontSizeToFitWidth: false)

    public static let numberPlayerListLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 57), fontColor: .white)

    public static var namePlayerListLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 18)
            }
            let bold = SwiftRichString.Style {
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 25)
            }
            let base = StyleGroup(base: normal, ["b": bold])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static var staffNamePlayerListLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let name = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 18)
            }
            let surname = SwiftRichString.Style {
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 25)
            }
            let staffRole = SwiftRichString.Style {
                $0.color = ThemeManager.currentTheme().secondaryColor
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 13)
            }
            let base = StyleGroup(base: name, ["b": surname, "s": staffRole])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let positionPlayerLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 16), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let playerDetailInFieldLabelLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: .red)

    public static let numberRosterDetailLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 250), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let positionRosterDetailLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 13), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static let staffRolePlayerListLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 13), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static var nameRosterDetailLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 30)
            }
            let bold = SwiftRichString.Style {
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 45)
            }
            let base = StyleGroup(base: normal, ["b": bold])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryMediumFont.font(size: 30), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let nameHeaderRosterDetailLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 30), fontColor: .white)

    public static let generalInfoLabelRosterDetail = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: .white)

    public static var playerSingleInformationLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let subtitle = SwiftRichString.Style {
                $0.color = UIColor.darkGray
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 13)
            }
            let title = SwiftRichString.Style {
                $0.color = ThemeManager.currentTheme().primaryColor
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 18)
            }
            let base = StyleGroup(base: title, ["s": subtitle])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let biographyLabelPLayerDetail = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: AppAsset.grayOpaque.color)

    public static var biographyBodyLabelPLayerDetail: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let abstract = SwiftRichString.Style {
                $0.color = ThemeManager.currentTheme().primaryColor
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 18)
            }

            let paragraph = SwiftRichString.Style {
                $0.color = UIColor.black
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 15)
            }

            let body = SwiftRichString.Style {
                $0.color = UIColor.black
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 15)
            }

            let base = StyleGroup(base: body, ["h1": abstract, "p": paragraph])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: UIColor.black, attributedTextStyle: attributedTextStyle, minimumScaleFactor: 1, adjustsFontSizeToFitWidth: false)
        return style
    }

    public static let socialFollowRosterDetailLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: AppAsset.grayOpaque.color)

    public static let statsLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: AppAsset.grayOpaque.color)

    public static let statsValueLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 16), fontColor: AppAsset.grayOpaque.color)

    public static let generalStatsLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: AppAsset.grayOpaque.color)

    public static var playerDetailStatsLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let statsValue = SwiftRichString.Style {
                $0.color = ThemeManager.currentTheme().primaryColor
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 30)
            }

            let statsType = SwiftRichString.Style {
                $0.color = AppAsset.grayOpaque.color
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 13)
            }

            let normal = SwiftRichString.Style {
                $0.color = AppAsset.grayOpaque.color
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 13)
            }

            let base = StyleGroup(base: normal, ["v": statsValue, "t": statsType])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: UIColor.black, attributedTextStyle: attributedTextStyle, minimumScaleFactor: 0.7, adjustsFontSizeToFitWidth: true)
        return style
    }

    public static let headerStatsLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: AppAsset.grayOpaque.color)

    public static let storeLocatorTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let storeLocatorSubtitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: AppAsset.grayOpaque.color)

    public static let storeLocatorPlaceName = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: AppAsset.grayOpaque.color)

    public static let storeLocatorPlaceAddress = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: AppAsset.lighGray.color)

    public static let storeLocatorPlaceDistance = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: .black)

    public static let storeLocatorDetailTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor)

    public static var storeLocatorDetailLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let titleType = SwiftRichString.Style {
                $0.color = UIColor.black
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 13)
            }

            let valueLabel = SwiftRichString.Style {
                $0.color = AppAsset.grayOpaque.color
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 15)
            }

            let base = StyleGroup(base: valueLabel, ["v": valueLabel, "t": titleType])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: UIColor.darkGray, attributedTextStyle: attributedTextStyle, minimumScaleFactor: 0.7, adjustsFontSizeToFitWidth: true)
        return style
    }

    public static let storeLocatorDetailDistance = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 13), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let udpateAvailableNotMandatory = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let udpateAvailableSubtitleNotMandatory = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: AppAsset.lighGray.color)

    public static let udpateAvailableDescriptionNotMandatory = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: .black)

    public static let lastNewsRosterDetailLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: AppAsset.grayOpaque.color)

    public static let roleLabelPlayersList = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 13), fontColor: .white.withAlphaComponent(0.7), minimumScaleFactor: 1, adjustsFontSizeToFitWidth: false)

    public static let membershipCardSmartTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 32), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let membershipCardPremiumTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 32), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static let membershipCardExclusiveTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 32), fontColor: .white)

    public static let membershipPerkTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: .black)

    public static let membershipPerkDescriptionLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: AppAsset.gray.color, minimumScaleFactor: 1, adjustsFontSizeToFitWidth: false)

    public static let membershipPerksHeaderLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: .black)

    public static let membershipMostRequestedLabel = LabelStyles(backgroundColor: ThemeManager.currentTheme().secondaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: ThemeManager.currentTheme().primaryColor)

    public static var membershipPrivacyTerms: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = AppAsset.gray.color
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 13)
            }

            // TODO:
            let privacyURL = URL(string: "https://www.google.it")
            let termsURL = URL(string: "https://www.google.it")

            let privacy = SwiftRichString.Style {
                $0.linkURL = privacyURL
                $0.underline = (.single, AppAsset.gray.color)
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 13)
            }

            let terms = SwiftRichString.Style {
                $0.linkURL = termsURL
                $0.underline = (.single, AppAsset.gray.color)
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 13)
            }

            let paymentsConditions = SwiftRichString.Style {
                $0.linkURL = termsURL
                $0.underline = (.single, AppAsset.gray.color)
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 13)
            }

            let base = StyleGroup(base: normal, ["p": privacy, "t": terms, "c": paymentsConditions])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: AppAsset.gray.color, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let membershipInfoTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let membershipInfoSubitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: ThemeManager.currentTheme().tertiaryColor)

    public static var membershipInfoDescriptionLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let colorized = SwiftRichString.Style {
                $0.color = ThemeManager.currentTheme().primaryColor
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 15)
            }
            let normal = SwiftRichString.Style {
                $0.color = AppAsset.grayOpaque.color
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 15)
            }
            let base = StyleGroup(base: normal, ["c": colorized])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: AppAsset.grayOpaque.color, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let stickersCopyLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: AppAsset.grayOpaque.color)

    public static let quizOnboardingLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: .white)

    public static let quizSponsorByLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 12), fontColor: .white)

    public static let quizHeaderLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static let quizDescriptionLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .white)

    public static let quizFooterLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: ThemeManager.currentTheme().tertiaryColor)

    public static let quizInfoTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let quizCountdownValueLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 20), fontColor: .white)

    public static let quizCountdownLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 12), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static let quizStringDateLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 13), fontColor: .white)

    public static let quizNextQuestionInLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 13), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static let quizGameTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: .white)

    public static let quizGameTimerLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 40), fontColor: .black)

    public static let quizGameQuestionLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 23), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let quizGameAnswerLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: .black)

    public static let quizGameSelectedAnswerLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: .white)

    public static let quizGamePointsLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: UIColor.green)

    public static let quizGamePointsLabelAlternative = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: AppAsset.brandPrimary.color)

    public static let quizGameSponsorByLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 12), fontColor: UIColor.lightGray)

    public static let quizGameCloseMessageLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 12), fontColor: .white)

    public static let quizFirstRankingPositionLabel = LabelStyles(backgroundColor: AppAsset.firstRankAlternative.color, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: AppAsset.firstRank.color)

    public static let quizSecondRankingPositionLabel = LabelStyles(backgroundColor: AppAsset.secondRankAlternative.color, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: AppAsset.secondRank.color)

    public static let quizThirdRankingPositionLabel = LabelStyles(backgroundColor: AppAsset.thirdRankAlternative.color, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: AppAsset.thirdRank.color)

    public static let nominateWinnerLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static var quizNameAndPointsLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let bold = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 13)
            }
            let normal = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 13)
            }
            let italic = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryItalicFont.font(size: 13)
            }

            let base = StyleGroup(base: normal, ["b": bold, "i": italic])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: .white, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let quizRankingCountdownLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 12), fontColor: .white.withAlphaComponent(0.5))

    public static let quizRankingCountdownValueLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 25), fontColor: .white)

    public static let quizRankingStringDateLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: .white)

    public static let quizRankingCountdownSeparatorView = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: AppAsset.firstRankAlternative.color)

    public static let quizRankingPositionLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: AppAsset.grayOpaque.color)

    public static let quizRankingNameLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: AppAsset.grayOpaque.color)

    public static var quizRankingPointsLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = ThemeManager.currentTheme().primaryColor
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 17)
            }
            let italic = SwiftRichString.Style {
                $0.color = ThemeManager.currentTheme().primaryColor
                $0.font = ThemeManager.currentTheme().primaryItalicFont.font(size: 17)
            }

            let base = StyleGroup(base: normal, ["i": italic])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 17), fontColor: ThemeManager.currentTheme().primaryColor, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let liveMatchDetailLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: .white)

    public static let liveMatchDetailStadiumLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 13), fontColor: ThemeManager.currentTheme().tertiaryColor)

    public static let matchDetailTeamName = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 13), fontColor: .white, minimumScaleFactor: 1, adjustsFontSizeToFitWidth: false)

    public static var matchDetailFinishedResultLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = AppAsset.offWhite.color
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 35)
            }

            let bold = SwiftRichString.Style {
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 35)
                $0.color = UIColor.white
            }

            let separator = SwiftRichString.Style {
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 40)
                $0.color = ThemeManager.currentTheme().tertiaryColor.withAlphaComponent(0.5)
            }

            let base = StyleGroup(base: normal, ["b": bold, "s": separator])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 35), fontColor: UIColor.white, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let matchDetailDateLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 13), fontColor: .white)

    public static let finalResultLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 12), fontColor: .white)

    public static let startMatchLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 12), fontColor: ThemeManager.currentTheme().secondaryColor)

    public static let hashtagLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: AppAsset.lighGray.color)

    public static var matchDetailScheduledDateLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = UIColor.white.withAlphaComponent(0.8)
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 15)
            }
            let bold = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 15)
            }

            let base = StyleGroup(base: normal, ["b": bold])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: .white.withAlphaComponent(0.8), attributedTextStyle: attributedTextStyle, minimumScaleFactor: 1, adjustsFontSizeToFitWidth: false)
        return style
    }

    public static let matchDetailInfoTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let matchDetailInfoHoursLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: AppAsset.lighGray.color)

    public static let matchDetailInfoDateLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 18), fontColor: AppAsset.grayOpaque.color)

    public static let matchDetailInfoLocationLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 16), fontColor: AppAsset.grayOpaque.color)

    public static let matchDetailInfoRefereeLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 16), fontColor: AppAsset.grayOpaque.color)

    public static let matchDetailTicketsTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 25), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let matchDetailBuyMessageLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: AppAsset.grayOpaque.color)

    public static let commentaryUpdateLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 14), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let gameTimeUnselected = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 13), fontColor: AppAsset.grayOpaque.color.withAlphaComponent(0.6))

    public static let commentaryNoteLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 14), fontColor: AppAsset.darkBlue.color, minimumScaleFactor: 0.75, adjustsFontSizeToFitWidth: true)

    public static let commentaryNoteAlternativeLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 14), fontColor: AppAsset.darkBlue.color.withAlphaComponent(0.5))

    public static let commentaryStartPeriodSubtitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 12), fontColor: AppAsset.darkBlue.color.withAlphaComponent(0.5))

    public static let commentaryStartPeriodTitleLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 14), fontColor: AppAsset.darkBlue.color)

    public static let matchDetailLineUpShirtNumberLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 11), fontColor: .white)

    public static var matchDetailLineUpnameAndRoleLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let name = SwiftRichString.Style {
                $0.color = AppAsset.grayOpaque.color
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 14)
            }

            let role = SwiftRichString.Style {
                $0.color = AppAsset.darkBlue.color
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 12)
            }

            let base = StyleGroup(base: name, ["r": role])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryMediumFont.font(size: 14), fontColor: AppAsset.grayOpaque.color, attributedTextStyle: attributedTextStyle, minimumScaleFactor: 1, adjustsFontSizeToFitWidth: false)
        return style
    }

    public static let matchDetailLineUpHeader = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 14), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let matchDetailSubstitutesHeader = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 14), fontColor: AppAsset.warmBrown.color)

    public static let matchDetailOursMatchesLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 14), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let matchDetailOthersMatchesLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 14), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let matchDetailTeamsTrendLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 14), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let matchDetailTeamsVersusLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 10), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let matchDetailNewsLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 14), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let matchDetailWebViewLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 14), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let matchDetailTicketsLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 14), fontColor: ThemeManager.currentTheme().primaryColor)

    public static let matchDetailPreMatchPositionLabel = LabelStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: AppAsset.lighGray.color)

    public static let matchDetailPreMatchValuePositionLabel = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 25), fontColor: .white)

    public static let matchDetailPreMatchStatsTitle = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 14), fontColor: AppAsset.darkGray.color)

    public static let matchDetailPreMatchStatsValue = LabelStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 14), fontColor: AppAsset.darkGray.color)

    public static let matchDetailPreMatchFooterLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 14), fontColor: AppAsset.lighGray.color)

    public static var profileItemLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let titleType = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 18)
            }

            let valueLabel = SwiftRichString.Style {
                $0.color = AppAsset.gray.color
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 14)
            }

            let base = StyleGroup(base: valueLabel, ["v": valueLabel, "t": titleType])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryMediumFont.font(size: 14), fontColor: AppAsset.gray.color, attributedTextStyle: attributedTextStyle, minimumScaleFactor: 0.7, adjustsFontSizeToFitWidth: true)
        return style
    }

    public static var profileLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let titleType = SwiftRichString.Style {
                $0.color = ThemeManager.currentTheme().primaryColor
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 20)
            }

            let valueLabel = SwiftRichString.Style {
                $0.color = AppAsset.gray.color
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 18)
            }

            let base = StyleGroup(base: valueLabel, ["v": valueLabel, "t": titleType])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: AppAsset.gray.color, attributedTextStyle: attributedTextStyle, minimumScaleFactor: 0.7, adjustsFontSizeToFitWidth: true)
        return style
    }

    public static var profileDeleteAccountLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let titleType = SwiftRichString.Style {
                $0.color = ThemeManager.currentTheme().primaryColor
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 20)
            }

            let valueLabel = SwiftRichString.Style {
                $0.color = AppAsset.gray.color
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 18)
            }

            let base = StyleGroup(base: valueLabel, ["v": valueLabel, "t": titleType])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: AppAsset.gray.color, attributedTextStyle: attributedTextStyle, minimumScaleFactor: 0.7, adjustsFontSizeToFitWidth: true)
        return style
    }

    public static let profileDeleteAccountMessageLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: AppAsset.grayOpaque.color)

    public static let fakeRefreshControl = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 13), fontColor: .white)

    public static var notificationReminderTitle: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let title = SwiftRichString.Style {
                $0.color = ThemeManager.currentTheme().primaryColor
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 20)
            }

            let subtitle = SwiftRichString.Style {
                $0.color = AppAsset.gray.color
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 18)
            }

            let base = StyleGroup(base: title, ["t": title, "s": subtitle])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: AppAsset.gray.color, attributedTextStyle: attributedTextStyle, minimumScaleFactor: 0.7, adjustsFontSizeToFitWidth: true)
        return style
    }

    public static let notificationReminderDescription = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: AppAsset.grayOpaque.color)

    public static let loginBottomSheetDescription = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: AppAsset.grayOpaque.color)

    public static var loginBottomSheetTitle: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let title = SwiftRichString.Style {
                $0.color = ThemeManager.currentTheme().primaryColor
                $0.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 20)
            }

            let subtitle = SwiftRichString.Style {
                $0.color = AppAsset.gray.color
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 18)
            }

            let base = StyleGroup(base: title, ["t": title, "s": subtitle])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: AppAsset.gray.color, attributedTextStyle: attributedTextStyle, minimumScaleFactor: 0.7, adjustsFontSizeToFitWidth: true)
        return style
    }

    public static var scorerLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let minute = SwiftRichString.Style {
                $0.color = AppAsset.lighGray.color
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 13)
            }

            let scorer = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 13)
            }

            let base = StyleGroup(base: minute, ["m": minute, "s": scorer])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 13), fontColor: AppAsset.lighGray.color, attributedTextStyle: attributedTextStyle, minimumScaleFactor: 0.7, adjustsFontSizeToFitWidth: true)
        return style
    }

    public static var matchDetailEventLabel: LabelStyles {
        let attributedTextStyle: StyleGroup = {
            let title = SwiftRichString.Style {
                $0.color = AppAsset.grayOpaque.color
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 14)
            }

            let substitutePlayer = SwiftRichString.Style {
                $0.color = AppAsset.darkBlue.color
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 12)
            }

            let base = StyleGroup(base: title, ["t": title, "s": substitutePlayer])
            return base
        }()

        let style = LabelStyles(backgroundColor: UIColor.clear, font: ThemeManager.currentTheme().primaryFont.font(size: 12), fontColor: AppAsset.darkBlue.color, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let matchDetailSubstitutionMinuteLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 12), fontColor: AppAsset.grayOpaque.color)

    public static let matchDetailSubstitutionNumberInPlayerLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 11), fontColor: .white)

    public static let matchDetailSubstitutionNumberOutPlayerLabel = LabelStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 9), fontColor: .white)
}
