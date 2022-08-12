//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public class LauncherAssembler: LauncherAssemblerInjector {
    var container: MainContainerProtocol

    public init(container: MainContainerProtocol) {
        self.container = container
    }
}

public protocol LauncherAssemblerInjector {
    func resolve() -> LauncherViewController

    func resolve() -> LauncherViewModel
}

public extension LauncherAssembler {
    func resolve() -> LauncherViewController {
        return LauncherViewController(viewModel: resolve())
    }

    func resolve() -> LauncherViewModel {
        return LauncherViewModel(instantwinPlayUseCase: container.instantwinPlay, getSurveyQuestionsUseCase: container.getSurveyQuestions)
    }
}
