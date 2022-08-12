//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

// MARK: - CustomFont

public struct CustomFont {
    public static var all: Set<String> = []

    public func font(size: CGFloat) -> UIFont {
        if let font = UIFont(name: rawString!, size: size) {
            return font
        } else {
            fatalError("No font found!")
        }
    }

    public let rawString: String?

    init() {
        rawString = nil
    }
}

// MARK: ExpressibleByStringLiteral

extension CustomFont: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        rawString = value
        register()
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        rawString = value
        register()
    }

    public init(unicodeScalarLiteral value: String) {
        rawString = value
        register()
    }

    private func register() {
        guard let url = url else { return }
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
    }

    fileprivate var url: URL? {
        return DataBundleResolver.returnMainBundle().url(forResource: (rawString ?? "") + ".ttf", withExtension: nil)
    }
}

// MARK: FontBookie

extension CustomFont: FontBookie {
    public static func == (lhs: CustomFont, rhs: CustomFont) -> Bool {
        if let lhsRaw = lhs.rawString { CustomFont.all.insert(lhsRaw) }
        if let rhsRaw = rhs.rawString { CustomFont.all.insert(rhsRaw) }

        return lhs.rawString == rhs.rawString
    }
}

// MARK: - FontBookie

private protocol FontBookie: Equatable {
    func font(size: CGFloat) -> UIFont
}
