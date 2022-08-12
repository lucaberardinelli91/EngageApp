//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Combine
import UIKit

public enum RouteBySplash {
    case onBoarding
    case welcome
    case home
}

public protocol SplashViewModelProtocol {
    func getAccessToken()
}

public class SplashViewModel: BaseViewModel, SplashViewModelProtocol, ObservableObject {
    @Published var getAccesTokenState: LoadingState<TokenKeyChain, CustomError> = .idle
    private let getAccessTokenUseCase: GetAccessTokenProtocol

    public init(getAccessTokenUseCase: GetAccessTokenProtocol) {
        self.getAccessTokenUseCase = getAccessTokenUseCase
    }

    public func getAccessToken() {
        // MOCK API
        self.getAccesTokenState = .success(TokenKeyChain(accessToken: "", expiresIn: ""))
//        getAccesTokenState = .loading
//
//        getAccessTokenUseCase.execute()
//            .receive(on: RunLoop.main)
//            .sink { completion in
//                guard case let .failure(error) = completion else { return }
//                self.getAccesTokenState = .failure(error)
//            } receiveValue: { token in
//                self.getAccesTokenState = .success(token)
//            }.store(in: &cancellables)
    }
}
