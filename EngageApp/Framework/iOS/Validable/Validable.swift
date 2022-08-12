//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

// MARK: - Validable

public protocol Validable {
    /// Used to set a validations list to check
    var validations: [ValidationType] { get set }
    /// Used to get the type of view to observe
    var viewToObserve: UIView? { get set }
    /// Used to set the type of view to observe
    func setViewToObserve(view: UIView)
    /// Used to define the behaviour in case of validation not passed
    func showError(text: String)
}

// MARK: - ValidationType

public enum ValidationType: Equatable {
    case password
    case email
    case notEmpty(type: InputTypesEnumValidable)
    case picture
    case privacy(type: PrivacyTypesEnumValidable)
    case phone
    case none
}

// MARK: - InputTypesEnumValidable

public enum InputTypesEnumValidable {
    case firstName
    case lastName
    case gender
    case birthday
    case country
    case prefix

    public init(inputTypesEnumValidation: InputTypesEnumValidation) {
        switch inputTypesEnumValidation {
        case .firstName:
            self = .firstName
        case .lastName:
            self = .lastName
        case .birthday:
            self = .birthday
        case .country:
            self = .country
        case .gender:
            self = .gender
        case .prefix:
            self = .prefix
        }
    }
}

// MARK: - PrivacyTypesEnumValidable

public enum PrivacyTypesEnumValidable {
    case terms
    case newsletter
    case marketing
    case marketingThirdParty
    case profiling
    case profilingThirdParty

    public init(privacyTypesEnumValidation: PrivacyTypesEnumValidation) {
        switch privacyTypesEnumValidation {
        case .terms:
            self = .terms
        case .newsletter:
            self = .newsletter
        case .marketing:
            self = .marketing
        case .marketingThirdParty:
            self = .marketingThirdParty
        case .profiling:
            self = .profiling
        case .profilingThirdParty:
            self = .profilingThirdParty
        }
    }
}
