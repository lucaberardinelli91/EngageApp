//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Foundation
import UIKit

class AnswerView: BaseView {
    var answerSelected: ((Answer) -> Void)?

    private var answer: Answer?
    var pointsCorrectAnswer: Int
    var pointsBonusAnswer: Int

    var state: AnswerState = .unselected {
        didSet {
            refreshUI()
        }
    }

    private lazy var answerLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.isUserInteractionEnabled = true
        label.textAlignment = .center
        label.numberOfLines = 3
        LabelStyle.quizGameAnswerLabel.apply(to: label)
        label.clipsToBounds = true

        return label
    }()

    private lazy var pointsContainerView: UIView = {
        var view = UIView(frame: .zero)
        view.alpha = 0
        view.clipsToBounds = true

        return view
    }()

    private lazy var pointsLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.backgroundColor = .white
        LabelStyle.quizGamePointsLabel.apply(to: label)

        return label
    }()

    init(answer: Answer?, pointsCorrectAnswer: Int, pointsBonusAnswer: Int) {
        self.answer = answer
        self.pointsCorrectAnswer = pointsCorrectAnswer
        self.pointsBonusAnswer = pointsBonusAnswer

        super.init(frame: CGRect.zero)
        configureUI()
        configureConstraints()

        let tap = UITapGestureRecognizer(target: self, action: #selector(answerDidTap))
        answerLbl.addGestureRecognizer(tap)
    }

    override func configureUI() {
        super.configureUI()

        clipsToBounds = false
        addSubview(answerLbl)
        answerLbl.text = answer?.text

        pointsContainerView.addSubview(pointsLbl)
        addSubview(pointsContainerView)

        state = .unselected
    }

    override func configureConstraints() {
        super.configureConstraints()

        answerLbl.edgeAnchors /==/ edgeAnchors

        pointsContainerView.topAnchor /==/ topAnchor - 10
        pointsContainerView.rightAnchor /==/ rightAnchor + 10
        pointsContainerView.heightAnchor /==/ 40
        pointsContainerView.widthAnchor /==/ 40

        pointsLbl.edgeAnchors /==/ pointsContainerView.edgeAnchors
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        pointsContainerView.transform = .init(rotationAngle: -35)
        pointsContainerView.layer.cornerRadius = 10

        pointsLbl.transform = .init(rotationAngle: 34.5)
    }

    fileprivate func setState(state: AnswerState) {
        self.state = state
    }

    private func refreshUI() {
        switch state {
        case .unselected:
            LabelStyle.quizGameAnswerLabel.apply(to: answerLbl)

            answerLbl.backgroundColor = .white
            answerLbl.layer.cornerRadius = 10
            answerLbl.layer.borderWidth = 2
            answerLbl.layer.borderColor = AppAsset.grayLight.color.cgColor

        case .selected:
            LabelStyle.quizGameSelectedAnswerLabel.apply(to: answerLbl)

            answerLbl.backgroundColor = UIColor.lightGray
            answerLbl.layer.borderColor = AppAsset.grayOpaque.color.cgColor

        case .correctAnswer:
            pointsLbl.text = "+\(pointsCorrectAnswer + pointsBonusAnswer)"
            LabelStyle.quizGameSelectedAnswerLabel.apply(to: answerLbl)

            answerLbl.backgroundColor = AppAsset.correctAnswer.color
            answerLbl.layer.borderColor = AppAsset.correctAnswerBorder.color.cgColor

            UIView.animate(withDuration: 0.5) {
                self.pointsContainerView.alpha = 1.0
                self.pointsContainerView.removeGradient()
                self.pointsLbl.backgroundColor = AppAsset.correctAnswerBorder.color
                self.pointsLbl.textColor = .white
            }

        case .wrongAnswer:
            pointsLbl.text = "+\(pointsBonusAnswer)"
            LabelStyle.quizGamePointsLabelAlternative.apply(to: pointsLbl)
            LabelStyle.quizGameSelectedAnswerLabel.apply(to: answerLbl)

            answerLbl.backgroundColor = AppAsset.brandDanger.color
            answerLbl.layer.borderColor = AppAsset.wrongAnswerBorder.color.cgColor

            pointsContainerView.layer.borderWidth = 1
            pointsContainerView.layer.borderColor = AppAsset.gray.color.cgColor

            if pointsBonusAnswer > 0 {
                UIView.animate(withDuration: 0.5) {
                    self.pointsContainerView.backgroundColor = .white
                    self.pointsContainerView.alpha = 1.0
                    self.pointsContainerView.removeGradient()
                }
            }
        }
    }

    @objc func answerDidTap() {
        tapAnimation {
            self.state = .selected

            guard let answer = self.answer, let isCorrect = answer.correct else { return }
            self.answerSelected?(answer)
            self.state = isCorrect ? .correctAnswer : .wrongAnswer
        }
    }
}

enum AnswerState {
    case unselected
    case selected
    case correctAnswer
    case wrongAnswer
}
