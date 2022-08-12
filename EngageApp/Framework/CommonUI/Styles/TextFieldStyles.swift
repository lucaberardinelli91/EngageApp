//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import SwiftRichString

// MARK: - TextFieldStyles

public struct TextFieldStyles {
    private let backgroundColor: UIColor?
    private let font: UIFont?
    private let fontColor: UIColor
    private let attributedTextStyle: StyleGroup?

    public init(
        backgroundColor: UIColor? = nil,
        font: UIFont? = nil,
        fontColor: UIColor = .black,
        attributedTextStyle: StyleGroup? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.font = font
        self.fontColor = fontColor
        self.attributedTextStyle = attributedTextStyle
    }

    public func apply(to textField: UITextField?) {
        guard let textField = textField else { return }

        textField.font = font
        textField.textColor = fontColor

        if let attributedTextStyle = attributedTextStyle {
            textField.attributedText = textField.text?.set(style: attributedTextStyle)
        }

        if let backgroundColor = backgroundColor {
            textField.backgroundColor = backgroundColor
        }
    }
}

// MARK: - TextFieldsStyle

public enum TextFieldsStyle {
    public static let signup = TextFieldStyles(font: ThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: .black, attributedTextStyle: nil)
}
