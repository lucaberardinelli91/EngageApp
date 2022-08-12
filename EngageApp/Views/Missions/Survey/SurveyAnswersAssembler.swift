//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public class SurveyAnswersAssembler: SurveyAnswersAssemblerInjector {
    var container: MainContainerProtocol
    var surveyID: String

    public init(container: MainContainerProtocol, surveyID: String) {
        self.container = container
        self.surveyID = surveyID
    }
}

public protocol SurveyAnswersAssemblerInjector {
    func resolve() -> SurveyAnswersViewController

    func resolve() -> SurveyAnswersViewModel
}

public extension SurveyAnswersAssembler {
    func resolve() -> SurveyAnswersViewController {
        return SurveyAnswersViewController(viewModel: resolve())
    }

    func resolve() -> SurveyAnswersViewModel {
        return SurveyAnswersViewModel(surveyID: surveyID, getSurveyQuestionsUseCase: container.getSurveyQuestions, sendSurveyQuestionsUseCase: container.sendSurveyQuestions)
    }
}
