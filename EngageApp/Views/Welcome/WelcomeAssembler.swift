//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Foundation

public class WelcomeAssembler: WelcomeAssemblerInjector {
    var container: MainContainerProtocol

    public init(container: MainContainerProtocol) {
        self.container = container
    }
}

public protocol WelcomeAssemblerInjector {
    func resolve() -> WelcomeViewController

    func resolve() -> WelcomeViewModel
}

public extension WelcomeAssembler {
    func resolve() -> WelcomeViewController {
        return WelcomeViewController(viewModel: resolve())
    }

    func resolve() -> WelcomeViewModel {
        return WelcomeViewModel(checkEmailUseCase: container.checkEmail, checkLoginByOtpUseCase: container.checkLoginByOtp, saveAccessTokenUseCase: container.saveAccessToken, validateUseCase: container.validation)
    }
}
