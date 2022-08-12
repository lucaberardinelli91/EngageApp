//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public protocol SurveyAnswersViewControllerProtocol {
    func getSurveyQuestions()
    func sendSurvey()
}

public class SurveyAnswersViewController: BasePackedViewController<SurveyAnswersView, SurveyAnswersViewModel>, SurveyAnswersViewControllerProtocol {
    public weak var surveyAnswersCoordinator: SurveyCoordinatorProtocol?
    private var surveyAnswerDataProvider: SurveyDataProvider?
    private var questions: [SurveyQuestion] = []
    public var points: Int?

    override public func viewDidLoad() {
        super.viewDidLoad()
        configureBinds()
        setInteractions()
        setDataProvider()

        getSurveyQuestions()
    }

    public func getSurveyQuestions() {
        viewModel.getSurveyQuestions()
    }

    public func sendSurvey() {
        viewModel.sendSurvey()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }
}

extension SurveyAnswersViewController {
    private func configureBinds() {
        handle(viewModel.$getSurveyQuestionsState, success: { surveyQuestions in
            guard let surveyQuestions = surveyQuestions else { return }
            self.surveyAnswerDataProvider?.applySnapshot(entries: surveyQuestions)

            surveyQuestions.forEach { s in
                s.image != nil ? self._view.isSurveyWithImages = true : nil
            }

            self.questions = surveyQuestions
            self._view.questionImg = surveyQuestions[0].image

            surveyQuestions.count > 1 ? self._view.showProgressBar(true) : self._view.showProgressBar(false)
        })

        handle(viewModel.$sendSurveyState, success: { _ in
            self.surveyAnswersCoordinator?.routeToHome(feedback: (true, "\(self.points ?? 0)"))
        }, failure: { _ in
            self.surveyAnswersCoordinator?.routeToHome(feedback: (false, ""))
        }, throwBaseError: false)
    }

    private func setInteractions() {
        interaction(_view.closeButtonDidTap) { _ in
            self.dismiss(animated: true, completion: nil)
        }

        interaction(_view.backButtonDidTap) { _ in
            if let currentIndexPath = self._view.answersCollView.indexPathsForVisibleItems.first {
                let backIndexPath = IndexPath(item: currentIndexPath.item - 1, section: currentIndexPath.section)
                self._view.answersCollView.scrollToItem(at: backIndexPath, at: .centeredVertically, animated: true)

                if backIndexPath.item == 0 {
                    self._view.hideBackButton()
                }
            }
        }
    }

    private func setDataProvider() {
        let collectionView = _view.answersCollView
        collectionView.delegate = self
        surveyAnswerDataProvider = SurveyDataProvider(collectionView: collectionView)
        observeDataProvider(dataProvider: surveyAnswerDataProvider)
    }

    private func observeDataProvider(dataProvider _: SurveyDataProvider?) {
        surveyAnswerDataProvider?.continueButtonDidTap
            .sink(receiveValue: { _ in
                if let currentIndexPath = self._view.answersCollView.indexPathsForVisibleItems.first {
                    if currentIndexPath.item == (self.surveyAnswerDataProvider?.dataSource.snapshot().numberOfItems ?? 0) - 1 {
                        /// Final answer
                        self._view.setProgress(progress: 1.0)
                        self.buildAnswerToSend(indexPath: currentIndexPath)
                        self.sendSurvey()
                        return
                    }

                    let nextIndex = currentIndexPath.item + 1
                    let nextIndexPath = IndexPath(item: nextIndex, section: currentIndexPath.section)
                    self._view.answersCollView.scrollToItem(at: nextIndexPath, at: .centeredVertically, animated: true)

                    self._view.questionImg = self.questions[nextIndex].image

                    if nextIndexPath.item > 0 {
                        self._view.showBackButton()
                    }

                    self.buildAnswerToSend(indexPath: currentIndexPath)
                }
            })
            .store(in: &cancellables)
    }

    private func buildAnswerToSend(indexPath: IndexPath) {
        if let cell = _view.answersCollView.cellForItem(at: indexPath) as? SurveyCollectionViewProtocol {
            if let answers = cell.viewModel?.getAnswer() {
                viewModel.insertAnswerToSend(answerToSend: answers)
            }
        }
    }
}

extension SurveyAnswersViewController: UICollectionViewDelegate {
    public func collectionView(_: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let nextIndexPath = indexPath
        let questionsNumber = viewModel.getQuestionsNumber()
        let progress = Float(nextIndexPath.item) / Float(questionsNumber)

        _view.setProgress(progress: progress)

        if nextIndexPath.item == (surveyAnswerDataProvider?.dataSource.snapshot().numberOfItems ?? 0) - 1, cell is SurveyCollectionViewProtocol {
            (cell as? SurveyCollectionViewProtocol)?.viewModel?.updateContinueButton(isLastAnswer: true)
        } else {
            (cell as? SurveyCollectionViewProtocol)?.viewModel?.updateContinueButton(isLastAnswer: false)
        }
    }
}
