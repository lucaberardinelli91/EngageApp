//
//  EngageApp
//  Created by Luca Berardinelli
//

import SwiftRichString
import UIKit

// MARK: - ButtonStyles

public struct ButtonStyles {
    private let backgroundColor: UIColor?
    private let font: UIFont?
    private let fontColor: UIColor
    private let insets: UIEdgeInsets
    private let titleInsets: UIEdgeInsets
    private let imageInsets: UIEdgeInsets
    private let cornerRadius: CGFloat
    private let borderWidth: CGFloat
    private let borderColor: UIColor
    private let tintColor: UIColor?
    private let attributedTextStyle: StyleGroup?

    public init(
        backgroundColor: UIColor? = .clear,
        font: UIFont? = nil,
        fontColor: UIColor = .white,
        insets: UIEdgeInsets = .zero,
        titleInsets: UIEdgeInsets = .zero,
        imageInsets: UIEdgeInsets = .zero,
        borderWidth: CGFloat = 1,
        borderColor: UIColor = .clear,
        cornerRadius: CGFloat = 5,
        tintColor: UIColor? = nil,
        attributedTextStyle: StyleGroup? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.font = font
        self.fontColor = fontColor
        self.insets = insets
        self.titleInsets = titleInsets
        self.imageInsets = imageInsets
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.tintColor = tintColor
        self.attributedTextStyle = attributedTextStyle
    }

    public func apply(to button: UIButton?) {
        guard let button = button else { return }
        button.titleLabel?.font = font
        button.titleLabel?.textColor = fontColor
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.lineBreakMode = .byClipping
        button.contentEdgeInsets = insets
        button.titleEdgeInsets = titleInsets
        button.imageEdgeInsets = imageInsets
        button.layer.cornerRadius = cornerRadius
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = borderColor.cgColor
        button.setTitleColor(fontColor, for: .normal)
        button.setTitleColor(fontColor.withAlphaComponent(0.4), for: .highlighted)

        button.setTitle(button.currentTitle, for: UIControl.State())

        if let backgroundColor = backgroundColor {
            button.backgroundColor = backgroundColor
        }

        if let tintColor = tintColor {
            button.tintColor = tintColor
        }

        if let attributedTextStyle = attributedTextStyle {
            button.setAttributedTitle(button.currentTitle?.set(style: attributedTextStyle), for: .normal)
        }
    }
}

public enum ButtonStyle {
    // button red/orange
    public static let primaryButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().tertiaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: UIColor.white, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 28)

    // button light blue
    public static let secondaryButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().secondaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: UIColor.white, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 28)

    public static let secondaryReverseButton = ButtonStyles(backgroundColor: UIColor.white, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().secondaryColor, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 28)

    public static let dangerReverseButton = ButtonStyles(backgroundColor: UIColor.white, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: AppAsset.brandDanger.color, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 28)

    // swipe
    public static let swipeButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().secondaryColor.withAlphaComponent(0.2), font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: UIColor.white, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 28)

    // button coins
    public static let coinsButton = ButtonStyles(backgroundColor: AppAsset.buttonCoins.color, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 28)

    public static let instantwinButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().secondaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: .white, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 28)

    public static let secondaryDisabledButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().secondaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: AppAsset.clear.color, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 28)

    // button white + border light blue
    public static let tertiaryButton = ButtonStyles(backgroundColor: UIColor.white, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().secondaryColor, insets: .init(top: 0, left: 32, bottom: 0, right: 32), borderWidth: 2, borderColor: ThemeManager.currentTheme().secondaryColor, cornerRadius: 28)

    // Welcome
    public static let welcomeEmailNotFoundButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().backgroundColor, font: ThemeManager.currentTheme().primaryFont.font(size: 16), fontColor: AppAsset.grayBase.color)

    // Feedback share
    public static let feedbackShareButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().secondaryColor.withAlphaComponent(0.1), font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().secondaryColor, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 28)

    public static let earnCoinsButton = ButtonStyles(backgroundColor: UIColor.yellow, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: UIColor.white, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 28)

    public static let primaryDisabledButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().secondaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: AppAsset.clear.color, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 10)

    public static let startOnBoardingButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().secondaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 10, tintColor: ThemeManager.currentTheme().primaryColor)

    public static let continueLoginButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().secondaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 10, tintColor: ThemeManager.currentTheme().primaryColor)

    public static let recoverPasswordButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().primaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().secondaryColor, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 10, tintColor: ThemeManager.currentTheme().secondaryColor)

    public static let askSendMessageEnableButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().primaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().secondaryColor, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 10, tintColor: ThemeManager.currentTheme().secondaryColor)

    public static let askSendMessageDisableButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().primaryColor.withAlphaComponent(0.5), font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().secondaryColor, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 10, tintColor: ThemeManager.currentTheme().secondaryColor)

    public static let createAccountButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().primaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().secondaryColor, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 10, tintColor: ThemeManager.currentTheme().secondaryColor)

    public static let continueWelcomeButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().secondaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 10, tintColor: ThemeManager.currentTheme().primaryColor)

    public static let surveyDisabledButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().secondaryColor.withAlphaComponent(0.5), font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 10, tintColor: ThemeManager.currentTheme().primaryColor)

    public static let continueSignupButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().secondaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 10, tintColor: ThemeManager.currentTheme().primaryColor)

    public static let welcomeSurveyButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().secondaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 10, tintColor: ThemeManager.currentTheme().primaryColor)

    public static let routeToWelcomeFromRedCarpetButton = ButtonStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: .white, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 10, tintColor: .white)

    public static let skipButton = ButtonStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 18), fontColor: .white, insets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: .white)

    public static let standardTextButton = ButtonStyles(backgroundColor: .clear, font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: .white, insets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: .white)

    public static let loginButton = ButtonStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: .white, insets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: .white)

    public static let appleButton = ButtonStyles(backgroundColor: .white, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .black, insets: .init(top: 0, left: 0, bottom: 0, right: 0), cornerRadius: 10, tintColor: .white)

    public static let appleAlternativeButton = ButtonStyles(backgroundColor: .black, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .white, insets: .init(top: 0, left: 0, bottom: 0, right: 0), cornerRadius: 10, tintColor: .white)

    public static let facebookButton = ButtonStyles(backgroundColor: AppAsset.facebook.color, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .white, insets: .init(top: 0, left: 0, bottom: 0, right: 0), cornerRadius: 10, tintColor: .white)

    public static let standardSignInButton = ButtonStyles(backgroundColor: .white, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: .black, insets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: .white)

    public static let signupButton = ButtonStyles(backgroundColor: .white, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: .white)

    public static let saveUserProfleButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().primaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().secondaryColor, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: 0, bottom: 0, right: 0), cornerRadius: 10, tintColor: ThemeManager.currentTheme().secondaryColor)

    public static let profileMembershipReadyButton = ButtonStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: .white, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: 0, bottom: 0, right: 0), cornerRadius: 0, tintColor: .white)

    public static let deleteAccountProfileButton = ButtonStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: AppAsset.red.color, insets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: AppAsset.red.color)

    public static let buttonMenu = ButtonStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 17), fontColor: ThemeManager.currentTheme().primaryColor)

    public static var buttonSettings: ButtonStyles {
        let attributedTextStyle: StyleGroup = {
            let normal = SwiftRichString.Style {
                $0.color = UIColor.white
                $0.font = ThemeManager.currentTheme().primaryFont.font(size: 15)
            }
            let bold = SwiftRichString.Style {
                $0.font = ThemeManager.currentTheme().primaryMediumFont.font(size: 18)
            }
            let base = StyleGroup(base: normal, ["b": bold])
            return base
        }()

        let style = ButtonStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: AppAsset.grayOpaque.color, insets: .zero, titleInsets: .zero, imageInsets: .zero, borderWidth: 0, borderColor: .clear, cornerRadius: 0, tintColor: AppAsset.grayOpaque.color, attributedTextStyle: attributedTextStyle)
        return style
    }

    public static let signInOrSignUpButtonMenu = ButtonStyles(backgroundColor: .white, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 32, bottom: 0, right: 32), tintColor: ThemeManager.currentTheme().primaryColor)

    public static let updateAppButton = ButtonStyles(backgroundColor: .white, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 32, bottom: 0, right: 32), tintColor: ThemeManager.currentTheme().primaryColor)

    public static let subscribeMembershipButton = ButtonStyles(backgroundColor: .white, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: .white)

    public static let membershipEditButton = ButtonStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 16), fontColor: UIColor.white.withAlphaComponent(0.69), insets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: .white)

    public static let fanCamStickersButton = ButtonStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: .white, insets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: .white)

    public static let fanCamStickersDisabledButton = ButtonStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: .white.withAlphaComponent(0.65), insets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: .white)

    public static let fanCamFiltersButton = ButtonStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: .white, insets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: .white)

    public static let fanCamFiltersDisabledButton = ButtonStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: .white.withAlphaComponent(0.65), insets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: .white)

    public static let fanCamSendButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().primaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().secondaryColor, insets: .init(top: 0, left: 0, bottom: 0, right: 0), cornerRadius: 10, tintColor: ThemeManager.currentTheme().secondaryColor)

    public static let fanCamNoShareButton = ButtonStyles(backgroundColor: .white, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: .black, insets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: .black)

    public static let shareArticleDetailBigButton = ButtonStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 18), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: -5, bottom: 0, right: 0), borderWidth: 2, borderColor: ThemeManager.currentTheme().primaryColor, cornerRadius: 25, tintColor: ThemeManager.currentTheme().primaryColor)

    public static let nextArticleDetail = ButtonStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 16), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: ThemeManager.currentTheme().primaryColor)

    public static let goToNextMatch = ButtonStyles(backgroundColor: .white, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: -5, bottom: 0, right: 0), borderWidth: 2, borderColor: ThemeManager.currentTheme().primaryColor, cornerRadius: 25, tintColor: ThemeManager.currentTheme().primaryColor)

    public static let goToLiveMatch = ButtonStyles(backgroundColor: .white, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 15), fontColor: .red, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: -5, bottom: 0, right: 0), borderWidth: 1, borderColor: ThemeManager.currentTheme().primaryColor, cornerRadius: 25, tintColor: .red)

    public static let readMoreRosterDetail = ButtonStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: ThemeManager.currentTheme().primaryColor)

    public static let nextOrPreviousRosterDetail = ButtonStyles(font: ThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: .white, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: .white)

    public static let storeLocatorBringMeButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().primaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().secondaryColor, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: ThemeManager.currentTheme().secondaryColor)

    public static let updateAvailableNotMandatory = ButtonStyles(backgroundColor: ThemeManager.currentTheme().primaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().secondaryColor, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: ThemeManager.currentTheme().secondaryColor)

    public static let rememberMeUpdatevailableNotMandatory = ButtonStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: .black, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: .black)

    public static let roleButtonPlayersList = ButtonStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 13), fontColor: .white.withAlphaComponent(0.7), insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: .white)

    public static let restorePurchase = ButtonStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: 0, bottom: 0, right: 0), tintColor: ThemeManager.currentTheme().primaryColor)

    public static let feedbackVoteButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().primaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: AppAsset.lightningYellow.color, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: 0, bottom: 0, right: 0), cornerRadius: 10, tintColor: ThemeManager.currentTheme().secondaryColor)

    public static let feedbackSkipButton =
        ButtonStyles(
            font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20),
            fontColor: ThemeManager.currentTheme().primaryColor,
            insets:
            .init(top: 0, left: 0, bottom: 0, right: 0),
            imageInsets:
            .init(top: 0, left: 0, bottom: 0, right: 0),
            tintColor: .clear
        )

    public static let notNowButton =
        ButtonStyles(
            font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20),
            fontColor: AppAsset.similarBlack.color,
            insets:
            .init(top: 0, left: 0, bottom: 0, right: 0),
            imageInsets:
            .init(top: 0, left: 0, bottom: 0, right: 0),
            tintColor: .clear
        )

    public static let membershipBuyButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().primaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().secondaryColor, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: 0, bottom: 0, right: 0), cornerRadius: 10, tintColor: ThemeManager.currentTheme().secondaryColor)

    public static let sendToWhatsAppButton = ButtonStyles(backgroundColor: AppAsset.whatsapp.color, font: ThemeManager.currentTheme().primaryMediumFont.font(size: 20), fontColor: .white, insets: .init(top: 0, left: 0, bottom: 0, right: 0), cornerRadius: 10, tintColor: .white)

    public static let primaryOnWhiteButton = ButtonStyles(backgroundColor: .white, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: 0, bottom: 0, right: 0), cornerRadius: 10, tintColor: ThemeManager.currentTheme().primaryColor)

    public static let quizStartToPlayButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().secondaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: .black, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: 0, bottom: 0, right: 0), cornerRadius: 10, tintColor: .black)

    public static let quizGoToRankingButton = ButtonStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: .white, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: 0, bottom: 0, right: 0), cornerRadius: 0, tintColor: .white)

    public static let quizGoToRulesButton = ButtonStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: .black, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: 0, bottom: 0, right: 0), cornerRadius: 0, tintColor: .white)

    public static let quizRankingGoToRulesButton = ButtonStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: .white, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: 0, bottom: 0, right: 0), cornerRadius: 0, tintColor: .white)

    public static let cancelButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().primaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().secondaryColor, insets: .init(top: 0, left: 32, bottom: 0, right: 32), cornerRadius: 10, tintColor: ThemeManager.currentTheme().secondaryColor)

    public static let surveyAnswerContinueButton = ButtonStyles(backgroundColor: ThemeManager.currentTheme().secondaryColor, font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: ThemeManager.currentTheme().primaryColor, insets: .init(top: 0, left: 0, bottom: 0, right: 0), titleInsets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(), borderWidth: 1, borderColor: .clear, cornerRadius: 10)

    public static let surveyShareButton = ButtonStyles(font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: .white, insets: .init(top: 0, left: 0, bottom: 0, right: 0), imageInsets: .init(top: 0, left: 0, bottom: 0, right: 0), cornerRadius: 0, tintColor: .white)
}
