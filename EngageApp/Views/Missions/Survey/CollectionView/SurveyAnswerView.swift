//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import Foundation
import UIKit

class SurveyAnswerView: BaseView {
    var surveyAnswer: SurveyAnswer
    private var answerType: SurveyAnswerType
    var isPreviouslySelected: Bool

    var selectedItem = PassthroughSubject<String, Never>()
    var unselectedItem = PassthroughSubject<String, Never>()

    private var isSelected = false

    private var state: SurveyAnswerState = .unselected {
        didSet {
            if state == .selected {
                setSelected(selected: true)
                if let answerID = surveyAnswer.id {
                    selectedItem.send(answerID)
                }
            } else {
                setSelected(selected: false)
                if let answerID = surveyAnswer.id {
                    unselectedItem.send(answerID)
                }
            }
        }
    }

    private var answerStkView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 10

        return stackView
    }()

    private var answerImgView: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()

    private var answerLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.numberOfLines = 2
        LabelStyle.surveyAnswerTextLabel.apply(to: label)

        return label
    }()

    var checkBox = CheckBox()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    init(surveyAnswer: SurveyAnswer, type: SurveyAnswerType, isPreviouslySelected: Bool) {
        self.surveyAnswer = surveyAnswer
        answerType = type
        self.isPreviouslySelected = isPreviouslySelected

        super.init(frame: .zero)

        clipsToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = AppAsset.grayLighter.color.cgColor

        configureUI()
        configureConstraints()
    }

    override func configureUI() {
        super.configureUI()

        /// Add gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(answerDidTap))
        addGestureRecognizer(tap)

        addSubview(answerStkView)
        if surveyAnswer.media != nil {
            answerStkView.addArrangedSubview(answerImgView)
            answerImgView.sd_setImage(with: URL(string: surveyAnswer.media), completed: nil)
        }
        answerStkView.addArrangedSubview(answerLbl)

        answerLbl.text = surveyAnswer.text
        if answerType == .select {
            checkBox = CheckBox(isRounded: true)
        } else if answerType == .multiSelect {
            checkBox = CheckBox(isRounded: false)
        }
        checkBox.isUserInteractionEnabled = false
        answerStkView.addArrangedSubview(checkBox)

        if isPreviouslySelected {
            state = .selected
        }
    }

    override func configureConstraints() {
        super.configureConstraints()

        answerStkView.edgeAnchors /==/ edgeAnchors + 10
        answerImgView.widthAnchor /==/ 65
        answerImgView.heightAnchor /==/ 65

        checkBox.widthAnchor /==/ checkBox.heightAnchor
        checkBox.rightAnchor /==/ answerStkView.rightAnchor - 15
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        answerImgView.layer.cornerRadius = 8
    }

    func setSelected(selected: Bool) {
        if selected {
            tapAnimation {
                self.select()
            }
        } else {
            if answerType == .multiSelect {
                tapAnimation {
                    self.deselect()
                }
            } else {
                deselect()
            }
        }

        checkBox.isChecked = selected
        isSelected = selected

        layoutIfNeeded()
    }

    private func deselect() {
        layer.borderColor = AppAsset.grayLighter.color.cgColor
        LabelStyle.surveyAnswerTextLabel.apply(to: answerLbl)
    }

    private func select() {
        layer.borderColor = ThemeManager.currentTheme().primaryColor.cgColor
        LabelStyle.surveyAnswerTextSelectedLabel.apply(to: answerLbl)
    }

    @objc func answerDidTap() {
        state == .selected ? (state = .unselected) : (state = .selected)
    }

    func setState(state: SurveyAnswerState) {
        self.state = state
    }

    func isAnswerSelected() -> Bool {
        return isSelected
    }

    func answerID() -> String? {
        return surveyAnswer.id
    }
}

public enum SurveyAnswerState {
    case selected
    case unselected
}
