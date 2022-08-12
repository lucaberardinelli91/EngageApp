//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import UIKit

public protocol LauncherViewModelProtocol {
    func instantwinPlay(instantwinRandomId: String)
    func getSurveyQuestions(surveyId: String)
}

public class LauncherViewModel: BaseViewModel, LauncherViewModelProtocol {
    @Published var instantwinPlayState: LoadingState<InstantWin, CustomError> = .idle
    @Published var getSurveyQuestionsState: LoadingState<[SurveyQuestion]?, CustomError> = .idle

    private let instantwinPlayUseCase: InstantwinPlayProtocol
    private var getSurveyQuestionsUseCase: GetSurveyQuestionsProtocol

    public init(instantwinPlayUseCase: InstantwinPlayProtocol, getSurveyQuestionsUseCase: GetSurveyQuestionsProtocol) {
        self.instantwinPlayUseCase = instantwinPlayUseCase
        self.getSurveyQuestionsUseCase = getSurveyQuestionsUseCase
    }

    public func instantwinPlay(instantwinRandomId: String) {
        // MOCK API
        instantwinPlayState = .success(InstantWin())
//        instantwinPlayState = .loading
//
//        instantwinPlayUseCase.execute(instantwinRandomId: instantwinRandomId)
//            .receive(on: RunLoop.main)
//            .sink { completion in
//                guard case let .failure(error) = completion else { return }
//                self.instantwinPlayState = .failure(error)
//            } receiveValue: { [self] result in
//                instantwinPlayState = .success(result)
//            }.store(in: &cancellables)
    }

    public func getSurveyQuestions(surveyId: String) {
        getSurveyQuestionsState = .loading

        getSurveyQuestionsUseCase.execute(surveyId: surveyId)
            .receive(on: RunLoop.main)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.getSurveyQuestionsState = .failure(error)
            } receiveValue: { [self] questions in
                guard let questions = questions else { return }
                getSurveyQuestionsState = .success(questions)
            }.store(in: &cancellables)
    }
}
