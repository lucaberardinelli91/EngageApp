//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

class AuthRepository: AuthRepositoryProtocol {
    private var localStorageWorker: UserProtocol
    private var networkWorker: NetworkingDataSourceProtocol

    private var cancellables = Set<AnyCancellable>()

    init(localStorageWorker: UserProtocol, networkWorker: NetworkingDataSourceProtocol) {
        self.localStorageWorker = localStorageWorker
        self.networkWorker = networkWorker
    }

    func checkEmail(email: String) -> AnyPublisher<CheckEmail, CustomError> {
        return networkWorker.checkEmail(email: email)
    }

    /// Check if otp is valid
    func checkLoginByOtp(otp: String) -> AnyPublisher<LoginByOtp, CustomError> {
        return networkWorker.checkLoginByOtp(otp: otp)
    }

    /// Save access token
    func saveAccessToken(token: LoginByOtpToken) -> AnyPublisher<Bool, CustomError> {
        return Future { promise in
            self.localStorageWorker.saveAccessToken(token: token)
            promise(.success(true))
        }.eraseToAnyPublisher()
    }

    /// Get access token
    func getAccessToken() -> AnyPublisher<TokenKeyChain, CustomError> {
        return Future { promise in
            guard let accessToken = self.localStorageWorker.getAccessToken() else {
                promise(.failure(CustomError.genericError("Access token not found")))
                return
            }
            promise(.success(accessToken))
        }.eraseToAnyPublisher()
    }
}
