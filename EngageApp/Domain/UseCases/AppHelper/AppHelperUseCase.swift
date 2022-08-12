//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import Foundation

// MARK: - ShareProtocol

public protocol ShareProtocol {
    func execute(shareHelper: ShareHelperProtocol, title: String?, url: String?) -> AnyPublisher<Void, Never>
}

// MARK: - ValidateProtocol

public protocol ValidateProtocol {
    func execute(inputs: [ValidationRequest]) -> AnyPublisher<[ValidationRequest], CustomError>
}

// MARK: - AppHelperUseCase

enum AppHelperUseCase {
    /// Share with iOS bottom sheet
    public class Share: ShareProtocol {
        public func execute(shareHelper: ShareHelperProtocol, title _: String?, url _: String?) -> AnyPublisher<Void, Never> {
            shareHelper.share(title: "TODO", url: "https://www.google.it")
//            if let title = title, let url = url {
//                shareHelper.share(title: title, url: url)
//            }

            return Just(())
                .eraseToAnyPublisher()
        }
    }

    /// Validate the fields of signup
    public class Validation: ValidateProtocol {
        private var cancellables = Set<AnyCancellable>()

        private func isValidPassword(password: String) -> Bool {
            return password.count >= 8
        }

        private func isValidPhone(phone: String) -> Bool {
            return phone.count >= 6
        }

        private func isValidEmail(email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

            return emailPred.evaluate(with: email.trimmingCharacters(in: .whitespacesAndNewlines))
        }

        private func isValidImage(imageData: Data, placeholderData: Data) -> Bool {
            return imageData != placeholderData
        }

        public func execute(inputs: [ValidationRequest]) -> AnyPublisher<[ValidationRequest], CustomError> {
            return Future { promise in
                var inErrors: [ValidationRequest] = []

                for input in inputs {
                    switch input {
                    case let .password(password):
                        if !self.isValidPassword(password: password) {
                            inErrors.append(input)
                        }
                    case let .email(email):
                        if !self.isValidEmail(email: email) {
                            inErrors.append(input)
                        }
                    case let .picture(imageData, placeholderData):
                        if !self.isValidImage(imageData: imageData, placeholderData: placeholderData) {
                            inErrors.append(input)
                        }
                    case let .phone(phone):
                        if !self.isValidPhone(phone: phone) {
                            inErrors.append(input)
                        }
                    case let .notEmpty(type):
                        switch type {
                        case let .firstName(firstName):
                            if firstName.isEmpty {
                                inErrors.append(input)
                            }
                        case let .lastName(lastName):
                            if lastName.isEmpty {
                                inErrors.append(input)
                            }
                        case let .birthday(birthday):
                            if birthday.isEmpty {
                                inErrors.append(input)
                            }
                        case let .country(country):
                            if country.isEmpty {
                                inErrors.append(input)
                            }
                        case let .gender(gender):
                            if gender.isEmpty {
                                inErrors.append(input)
                            }
                        case let .prefix(prefix):
                            if prefix.isEmpty {
                                inErrors.append(input)
                            }
                        }
                    case let .privacy(type):
                        switch type {
                        case let .newsletter(isChecked):
                            if !isChecked {
                                inErrors.append(input)
                                break
                            }
                        case let .marketing(isChecked):
                            if !isChecked {
                                inErrors.append(input)
                                break
                            }
                        case let .marketingThirdParty(isChecked):
                            if !isChecked {
                                inErrors.append(input)
                                break
                            }
                        case let .profiling(isChecked):
                            if !isChecked {
                                inErrors.append(input)
                                break
                            }
                        case let .profilingThirdParty(isChecked):
                            if !isChecked {
                                inErrors.append(input)
                                break
                            }
                        case let .terms(isChecked):
                            if !isChecked {
                                inErrors.append(input)
                                break
                            }
                        }
                    }
                }

                promise(.success(inErrors))
            }.eraseToAnyPublisher()
        }
    }
}
