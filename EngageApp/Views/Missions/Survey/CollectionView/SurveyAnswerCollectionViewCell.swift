//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

class SurveyAnswerCollectionViewCell: UICollectionViewCell, SurveyCollectionViewProtocol {
    var questionImg: String = ""

    var viewModel: SurveyCollectionViewViewModel?

    private var cancellables = Set<AnyCancellable>()

    var continueBtn: UIButton = {
        var button = UIButton(frame: .zero)
        ButtonStyle.primaryButton.apply(to: button)
        button.addTarget(self, action: #selector(continueDidTap), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.75
//        button.isHidden = true

        return button
    }()

    private var questionContainerView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = .white

        return view
    }()

    private var questionTitleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.numberOfLines = 0
        LabelStyle.surveyAnswerTitleLabel.apply(to: label)

        return label
    }()

    private var questionSubtitleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.surveyAnswerSubtitleLabel.apply(to: label)

        return label
    }()

    var msgTextView: UITextView = {
        let textView = UITextView()
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.textAlignment = NSTextAlignment.justified
        textView.backgroundColor = AppAsset.grayLighter.color
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 10
        textView.font = ThemeManager.currentTheme().primaryFont.font(size: 16)
        textView.textColor = .lightGray
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        textView.text = L10n.surveyPlaceholder
        return textView
    }()

    var answerScrollView: UIScrollView = {
        var scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false

        return scrollView
    }()

    var answerStkView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.clipsToBounds = false

        return stackView
    }()

    private func configureUI(configurator: (title: String, subtitle: String, imageURL: String?, type: SurveyAnswerType)) {
        backgroundColor = AppAsset.grayLighter.color

        addSubview(questionTitleLbl)
        questionTitleLbl.text = configurator.title
        questionSubtitleLbl.text = configurator.subtitle
        addSubview(questionSubtitleLbl)
        addSubview(questionContainerView)

        answerScrollView.addSubview(answerStkView)
        questionContainerView.addSubview(answerScrollView)
        viewModel?.updateAnswerState()

        if configurator.type == .text {
            answerScrollView.removeFromSuperview()
            addSubview(msgTextView)
            msgTextView.delegate = self
        }

        addSubview(continueBtn)
//        if configurator.type == .select {
//            continueBtn.isHidden = true
//            blockUI(blockUI: true, hide: true)
//        }
        continueBtn.isHidden = configurator.type == .select ? true : false
    }

    private func configureConstraints(configurator: (title: String, subtitle: String, imageURL: String?, type: SurveyAnswerType)) {
        questionTitleLbl.topAnchor /==/ topAnchor
        questionTitleLbl.leftAnchor /==/ leftAnchor + 20
        questionTitleLbl.rightAnchor /==/ rightAnchor - 20
        questionTitleLbl.heightAnchor /==/ 90

        questionSubtitleLbl.topAnchor /==/ questionTitleLbl.bottomAnchor + 10
        questionSubtitleLbl.leftAnchor /==/ leftAnchor + 20
        questionSubtitleLbl.heightAnchor /==/ 20

        questionContainerView.topAnchor /==/ questionSubtitleLbl.bottomAnchor + 20
        questionContainerView.leftAnchor /==/ leftAnchor
        questionContainerView.rightAnchor /==/ rightAnchor
        questionContainerView.bottomAnchor /==/ bottomAnchor + 3

        if subviews.contains(msgTextView) {
            msgTextView.topAnchor /==/ questionContainerView.topAnchor + 20
            msgTextView.leftAnchor /==/ questionContainerView.leftAnchor + 20
            msgTextView.rightAnchor /==/ questionContainerView.rightAnchor - 20
            msgTextView.heightAnchor /==/ 335
        }

        if questionContainerView.subviews.contains(answerScrollView) {
            answerScrollView.topAnchor /==/ questionContainerView.topAnchor + 20
            answerScrollView.leftAnchor /==/ questionContainerView.leftAnchor + 20
            answerScrollView.rightAnchor /==/ questionContainerView.rightAnchor - 20
            answerScrollView.bottomAnchor /==/ questionContainerView.bottomAnchor // - 110

            answerStkView.centerXAnchor /==/ answerScrollView.centerXAnchor
            answerStkView.topAnchor /==/ answerScrollView.topAnchor
            answerStkView.widthAnchor /==/ answerScrollView.widthAnchor
            answerStkView.bottomAnchor /==/ answerScrollView.bottomAnchor
        }

        continueBtn.heightAnchor /==/ 55
        continueBtn.leftAnchor /==/ leftAnchor + 63
        continueBtn.rightAnchor /==/ rightAnchor - 63

        switch UIDevice.current.getSize() {
        case .small:
            if configurator.imageURL != nil {
                continueBtn.bottomAnchor /==/ bottomAnchor - 250
            } else {
                continueBtn.bottomAnchor /==/ bottomAnchor - 45
            }
        case .medium:
            if configurator.imageURL != nil {
                continueBtn.bottomAnchor /==/ bottomAnchor - 130
            } else {
                continueBtn.bottomAnchor /==/ bottomAnchor - 45
            }
        case .large:
            if configurator.imageURL != nil {
                continueBtn.bottomAnchor /==/ bottomAnchor - 57
            } else {
                continueBtn.bottomAnchor /==/ bottomAnchor - 45
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        questionContainerView.clipsToBounds = true
        questionContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        questionContainerView.layer.cornerRadius = 10
    }

    @objc func continueDidTap() {
        viewModel?.continueButtonTap()
    }

    func configureViewModel(viewModel: SurveyCollectionViewViewModel) {
        self.viewModel = viewModel

        configureBinds()
        viewModel.getInfo()
    }

    private func configureBinds() {
        viewModel?.$surveyCollectionViewCellState
            .sink(receiveValue: { state in
                switch state {
                case let .success(configurator):
                    self.configureUI(configurator: configurator)
                    self.configureConstraints(configurator: configurator)
                default:
                    break
                }
            })
            .store(in: &cancellables)

        viewModel?.$updateContinueButtonState
            .sink(receiveValue: { state in
                switch state {
                case let .success(configurator):
                    self.updateButton(title: configurator)
                default:
                    break
                }
            })
            .store(in: &cancellables)
    }

    private func updateButton(title: String) {
        UIView.transition(with: continueBtn, duration: 0.4, options: .transitionCrossDissolve) {
            self.continueBtn.setTitle(title, for: .normal)
        }
    }

    override func prepareForReuse() {
        answerStkView.removeFullyAllArrangedSubviews()

        msgTextView.text = ""
        msgTextView.removeFromSuperview()
        answerScrollView.removeFromSuperview()
        answerStkView.removeFromSuperview()
    }
}

extension SurveyAnswerCollectionViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == L10n.surveyPlaceholder {
            textView.text.removeAll()
            textView.textColor = AppAsset.grayOpaque.color
            textView.tintColor = AppAsset.grayOpaque.color
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = UIColor.lightGray.color
            textView.tintColor = UIColor.lightGray.color
            textView.text = L10n.surveyPlaceholder
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        if textView.text != L10n.surveyPlaceholder, !textView.text.isEmpty {
            if textView.text.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "").isEmpty {
                blockUI(blockUI: true, hide: false)
            } else {
                blockUI(blockUI: false, hide: false)
            }
        } else {
            blockUI(blockUI: true, hide: false)
        }
    }
}

extension SurveyAnswerCollectionViewCell {
    func blockUI(blockUI: Bool, hide: Bool) {
        if blockUI {
            continueBtn.isEnabled = false
            if hide {
                UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: .curveEaseInOut) {
                    self.continueBtn.transform = .init(translationX: 0, y: 100)
                }
            } else {
                continueBtn.alpha = 0.75
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: .curveEaseInOut) {
                    self.continueBtn.transform = .identity
                }
            }
        } else {
            continueBtn.alpha = 1
            continueBtn.isEnabled = true
            continueBtn.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: .curveEaseInOut) {
                self.continueBtn.transform = .identity
            }
        }
    }
}
