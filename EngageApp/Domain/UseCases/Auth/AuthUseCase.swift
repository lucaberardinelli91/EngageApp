//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

// MARK: - CheckEmailProtocol

public protocol CheckEmailProtocol {
    func execute(email: String) -> AnyPublisher<CheckEmail, CustomError>
}

public protocol CheckLoginByOtpProtocol {
    func execute(otp: String) -> AnyPublisher<LoginByOtp, CustomError>
}

public protocol SaveAccessTokenProtocol {
    func execute(token: LoginByOtpToken) -> AnyPublisher<Bool, CustomError>
}

public protocol GetAccessTokenProtocol {
    func execute() -> AnyPublisher<TokenKeyChain, CustomError>
}

// MARK: - AuthUseCase

enum AuthUseCase {
    /// Check if the email is already registered
    class CheckEmailRegistration: CheckEmailProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var authRepository: AuthRepositoryProtocol

        public init(authRepository: AuthRepositoryProtocol) {
            self.authRepository = authRepository
        }

        public func execute(email: String) -> AnyPublisher<CheckEmail, CustomError> {
            authRepository.checkEmail(email: email)
        }
    }

    /// Login by OTP
    class CheckLoginByOtp: CheckLoginByOtpProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var authRepository: AuthRepositoryProtocol

        public init(authRepository: AuthRepositoryProtocol) {
            self.authRepository = authRepository
        }

        public func execute(otp: String) -> AnyPublisher<LoginByOtp, CustomError> {
            authRepository.checkLoginByOtp(otp: otp)
        }
    }

    /// Save access token
    class SaveAccessTokenKeychain: SaveAccessTokenProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var authRepository: AuthRepositoryProtocol

        public init(authRepository: AuthRepositoryProtocol) {
            self.authRepository = authRepository
        }

        public func execute(token: LoginByOtpToken) -> AnyPublisher<Bool, CustomError> {
            authRepository.saveAccessToken(token: token)
        }
    }

    /// Get access token
    class GetAccessTokenKeychain: GetAccessTokenProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var authRepository: AuthRepositoryProtocol

        public init(authRepository: AuthRepositoryProtocol) {
            self.authRepository = authRepository
        }

        public func execute() -> AnyPublisher<TokenKeyChain, CustomError> {
            authRepository.getAccessToken()
        }
    }
}
