//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine

protocol SurveyCollectionViewViewModelProtocol {
    func getInfo()

    func continueButtonTap()
    func updateContinueButton(isLastAnswer: Bool)

    func getSelectedAnswerID() -> [String]
    func setSelectedAnswerID(answerID: [String])
    func appendSelectedAnswer(answerID: String)
    func removeSelectedAnswer(answerID: String)
    func updateAnswerState()
    func getAnswer() -> AnswerToSend?
    func getSurveyResultsConfiguration()
}

class SurveyCollectionViewViewModel: BaseViewModel, SurveyCollectionViewViewModelProtocol {
    var continueButtonDidTap = PassthroughSubject<Void, Never>()

    private var selectedAnswerID: [String] = []
    private var surveyQuestion: SurveyQuestion
    private var cell: SurveyCollectionViewProtocol?
    private let questionsNumber: Int?

    @Published var surveyCollectionViewCellState: LoadingState<(
        title: String,
        subtitle: String,
        imageURL: String?,
        type: SurveyAnswerType
    ), CustomError> = .idle

    @Published var updateContinueButtonState: LoadingState<String, CustomError> = .idle

    @Published var surveyAnswersState: LoadingState<(
        answers: [SurveyAnswer],
        text: String?,
        isDrawn: Bool
    ), CustomError> = .idle

    init(configurator: SurveyQuestion, cell: SurveyCollectionViewProtocol?, questionsNumber: Int?) {
        surveyQuestion = configurator
        self.cell = cell
        self.questionsNumber = questionsNumber
    }

    func getInfo() {
        let title = surveyQuestion.text ?? ""
        var subtitle = String()
        let imageURL = surveyQuestion.image

        guard let questionType = surveyQuestion.type else { return }
        let type = SurveyAnswerType(questionType)

        switch type {
        case .select:
            subtitle = L10n.surveyAnswerSubtitleSingle

        case .multiSelect:
            subtitle = L10n.surveyAnswerSubtitleMultiple

        case .text:
            subtitle = L10n.surveyAnswerSubtitleFreeText

        default:
            break
        }

        surveyCollectionViewCellState = .success((title: title, subtitle: subtitle, imageURL: imageURL, type: type))
    }

    func continueButtonTap() {
        continueButtonDidTap.send()
    }

    func getSelectedAnswerID() -> [String] {
        return selectedAnswerID
    }

    func setSelectedAnswerID(answerID: [String]) {
        selectedAnswerID = answerID
    }

    func appendSelectedAnswer(answerID: String) {
        if !selectedAnswerID.contains(answerID) {
            selectedAnswerID.append(answerID)
        }
    }

    func removeSelectedAnswer(answerID: String) {
        if selectedAnswerID.contains(answerID) {
            selectedAnswerID.removeAll { _answerID in
                _answerID == answerID
            }
        }
    }

    func getAnswer() -> AnswerToSend? {
        /// It's a `Open` answer
        if let type = surveyQuestion.type, let id = surveyQuestion.id {
            if SurveyAnswerType(type) == .text {
                return AnswerToSend(type: SurveyAnswerType(type), questionId: id, answerIDs: nil, answerText: cell?.msgTextView.text)
            } else {
                /// We are in the `else`. It's a `Single` or `Multiple` answer
                var _selectedAnswerIDs: [String] = []
                cell?.answerStkView.arrangedSubviews.forEach { view in
                    if let answerView = (view as? SurveyAnswerView), let id = answerView.answerID(), answerView.isAnswerSelected() {
                        _selectedAnswerIDs.append(id)
                    }
                }
                return AnswerToSend(type: SurveyAnswerType(type), questionId: id, answerIDs: _selectedAnswerIDs, answerText: nil)
            }
        }
        return nil
    }

    func updateAnswerState() {
        let surveyAnswers = surveyQuestion.answers
        for answer in surveyAnswers {
            if let type = surveyQuestion.type, let answerID = answer.id {
                let surveyAnswerView = SurveyAnswerView(surveyAnswer: answer, type: SurveyAnswerType(type), isPreviouslySelected: getSelectedAnswerID().contains(answerID))

                if surveyAnswerView.isPreviouslySelected { cell?.blockUI(blockUI: false, hide: false) }

                surveyAnswerView.selectedItem
                    .sink { answerID in
                        self.appendSelectedAnswer(answerID: answerID)
                        self.cell?.blockUI(blockUI: false, hide: false)
                        if SurveyAnswerType(type) == .select {
                            self.cell?.answerStkView.arrangedSubviews.forEach { view in
                                if let _view = (view as? SurveyAnswerView) {
                                    if _view.surveyAnswer.id != answerID {
                                        _view.setState(state: .unselected)
                                    }
                                }
                            }

                            self.continueButtonTap()
                        }
                    }
                    .store(in: &cancellables)

                surveyAnswerView.unselectedItem
                    .sink { answerID in
                        self.removeSelectedAnswer(answerID: answerID)

                        var _selectedAnswerIDs: [String] = []
                        self.cell?.answerStkView.arrangedSubviews.forEach { view in
                            if let answerView = (view as? SurveyAnswerView), let id = answerView.answerID(), answerView.isAnswerSelected() {
                                _selectedAnswerIDs.append(String(id))
                            }
                        }
                        if _selectedAnswerIDs.isEmpty { self.cell?.blockUI(blockUI: true, hide: false) }
                    }
                    .store(in: &cancellables)

                cell?.answerStkView.addArrangedSubview(surveyAnswerView)
                surveyAnswerView.heightAnchor /==/ 85
            }
        }
    }

    func updateContinueButton(isLastAnswer: Bool) {
        var title = String()
        if isLastAnswer {
            if let number = questionsNumber {
                number == 1 ? (title = L10n.surveySendAnswer.uppercased()) : (title = L10n.surveySendAnswers.uppercased())
            } else {
                title = L10n.surveySendAnswers.uppercased()
            }
        } else {
            title = L10n.goOn.uppercased()
        }

        updateContinueButtonState = .success(title)
    }

    func getSurveyResultsConfiguration() {
        guard var answers = surveyQuestion.getSortedAnswers() else { return }
        answers = answers.sorted { _answer0, _answer1 in
            (_answer0.percentage) > (_answer1.percentage)
        }

        surveyAnswersState = .success((answers: answers, text: surveyQuestion.text, isDrawn: surveyQuestion.isAnswersDrawn()))
    }
}
