//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Foundation

// MARK: - SplashAssemblerInjector

public protocol SplashAssemblerInjector {
    func resolve() -> SplashViewController

    func resolve() -> SplashViewModel
}

// MARK: - SplashAssembler

public class SplashAssembler: NSObject, SplashAssemblerInjector {
    var container: MainContainerProtocol

    public init(container: MainContainerProtocol) {
        self.container = container
    }
}

public extension SplashAssembler {
    func resolve() -> SplashViewController {
        return SplashViewController(viewModel: resolve())
    }

    func resolve() -> SplashViewModel {
        return SplashViewModel(getAccessTokenUseCase: container.getAccessToken)
    }
}
