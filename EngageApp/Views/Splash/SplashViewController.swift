//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Combine
import Foundation

public protocol SplashViewControllerProtocol {
    func routeToNextStep(route: RouteBySplash)
}

public class SplashViewController: BasePackedViewController<SplashView, SplashViewModel>, SplashViewControllerProtocol {
    public weak var mainCoordinator: MainCoordinatorProtocol?

    override public init(viewModel: SplashViewModel) {
        super.init(viewModel: viewModel)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        configureBinds()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.viewModel.getAccessToken()
        }
    }

    public func routeToNextStep(route: RouteBySplash) {
        mainCoordinator?.processRoute(route: route)
    }
}

extension SplashViewController {
    private func configureBinds() {
        handle(viewModel.$getAccesTokenState, success: { [self] token in
            guard let expiresInDate = Date(detectFromString: token.expiresIn) else {
                token.accessToken == "_" ? mainCoordinator?.routeToWelcome(withFade: true) : mainCoordinator?.routeToOnboarding()
                return
            }
            expiresInDate > Date() ? mainCoordinator?.routeToHome() : mainCoordinator?.routeToWelcome(withFade: true)
        }) { [self] _ in
            mainCoordinator?.routeToOnboarding()
        }
    }
}
