//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public extension String {
    func formatValue() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .decimal

        return formater.string(from: NumberFormatter().number(from: self) ?? 0) ?? ""
    }

    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }

    func clearBackSlash() -> String {
        return replacingOccurrences(of: "\"", with: "")
    }

    var htmlAttributedString: NSMutableAttributedString? {
        do {
            if let encodedData = data(using: .utf8) {
                let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue]
                let attributedString = try NSMutableAttributedString(data: encodedData, options: options, documentAttributes: nil)
                let paragraphStyle = NSMutableParagraphStyle()
                let range = NSRange(location: 0, length: attributedString.mutableString.length)
                attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
                return attributedString
            }
            return nil
        } catch {
            return nil
        }
    }
}
