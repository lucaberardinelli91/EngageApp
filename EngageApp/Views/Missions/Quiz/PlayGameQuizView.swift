//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

enum QuizAnswer {
    case correct
    case wrong
    case current
    case clean
}

public class PlayGameQuizView: BaseView {
    var closeButtonTap = PassthroughSubject<Void, Never>()
    var answerSelected = PassthroughSubject<(Answer, Int, Quiz), Never>()
    var timerExpired = PassthroughSubject<Void, Never>()
    var timerPlayExpired = PassthroughSubject<Void, Never>()
    var questionTime = 0
    var questionTimer: Timer?
    var answerCorrect: Answer?
    var answerViewCorrect: AnswerView?

    var configurator: Quiz? {
        didSet {
            refreshUI()
            refreshConstraints()
        }
    }

    var quizState: QuizState = .idle {
        didSet {
            switch quizState {
            case .idle:
                setIdle()
            case .playing:
                setTimerToPlay()
            case let .answerSelected(answer):
                setAnswerSelected(answer: answer)
            case .timerToNextQuestion:
                setTimerToNextQuestion()
            }
        }
    }

    private var previousAnswersStkView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 10

        return stackView
    }()

    var coinsCurrentView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = AppAsset.YellowCoin.color.cgColor

        var gradientView = UIView(frame: .zero)
        gradientView.backgroundColor = ThemeManager.currentTheme().primaryColor.withAlphaComponent(0.6)

        var titleLbl = UILabel(frame: .zero)
        titleLbl.text = "Coin"
        LabelStyle.coinTitleLabel.apply(to: titleLbl)

        var valueLbl = UILabel(frame: .zero)
        valueLbl.text = "0"
        LabelStyle.coinValueLabel.apply(to: valueLbl)

        view.addSubview(gradientView)
        gradientView.edgeAnchors /==/ view.edgeAnchors

        view.addSubview(titleLbl)
        titleLbl.centerXAnchor /==/ view.centerXAnchor
        titleLbl.topAnchor /==/ view.topAnchor + 7

        view.addSubview(valueLbl)
        valueLbl.centerXAnchor /==/ view.centerXAnchor
        valueLbl.topAnchor /==/ titleLbl.bottomAnchor
        
        view.isHidden = true

        return view
    }()

    private lazy var backgroundImgView: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.image = AppAsset.quizBackground.image
        imageView.clipsToBounds = true

        var blackLayer = UIView(frame: .zero)
        blackLayer.backgroundColor = AppAsset.grayOpaque.color.withAlphaComponent(0.5)
        imageView.addSubview(blackLayer)

        blackLayer.edgeAnchors /==/ imageView.edgeAnchors

        return imageView
    }()

    private lazy var closeBtn: UIButton = {
        var button = UIButton(frame: .zero)

        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white

        return button
    }()

    private lazy var questionContainerView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = .white

        return view
    }()

    private var fakeQuestionContainer1View: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 223, green: 223, blue: 223)

        return view
    }()

    private var fakeQuestionContainer2View: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 176, green: 176, blue: 176)

        return view
    }()

    private(set) var timerView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.alpha = 0

        return view
    }()

    private(set) var timerLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .center
        LabelStyle.quizGameTimerLabel.apply(to: label)

        return label
    }()

    private(set) var questionLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 0
        LabelStyle.quizGameQuestionLabel.apply(to: label)

        return label
    }()

    private lazy var containerScrollView: UIScrollView = {
        var scrollView = UIScrollView(frame: .zero)
        scrollView.clipsToBounds = true

        return scrollView
    }()

    private(set) var answerStkView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        stackView.clipsToBounds = false

        return stackView
    }()

    private(set) var timerCircularProgress: CircularProgress = {
        var progressBar = CircularProgress(frame: .zero, colors: ThemeManager.currentTheme().tertiaryColor)
        progressBar.glowMode = .constant
        progressBar.glowAmount = 1.5
        progressBar.trackColor = .clear
        progressBar.startAngle = -90
        progressBar.trackThickness = 0.4
        progressBar.progressThickness = 0.4
        progressBar.alpha = 0

        return progressBar
    }()

    private lazy var footerLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 2
        LabelStyle.quizGameCloseMessageLabel.apply(to: label)
        label.text = L10n.quizCloseMsgFooter

        return label
    }()

    private lazy var shadowView: UIView = {
        var view = UIView(frame: .zero)

        return view
    }()

    var coinsCurrent: Int? { didSet { didSetCoinsCurrent() }}

    private func didSetCoinsCurrent() {
        guard let coinsCurrent = coinsCurrent else { return }
        (coinsCurrentView.subviews[2] as! UILabel).text = "\(coinsCurrent)"
    }

    override func configureUI() {
        super.configureUI()

        addSubview(backgroundImgView)

        addSubview(questionContainerView)
        questionContainerView.hero.id = Constants.HeroTransitionsID.quizTransition

        addSubview(timerView)
        timerView.addSubview(timerLbl)
        addSubview(timerCircularProgress)

        questionContainerView.addSubview(questionLbl)
        questionContainerView.addSubview(containerScrollView)
        containerScrollView.addSubview(answerStkView)

        insertSubview(shadowView, at: 1)
    }

    override func configureConstraints() {
        super.configureConstraints()

        backgroundImgView.edgeAnchors /==/ edgeAnchors

        questionContainerView.centerAnchors /==/ centerAnchors
        questionContainerView.widthAnchor /==/ widthAnchor * 0.92
        questionContainerView.heightAnchor /==/ heightAnchor * 0.67

        timerView.centerXAnchor /==/ centerXAnchor
        timerView.heightAnchor /==/ 85
        timerView.widthAnchor /==/ 85
        timerView.topAnchor /==/ questionContainerView.topAnchor - 42.5

        timerLbl.edgeAnchors /==/ timerView.edgeAnchors

        timerCircularProgress.centerAnchors /==/ timerView.centerAnchors
        timerCircularProgress.widthAnchor /==/ timerView.widthAnchor + 35
        timerCircularProgress.heightAnchor /==/ timerView.heightAnchor + 35

        questionLbl.topAnchor /==/ questionContainerView.topAnchor + 30
        questionLbl.leftAnchor /==/ questionContainerView.leftAnchor + 35
        questionLbl.rightAnchor /==/ questionContainerView.rightAnchor - 35
        questionLbl.heightAnchor /==/ 160

        containerScrollView.topAnchor /==/ questionLbl.bottomAnchor - 15
        containerScrollView.leftAnchor /==/ questionContainerView.leftAnchor
        containerScrollView.rightAnchor /==/ questionContainerView.rightAnchor
        containerScrollView.bottomAnchor /==/ questionContainerView.bottomAnchor - 50

        answerStkView.centerXAnchor /==/ containerScrollView.centerXAnchor
        answerStkView.topAnchor /==/ containerScrollView.topAnchor + 15
        answerStkView.widthAnchor /==/ containerScrollView.widthAnchor * 0.85
        answerStkView.bottomAnchor /==/ containerScrollView.bottomAnchor

        shadowView.topAnchor /==/ topAnchor
        shadowView.leftAnchor /==/ leftAnchor
        shadowView.rightAnchor /==/ rightAnchor
        shadowView.heightAnchor /==/ heightAnchor
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        questionContainerView.layer.cornerRadius = 10
        questionContainerView.addShadow(color: .black, opacity: 0.4, radius: 5, offset: .zero)

        fakeQuestionContainer1View.layer.cornerRadius = 10
        fakeQuestionContainer1View.addShadow(color: .black, opacity: 0.4, radius: 5, offset: .zero)

        fakeQuestionContainer2View.layer.cornerRadius = 10
        fakeQuestionContainer2View.addShadow(color: .black, opacity: 0.4, radius: 5, offset: .zero)

        timerView.layer.cornerRadius = timerView.bounds.width / 2
        timerView.addShadow(color: .black, opacity: 0.2, radius: 10, offset: .zero)

        coinsCurrentView.layer.cornerRadius = 8
    }

    private func refreshUI() {
        guard let configurator = configurator, let totalQuestions = configurator.slot?.totalQuestions
        else { return }
        setState(quizState: .idle)

        if totalQuestions > 1 {
            addSubview(coinsCurrentView)
            addSubview(previousAnswersStkView)
            insertSubview(fakeQuestionContainer1View, belowSubview: questionContainerView)
            insertSubview(fakeQuestionContainer2View, belowSubview: fakeQuestionContainer1View)
        }

        addSubview(footerLbl)

        addSubview(closeBtn)
        closeBtn.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)

        guard let question = configurator.question, let answers = question.answers else { return }

        questionLbl.text = question.text

        for answer in answers {
            let answerView = AnswerView(
                answer: answer,
                pointsCorrectAnswer: configurator.contest?.pointsCorrectAnswer ?? 0,
                pointsBonusAnswer: configurator.contest?.pointsAnswer ?? 0
            )
            answerView.answerSelected = { answer in
                self.setState(quizState: .answerSelected(answer: answer))
                self.answerViewCorrect?.state = .correctAnswer

                guard let isCorrect = answer.correct else { return }
                isCorrect ? self.setPreviousAnswers(.correct) : self.setPreviousAnswers(.wrong)
            }
            answerStkView.addArrangedSubview(answerView)

            answer.correct ?? false ? answerViewCorrect = answerView : nil

            answerView.heightAnchor /==/ 60
            layoutIfNeeded()
        }

        setState(quizState: .playing)
    }

    private func refreshConstraints() {
        guard let configurator = configurator, let totalQuestions = configurator.slot?.totalQuestions
        else { return }

        closeBtn.topAnchor /==/ topAnchor + 55
        closeBtn.leftAnchor /==/ leftAnchor + 15
        closeBtn.heightAnchor /==/ 25
        closeBtn.widthAnchor /==/ 25

        if totalQuestions > 1 {
            previousAnswersStkView.topAnchor /==/ topAnchor + 55
            previousAnswersStkView.centerXAnchor /==/ centerXAnchor
            previousAnswersStkView.heightAnchor == 20
            setPreviousAnswers(.clean)

            coinsCurrentView.topAnchor /==/ topAnchor + 45
            coinsCurrentView.rightAnchor /==/ rightAnchor - 24
            coinsCurrentView.widthAnchor /==/ 57
            coinsCurrentView.heightAnchor /==/ 57

            fakeQuestionContainer1View.leftAnchor /==/ questionContainerView.leftAnchor + 20
            fakeQuestionContainer1View.rightAnchor /==/ questionContainerView.rightAnchor - 20
            fakeQuestionContainer1View.bottomAnchor /==/ questionContainerView.bottomAnchor + 15
            fakeQuestionContainer1View.heightAnchor /==/ 100

            fakeQuestionContainer2View.leftAnchor /==/ fakeQuestionContainer1View.leftAnchor + 20
            fakeQuestionContainer2View.rightAnchor /==/ fakeQuestionContainer1View.rightAnchor - 20
            fakeQuestionContainer2View.bottomAnchor /==/ fakeQuestionContainer1View.bottomAnchor + 15
            fakeQuestionContainer2View.heightAnchor /==/ 100
        }

        if subviews.contains(footerLbl) {
            footerLbl.bottomAnchor /==/ bottomAnchor - 35
            footerLbl.leftAnchor /==/ leftAnchor + 80
            footerLbl.rightAnchor /==/ rightAnchor - 80
            footerLbl.centerXAnchor /==/ centerXAnchor
        }

        layoutIfNeeded()
    }

    private func setPreviousAnswers(_ result: QuizAnswer) {
        switch result {
        case .correct:
            previousAnswersStkView.arrangedSubviews.forEach { answer in
                (answer as! UIImageView).image == AppAsset.quizCurrent.image ? (answer as! UIImageView).image = AppAsset.quizCorrectOn.image : nil
            }
        case .wrong:
            previousAnswersStkView.arrangedSubviews.forEach { answer in
                (answer as! UIImageView).image == AppAsset.quizCurrent.image ? (answer as! UIImageView).image = AppAsset.quizWrongOn.image : nil
            }
        case .clean:
            if previousAnswersStkView.arrangedSubviews.isEmpty {
                // quiz not yet started -> set default
                guard let totalQuestions = configurator?.slot?.totalQuestions else { return }
                for i in 1 ... 2 { //totalQuestions {
                    let answer = UIImageView(frame: .zero)
                    answer.contentMode = .scaleAspectFill
                    answer.heightAnchor /==/ 17
                    answer.widthAnchor /==/ 17
                    answer.image = i == 1 ? AppAsset.quizCurrent.image : AppAsset.quizNext.image
                    previousAnswersStkView.addArrangedSubview(answer)
                }
            } else {
                // next question -> update current question + update old answers to off
                for i in 0 ... previousAnswersStkView.arrangedSubviews.count - 1 {
                    let current = previousAnswersStkView.arrangedSubviews[i]
                    if (current as! UIImageView).image == AppAsset.quizNext.image {
                        (current as! UIImageView).image = AppAsset.quizCurrent.image
                        let next = previousAnswersStkView.arrangedSubviews[i - 1]
                        if (next as! UIImageView).image == AppAsset.quizCorrectOn.image {
                            (next as! UIImageView).image = AppAsset.quizCorrectOff.image
                        } else {
                            (next as! UIImageView).image = AppAsset.quizWrongOff.image
                        }
                        break
                    }
                }
            }
        default:
            break
        }
    }

    func setConfigurator(configurator: Quiz) {
        self.configurator = configurator
    }

    @objc private func closeButtonDidTap() {
        closeBtn.tapAnimation {
            self.closeButtonTap.send()
        }
    }

    func setState(quizState: QuizState) {
        self.quizState = quizState
    }
}
