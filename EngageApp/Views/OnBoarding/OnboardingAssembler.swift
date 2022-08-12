//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Foundation

public class OnboardingAssembler: OnboardingAssemblerInjector {
    public var container: MainContainerProtocol

    public init(container: MainContainerProtocol) {
        self.container = container
    }
}

protocol OnboardingAssemblerInjector {
    func resolve() -> OnboardingViewController

    func resolve() -> OnboardingViewModel
}

public extension OnboardingAssembler {
    func resolve() -> OnboardingViewController {
        return OnboardingViewController(viewModel: resolve())
    }

    func resolve() -> OnboardingViewModel {
        return OnboardingViewModel()
    }
}
