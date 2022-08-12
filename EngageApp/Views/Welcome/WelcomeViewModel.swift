//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Combine
import UIKit

public protocol WelcomeViewModelProtocol {
    func checkEmail()
    func validate()
    func checkLoginByOtp(otp: String)
    func saveAccessToken(token: LoginByOtpToken)
    func bindView(view: WelcomeView?)
}

public class WelcomeViewModel: BaseViewModel, WelcomeViewModelProtocol {
    @Published var checkEmailState: LoadingState<String, CustomError> = .idle
    @Published var checkLoginByOtpState: LoadingState<LoginByOtpToken, CustomError> = .idle
    @Published var saveAccesTokenState: LoadingState<Bool, CustomError> = .idle
    @Published var validateState: LoadingState<[Validable], CustomError> = .idle
    private var inputsValidableContainer: [Validable] = []
    private let checkEmailUseCase: CheckEmailProtocol
    private let checkLoginByOtpUseCase: CheckLoginByOtpProtocol
    private let saveAccessTokenUseCase: SaveAccessTokenProtocol
    private let validateUseCase: ValidateProtocol
    var view: WelcomeView?
    var email: String!

    public init(checkEmailUseCase: CheckEmailProtocol, checkLoginByOtpUseCase: CheckLoginByOtpProtocol, saveAccessTokenUseCase: SaveAccessTokenProtocol, validateUseCase: ValidateProtocol) {
        self.checkEmailUseCase = checkEmailUseCase
        self.checkLoginByOtpUseCase = checkLoginByOtpUseCase
        self.saveAccessTokenUseCase = saveAccessTokenUseCase
        self.validateUseCase = validateUseCase
    }

    public func checkEmail() {
        checkEmailState = .loading

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
            var inErrors: [ValidationRequest] = ValidableHelper.validableToValidation(validable: inputsValidableContainer)
            self.validateState = .success(ValidableHelper.validationToValidable(validations: inErrors, inputContainer: self.inputsValidableContainer))
        }

        checkEmailUseCase.execute(email: email ?? "")
            .receive(on: RunLoop.main)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.checkEmailState = .failure(error)
            } receiveValue: { [self] checkEmailModel in
                checkEmailState = .success(checkEmailModel.otp)
            }.store(in: &cancellables)
    }

    public func validate() {
        validateUseCase.execute(inputs: ValidableHelper.validableToValidation(validable: inputsValidableContainer))
            .receive(on: RunLoop.main)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.validateState = .failure(error)
            } receiveValue: { inErrors in
                self.validateState = .success(ValidableHelper.validationToValidable(validations: inErrors, inputContainer: self.inputsValidableContainer))
            }
            .store(in: &cancellables)
    }

    /// Check login by otp
    public func checkLoginByOtp(otp: String) {
        checkLoginByOtpState = .loading

        checkLoginByOtpUseCase.execute(otp: otp)
            .receive(on: RunLoop.main)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.checkLoginByOtpState = .failure(error)
            } receiveValue: { [self] checkEmailModel in
                checkLoginByOtpState = .success(checkEmailModel.token)
            }.store(in: &cancellables)
    }

    /// Save access token in KeyChain
    public func saveAccessToken(token: LoginByOtpToken) {
        saveAccesTokenState = .loading

        saveAccessTokenUseCase.execute(token: token)
            .receive(on: RunLoop.main)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.saveAccesTokenState = .failure(error)
            } receiveValue: { _ in
                self.saveAccesTokenState = .success(true)
            }.store(in: &cancellables)
    }

    /// Bind a `WelcomeView` to this view model
    public func bindView(view: WelcomeView?) {
        self.view = view
        if let emailTextField = view?.emailTextField {
            inputsValidableContainer.append(emailTextField)
        }
    }
}
