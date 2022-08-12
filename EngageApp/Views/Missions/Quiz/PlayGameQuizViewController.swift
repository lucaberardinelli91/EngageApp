//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public protocol PlayGameQuizViewControllerProtocol {
    func getNextQuestion()
    func postAnswer(answerSelected: Answer, time: Int, instantWinPlay: Quiz)
}

public class PlayGameQuizViewController: BasePackedViewController<PlayGameQuizView, PlayGameQuizViewModel>, PlayGameQuizViewControllerProtocol {
    public weak var playGameQuizCoordinator: QuizCoordinatorProtocol?
    var countAnswers: Int = 0

    override public init(viewModel: PlayGameQuizViewModel) {
        super.init(viewModel: viewModel)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        configureBinds()
        setInteractions()

        getQuizDetail()
        getNextQuestion()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    public func getNextQuestion() {
        viewModel.getNextQuestion()
    }

    public func getQuizDetail() {
        viewModel.getQuizDetail()
    }

    public func postAnswer(answerSelected: Answer, time: Int, instantWinPlay _: Quiz) {
        guard let answerId = answerSelected.id else { return }
        viewModel.postAnswer(answerId: answerId, timeMilliseconds: time)
    }
}

extension PlayGameQuizViewController {
    private func configureBinds() {
        handle(viewModel.$nextQuestionState, success: { instantWinPlay in
            guard let instantWinPlay = instantWinPlay else { return }
            self.checkToPlay(instantWinPlay: instantWinPlay)
        })

        handle(viewModel.$postAnswerState, success: { [self] _ in
            if self.countAnswers == self.viewModel.totalQuestions {
                if viewModel.isAllAnswersCorrect {
                    viewModel.totalPointsWin = viewModel.pointsMax
                    _view.coinsCurrent = viewModel.pointsMax
                } else {
                    _view.coinsCurrent = viewModel.totalPointsWin
                }
                self.playGameQuizCoordinator?.routeToHome(feedback: (true, "\(viewModel.totalPointsWin)"))
            } else {
                _view.coinsCurrent = viewModel.totalPointsWin
                DispatchQueue.main.async {
                    if self.viewIfLoaded?.window != nil {
                        self._view.setState(quizState: .timerToNextQuestion)
                    }
                }
            }
        }, failure: { error in
            self.handleTimeoutError(error: error)
        })
    }

    private func setInteractions() {
        interaction(_view.closeButtonTap) { _ in
            self.dismiss(animated: true, completion: nil)
        }

        interaction(_view.answerSelected) { answer, timeToSend, instantWinPlay in
            self.countAnswers += 1
            self.postAnswer(answerSelected: answer, time: timeToSend, instantWinPlay: instantWinPlay)
        }

        interaction(_view.timerPlayExpired) { [self] _ in
            viewModel.isAllAnswersCorrect = false
            countAnswers += 1

            if countAnswers == viewModel.totalQuestions {
                viewModel.isAllAnswersCorrect ? viewModel.totalPointsWin += viewModel.pointsAllAnswersCorrect : nil
                playGameQuizCoordinator?.routeToHome(feedback: (true, "\(viewModel.totalPointsWin)"))
            } else {
                getNextQuestion()
            }
        }

        interaction(_view.timerExpired) { [self] _ in
            if countAnswers == viewModel.totalQuestions {
                viewModel.isAllAnswersCorrect ? viewModel.totalPointsWin += viewModel.pointsAllAnswersCorrect : nil
                playGameQuizCoordinator?.routeToHome(feedback: (true, "\(viewModel.totalPointsWin)"))
            } else {
                getNextQuestion()
            }
        }
    }

    private func checkToPlay(instantWinPlay: Quiz) {
        if instantWinPlay.contest?.userCanPlay ?? false {
            _view.setConfigurator(configurator: instantWinPlay)
        } else {
            viewModel.isAllAnswersCorrect ? viewModel.totalPointsWin = viewModel.pointsMax : nil
            playGameQuizCoordinator?.routeToHome(feedback: (true, "\(viewModel.totalPointsWin)"))
        }
    }

    private func handleTimeoutError(error: CustomError?) {
        if case .quizTimeout = error {
            if self.viewIfLoaded?.window != nil {
                self.getNextQuestion()
            }
        }
    }
}
