//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Foundation

// MARK: - SelectionStyle

public enum SelectionStyle {
    case `switch`
    case checkBox
    case radioButton
}

// MARK: - SignupPrivacyCustomView

public class SignupPrivacyCustomView: BaseView, Validable {
    @objc var urlDidTap: ((URL) -> Void)?
    public var validations: [ValidationType] = [.none]
    public var viewToObserve: UIView?

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10

        return stackView
    }()

    private lazy var label: UITextView = {
        var label = UITextView(frame: .zero)
        label.isEditable = false
        label.textAlignment = .left
        label.linkTextAttributes = [NSAttributedString.Key.foregroundColor: ThemeManager.currentTheme().secondaryColor]
        label.isScrollEnabled = false

        return label
    }()

    public let uiSwitch = UISwitch()
    public let checkBox: CheckBox
    public let isTextView: Bool
    public var privacyString: String
    public var labelStyle: LabelStyles
    public var selectionStyle: SelectionStyle
    public var isTappable: Bool

    public var textView: UITextView = {
        var label = UITextView(frame: .zero)
        label.isEditable = false
        label.textAlignment = .center
        label.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
        label.isScrollEnabled = false

        return label
    }()

    // MARK: - Actions

    public var privacyButtonDidTap: (() -> Void)?

    public init(isTextView: Bool = false, privacyString: String, labelStyle: LabelStyles, selectionStyle: SelectionStyle = .switch, isTappable: Bool = false, isCheckBoxRounded: Bool = false) {
        self.privacyString = privacyString
        self.labelStyle = labelStyle
        self.selectionStyle = selectionStyle
        self.isTappable = isTappable
        self.isTextView = isTextView

        !isCheckBoxRounded ? (checkBox = CheckBox()) : (checkBox = CheckBox(isRounded: true))

        super.init(frame: CGRect.zero)
        configureUI()
        configureConstraints()
    }

    override func configureUI() {
        super.configureUI()

        addSubview(stackView)
        isTextView ? (stackView.addArrangedSubview(textView)) : (stackView.addArrangedSubview(label))
        /// If selection style is `Switch`, we must to add a uiSwitch, else add CheckBox
        stackView.addArrangedSubview(selectionStyle == .switch ? uiSwitch : checkBox)

        label.text = privacyString
        textView.text = privacyString
        //        if isTappable {
        //            let tap = UITapGestureRecognizer(target: self, action: #selector(privacyDidTap))
        //            label.isUserInteractionEnabled = true
        //            label.addGestureRecognizer(tap)
        //        }
        //        label.numberOfLines = 0
        labelStyle.apply(to: label)
        labelStyle.apply(to: textView)

        label.delegate = self
    }

    override func configureConstraints() {
        super.configureConstraints()

        stackView.topAnchor /==/ topAnchor
        stackView.leadingAnchor /==/ leadingAnchor + 5
        stackView.trailingAnchor /==/ trailingAnchor - 5
        stackView.bottomAnchor /==/ bottomAnchor

        if stackView.arrangedSubviews.contains(label) {
            label.topAnchor /==/ stackView.topAnchor
            label.leftAnchor /==/ stackView.leftAnchor
            label.bottomAnchor /==/ stackView.bottomAnchor
            label.widthAnchor /==/ stackView.widthAnchor * 0.7
        } else {
            textView.topAnchor /==/ stackView.topAnchor
            textView.leftAnchor /==/ stackView.leftAnchor
            textView.bottomAnchor /==/ stackView.bottomAnchor
            textView.widthAnchor /==/ stackView.widthAnchor * 0.7
        }

        if selectionStyle == .switch {
            if stackView.arrangedSubviews.contains(label) {
                uiSwitch.centerYAnchor /==/ label.centerYAnchor
            } else {
                uiSwitch.centerYAnchor /==/ textView.centerYAnchor
            }
            uiSwitch.rightAnchor /==/ stackView.rightAnchor
        } else {
            if stackView.arrangedSubviews.contains(label) {
                checkBox.centerYAnchor /==/ label.centerYAnchor
            } else {
                checkBox.centerYAnchor /==/ textView.centerYAnchor
            }
            checkBox.rightAnchor /==/ stackView.rightAnchor
        }

        checkBox.widthAnchor /==/ 50
        checkBox.heightAnchor /==/ checkBox.widthAnchor
    }

    public func setValidations(validations: [ValidationType]) {
        self.validations = validations
    }

    public func setViewToObserve(view: UIView) {
        viewToObserve = view
    }

    public func showError(text: String) {
        guard let controller = Utility.ApplicationHelper.getCurrentVisbileController() else { return }
        controller.showToast(color: UIColor.systemRed, text: text)
    }

    @objc private func privacyDidTap() {
        privacyButtonDidTap?()
    }
}

extension SignupPrivacyCustomView: UITextViewDelegate {
    public func textView(_: UITextView, shouldInteractWith URL: URL, in _: NSRange, interaction _: UITextItemInteraction) -> Bool {
        sendUrlAndTitle(URL: URL)

        return false
    }

    func sendUrlAndTitle(URL: URL) {
        urlDidTap?(URL)
    }
}
