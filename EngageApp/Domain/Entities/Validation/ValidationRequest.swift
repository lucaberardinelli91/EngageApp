//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

// MARK: - ValidationRequest

public enum ValidationRequest {
    case password(String)
    case email(String)
    case picture(image: Data, placeholder: Data)
    case phone(String)
    case notEmpty(InputTypesEnumValidation)
    case privacy(PrivacyTypesEnumValidation)
}

// MARK: - InputTypesEnumValidation

public enum InputTypesEnumValidation {
    case firstName(String)
    case lastName(String)
    case gender(String)
    case birthday(String)
    case country(String)
    case prefix(String)
}

// MARK: - PrivacyTypesEnumValidation

public enum PrivacyTypesEnumValidation {
    case terms(Bool)
    case newsletter(Bool)
    case marketing(Bool)
    case marketingThirdParty(Bool)
    case profiling(Bool)
    case profilingThirdParty(Bool)
}
