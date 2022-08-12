//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

// MARK: - Theme

public struct Theme {
    /// Colors
    public var primaryColor: UIColor
    public var secondaryColor: UIColor
    public var tertiaryColor: UIColor
    public var backgroundColor: UIColor
    public var navigationBarBackgroundColor: UIColor
    public var navigationBarForegroundColor: UIColor
    public var tabBarBackgroundColor: UIColor
    public var tabBarForegroundColor: UIColor
    public var gradientSecondaryColor: UIColor

    /// Customizing the Navigation Bar
    public var barStyle: UIBarStyle
    public var navigationBackgroundImage: UIImage?
    public var tabBarBackgroundImage: UIImage?

    /// Primary Font
    public var primaryFont: CustomFont
    public var primaryBoldFont: CustomFont
    public var primaryMediumFont: CustomFont
    public var primaryItalicFont: CustomFont

    /// Secondary Font
    public var secondary300: CustomFont
    public var secondary300Italic: CustomFont
    public var secondary600: CustomFont
    public var secondary600Italic: CustomFont
    public var secondary700: CustomFont
    public var secondary700Italic: CustomFont
    public var secondary800: CustomFont
    public var secondary800Italic: CustomFont

    public init(primaryColor: UIColor? = nil, secondaryColor: UIColor? = nil, tertiaryColor: UIColor? = nil, navigationBarBackgroundColor: UIColor? = nil, navigationBarForegroundColor: UIColor? = nil, tabBarBackgroundColor: UIColor? = nil, tabBarForegroundColor: UIColor? = nil, gradientSecondaryColor: UIColor? = nil, barStyle: UIBarStyle, navigationBackgroundImage: UIImage? = UIImage(), tabBarBackgroundImage: UIImage? = UIImage(), backgroundColor: UIColor? = nil, primaryFont: CustomFont, primaryBoldFont: CustomFont, primaryMediumFont: CustomFont, primaryItalicFont: CustomFont, secondary300: CustomFont? = nil, secondary300Italic: CustomFont? = nil, secondary600: CustomFont? = nil, secondary600Italic: CustomFont? = nil, secondary700: CustomFont? = nil, secondary700Italic: CustomFont? = nil, secondary800: CustomFont? = nil, secondary800Italic: CustomFont? = nil) {
        self.primaryColor = primaryColor ?? AppAsset.brandPrimary.color
        self.secondaryColor = secondaryColor ?? AppAsset.brandSecondary.color
        self.tertiaryColor = tertiaryColor ?? AppAsset.brandTertiary.color
        self.navigationBarBackgroundColor = navigationBarBackgroundColor ?? AppAsset.navigationBarBackgroundColor.color
        self.navigationBarForegroundColor = navigationBarForegroundColor ?? AppAsset.navigationBarForegroundColor.color
        self.tabBarBackgroundColor = tabBarBackgroundColor ?? AppAsset.tabBarBackgroundColor.color
        self.tabBarForegroundColor = tabBarForegroundColor ?? AppAsset.tabBarForegroundColor.color
        self.gradientSecondaryColor = gradientSecondaryColor ?? AppAsset.gradientSecondaryColor.color
        self.barStyle = barStyle
        self.navigationBackgroundImage = navigationBackgroundImage
        self.tabBarBackgroundImage = tabBarBackgroundImage
        self.backgroundColor = backgroundColor ?? AppAsset.background.color

        self.primaryFont = primaryFont
        self.primaryBoldFont = primaryBoldFont
        self.primaryMediumFont = primaryMediumFont
        self.primaryItalicFont = primaryItalicFont

        self.secondary300 = secondary300 ?? primaryFont
        self.secondary300Italic = secondary300Italic ?? primaryFont
        self.secondary600 = secondary600 ?? primaryFont
        self.secondary600Italic = secondary600Italic ?? primaryFont
        self.secondary700 = secondary700 ?? primaryFont
        self.secondary700Italic = secondary700Italic ?? primaryFont
        self.secondary800 = secondary800 ?? primaryFont
        self.secondary800Italic = secondary800Italic ?? primaryFont
    }
}

// MARK: - ThemeManager

public enum ThemeManager {
    public static var defaultTheme = Theme(
        primaryColor: .white,
        secondaryColor: .black,
        tertiaryColor: .black,
        barStyle: .default,
        navigationBackgroundImage: nil,
        tabBarBackgroundImage: nil,
        backgroundColor: .white,
        primaryFont: CustomFont(stringLiteral: "OpenSans-Regular"),
        primaryBoldFont: CustomFont(stringLiteral: "OpenSans-Bold"),
        primaryMediumFont: CustomFont(stringLiteral: "OpenSans-ExtraBold"),
        primaryItalicFont: CustomFont(stringLiteral: "OpenSans-Italic"),

        secondary300: CustomFont(stringLiteral: "OpenSans-300"),
        secondary300Italic: CustomFont(stringLiteral: "OpenSans-300italic"),
        secondary600: CustomFont(stringLiteral: "OpenSans-600"),
        secondary600Italic: CustomFont(stringLiteral: "OpenSans-600italic"),
        secondary700: CustomFont(stringLiteral: "OpenSans-700"),
        secondary700Italic: CustomFont(stringLiteral: "OpenSans-700italic"),
        secondary800: CustomFont(stringLiteral: "OpenSans-800"),
        secondary800Italic: CustomFont(stringLiteral: "OpenSans-800italic")
    )

    public static var customTheme: Theme?

    public static func currentTheme() -> Theme {
        return customTheme ?? defaultTheme
    }

    public static func applyTheme(theme: Theme) {
        ThemeManager.customTheme = theme

        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = theme.primaryColor

        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(theme.navigationBackgroundImage, for: .default)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20)]
        if let backArrow = UIImage(systemName: "arrow.backward") {
            UINavigationBar.appearance().backIndicatorImage = backArrow
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = backArrow
        }

        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear, NSAttributedString.Key.font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20)], for: .normal)

        UITabBar.appearance().barStyle = theme.barStyle
        UITabBar.appearance().backgroundImage = theme.tabBarBackgroundImage
        UITabBar.appearance().tintColor = theme.tabBarForegroundColor

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundEffect = .init(style: .dark)
        tabBarAppearance.backgroundColor = theme.tabBarBackgroundColor.withAlphaComponent(0.7)

        let itemTabBarAppearance = UITabBarItemAppearance()
        itemTabBarAppearance.normal.iconColor = .white.withAlphaComponent(0.5)
        itemTabBarAppearance.selected.iconColor = theme.tabBarForegroundColor
        itemTabBarAppearance.selected.titleTextAttributes = [NSAttributedString.Key.font: ThemeManager.currentTheme().primaryBoldFont.font(size: 12), NSAttributedString.Key.foregroundColor: theme.tabBarForegroundColor, .paragraphStyle: NSParagraphStyle.default]
        itemTabBarAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: theme.primaryMediumFont.font(size: 11), NSAttributedString.Key.foregroundColor: UIColor.white, .paragraphStyle: NSParagraphStyle.default]
        itemTabBarAppearance.normal.titlePositionAdjustment = .init(horizontal: 0, vertical: -8)

        tabBarAppearance.compactInlineLayoutAppearance = itemTabBarAppearance
        tabBarAppearance.inlineLayoutAppearance = itemTabBarAppearance
        tabBarAppearance.stackedLayoutAppearance = itemTabBarAppearance

        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }

        UISwitch.appearance().onTintColor = .systemGreen
        UISwitch.appearance().thumbTintColor = .white
    }

    public static func applyOpaqueTheme(to navigationController: UINavigationController?) {
        navigationController?.navigationBar.isTranslucent = false

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = ThemeManager.currentTheme().navigationBarBackgroundColor
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ThemeManager.currentTheme().navigationBarForegroundColor, NSAttributedString.Key.font: ThemeManager.currentTheme().primaryBoldFont.font(size: 20)]
        appearance.shadowImage = UIImage(color: ThemeManager.currentTheme().navigationBarBackgroundColor)
        appearance.backgroundImage = UIImage(color: ThemeManager.currentTheme().navigationBarBackgroundColor)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        if let backArrow = UIImage(systemName: "arrow.backward") {
            appearance.setBackIndicatorImage(backArrow, transitionMaskImage: backArrow)
        }
    }

    public static func applyTransparentTheme(to navigationController: UINavigationController?) {
        navigationController?.navigationBar.isTranslucent = true

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.shadowImage = UIImage(ciImage: .clear)
        appearance.backgroundImage = UIImage(ciImage: .clear)
        if let backArrow = UIImage(systemName: "arrow.backward") {
            appearance.setBackIndicatorImage(backArrow, transitionMaskImage: backArrow)
        }

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
