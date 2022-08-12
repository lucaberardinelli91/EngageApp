//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public enum ValidableHelper {
    public static func validableToValidation(validable: [Validable]) -> [ValidationRequest] {
        var requests: [ValidationRequest] = []
        for validation in validable {
            for input in validation.validations {
                switch input {
                case .email:
                    if let textField = validation.viewToObserve as? UITextField, let text = textField.text {
                        requests.append(.email(text))
                    }
                case .password:
                    if let textField = validation.viewToObserve as? UITextField, let text = textField.text {
                        requests.append(.password(text))
                    }
                case .phone:
                    if let textField = validation.viewToObserve as? UITextField, let text = textField.text {
                        requests.append(.phone(text))
                    }
                case .picture:
                    if let imageView = validation.viewToObserve as? UIImageView, let image = imageView.image, let imageData = image.pngData(), let placeholderData = AppAsset.imgSplashTeamLogo.image.pngData() {
                        requests.append(.picture(image: imageData, placeholder: placeholderData))
                    }
                case let .notEmpty(type: type):
                    switch type {
                    case .firstName:
                        if let textField = validation.viewToObserve as? UITextField, let text = textField.text {
                            requests.append(.notEmpty(.firstName(text)))
                        }
                    case .lastName:
                        if let textField = validation.viewToObserve as? UITextField, let text = textField.text {
                            requests.append(.notEmpty(.lastName(text)))
                        }
                    case .gender:
                        if let textField = validation.viewToObserve as? UITextField, let text = textField.text {
                            requests.append(.notEmpty(.gender(text)))
                        }
                    case .birthday:
                        if let textField = validation.viewToObserve as? UITextField, let text = textField.text {
                            requests.append(.notEmpty(.birthday(text)))
                        }
                    case .country:
                        if let textField = validation.viewToObserve as? UITextField, let text = textField.text {
                            requests.append(.notEmpty(.country(text)))
                        }
                    case .prefix:
                        if let textField = validation.viewToObserve as? UITextField, let text = textField.text {
                            requests.append(.notEmpty(.prefix(text)))
                        }
                    }
                default:
                    break
                }
            }
        }

        return requests
    }

    public static func validationToValidable(validations: [ValidationRequest], inputContainer: [Validable]) -> [Validable] {
        var inErrors: [Validable] = []
        for validation in validations {
            switch validation {
            case .password:
                if
                    let password = inputContainer.first(where: { validable in
                        validable.validations.contains { type in
                            type == .password
                        }
                    })
                {
                    inErrors.append(password)
                }
            case .email:
                if
                    let email = inputContainer.first(where: { validable in
                        validable.validations.contains { type in
                            type == .email
                        }
                    })
                {
                    inErrors.append(email)
                }
            case .picture:
                if
                    let picture = inputContainer.first(where: { validable in
                        validable.validations.contains { type in
                            type == .picture
                        }
                    })
                {
                    inErrors.append(picture)
                }
            case .phone:
                if
                    let phone = inputContainer.first(where: { validable in
                        validable.validations.contains { type in
                            type == .phone
                        }
                    })
                {
                    inErrors.append(phone)
                }
            case let .notEmpty(inputTypesEnumValidation):
                if
                    let notEmpty = inputContainer.first(where: { validable in
                        validable.validations.contains { type in
                            type == .notEmpty(type: .init(inputTypesEnumValidation: inputTypesEnumValidation))
                        }
                    })
                {
                    inErrors.append(notEmpty)
                }
            case let .privacy(privacyTypesEnumValidation):
                if
                    let privacy = inputContainer.first(where: { validable in
                        validable.validations.contains { type in
                            type == .privacy(type: .init(privacyTypesEnumValidation: privacyTypesEnumValidation))
                        }
                    })
                {
                    inErrors.append(privacy)
                }
            }
        }

        return inErrors
    }
}
