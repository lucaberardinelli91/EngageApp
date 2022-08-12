//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public class PlayGameQuizAssembler: PlayGameQuizAssemblerInjector {
    var container: MainContainerProtocol
    var mission: Mission

    public init(container: MainContainerProtocol, mission: Mission) {
        self.container = container
        self.mission = mission
    }
}

public protocol PlayGameQuizAssemblerInjector {
    func resolve() -> PlayGameQuizViewController

    func resolve() -> PlayGameQuizViewModel
}

public extension PlayGameQuizAssembler {
    func resolve() -> PlayGameQuizViewController {
        return PlayGameQuizViewController(viewModel: resolve())
    }

    func resolve() -> PlayGameQuizViewModel {
        return PlayGameQuizViewModel(getQuizDetailUseCase: container.getQuizDetail, nextQuestionUseCase: container.getNextQuestion, postAnswerUseCase: container.postAnswer, mission: mission)
    }
}
