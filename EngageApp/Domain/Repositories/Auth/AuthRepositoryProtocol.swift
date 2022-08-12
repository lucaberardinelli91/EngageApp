//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

public protocol AuthRepositoryProtocol {
    func checkEmail(email: String) -> AnyPublisher<CheckEmail, CustomError>
    func checkLoginByOtp(otp: String) -> AnyPublisher<LoginByOtp, CustomError>
    func saveAccessToken(token: LoginByOtpToken) -> AnyPublisher<Bool, CustomError>
    func getAccessToken() -> AnyPublisher<TokenKeyChain, CustomError>
}
