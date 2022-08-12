//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public class FanCamAddCommentView: BaseView {
    @objc var saveWithCommentTap: ((String) -> Void)?
    @objc var saveWithoutCommentTap: (() -> Void)?

    private lazy var triangleView: TriangleView = {
        let view = TriangleView(frame: CGRect(x: 10, y: 20, width: 25, height: 30))
        view.backgroundColor = .clear

        return view
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()

    private let titleLbl: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        LabelStyle.fancamAddCommentTitle.apply(to: label)
        label.text = L10n.fancamAddCommentTitle

        return label
    }()

    private let subtitleLbl: UILabel = {
        var label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        LabelStyle.fancamAddCommentSubTitle.apply(to: label)
        label.text = L10n.fancamAddCommentSubTitle
        label.numberOfLines = 0

        return label
    }()

    var commentView: UITextView = {
        let textView = UITextView()
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.textAlignment = .justified
        textView.backgroundColor = AppAsset.grayLighter.color.withAlphaComponent(0.4)
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 10
        textView.font = ThemeManager.currentTheme().primaryFont.font(size: 16)
        textView.textColor = .lightGray
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        textView.text = L10n.surveyPlaceholderMessage
        return textView
    }()

    private lazy var saveWithCommentBtn: UIButton = {
        var button = UIButton(frame: .zero)
        ButtonStyle.secondaryButton.apply(to: button)
        button.setTitle(L10n.fancamSaveWithComment, for: .normal)
        button.hero.id = Constants.HeroTransitionsID.welcomeContinueButton
        button.addTarget(self, action: #selector(saveWithCommentDidTap), for: .touchUpInside)

        return button
    }()

    private lazy var saveWithoutCommentBtn: UIButton = {
        var button = UIButton(frame: .zero)
        ButtonStyle.secondaryReverseButton.apply(to: button)
        button.setTitle(L10n.fancamSaveWithoutComment, for: .normal)
        button.hero.id = Constants.HeroTransitionsID.welcomeContinueButton
        button.addTarget(self, action: #selector(saveWithoutCommentDidTap), for: .touchUpInside)

        return button
    }()

    override func configureUI() {
        super.configureUI()

        backgroundColor = .clear

        containerView.addSubview(titleLbl)
        containerView.addSubview(subtitleLbl)
        containerView.addSubview(commentView)
        containerView.addSubview(saveWithCommentBtn)
        containerView.addSubview(saveWithoutCommentBtn)

        addSubview(triangleView)
        addSubview(containerView)

        commentView.delegate = self
    }

    override func configureConstraints() {
        super.configureConstraints()

        containerView.topAnchor /==/ topAnchor + 12
        containerView.leadingAnchor /==/ leadingAnchor
        containerView.trailingAnchor /==/ trailingAnchor
        containerView.bottomAnchor /==/ bottomAnchor

        triangleView.topAnchor /==/ topAnchor
        triangleView.bottomAnchor /==/ containerView.topAnchor
        triangleView.centerXAnchor /==/ centerXAnchor
        triangleView.widthAnchor /==/ 20
        triangleView.heightAnchor /==/ triangleView.widthAnchor

        titleLbl.topAnchor /==/ containerView.topAnchor + 25
        titleLbl.centerXAnchor /==/ containerView.centerXAnchor
        titleLbl.heightAnchor /==/ 35

        subtitleLbl.topAnchor /==/ titleLbl.bottomAnchor + 10
        subtitleLbl.centerXAnchor /==/ containerView.centerXAnchor
        subtitleLbl.leadingAnchor /==/ containerView.leadingAnchor + 40
        subtitleLbl.trailingAnchor /==/ containerView.trailingAnchor - 40
        subtitleLbl.heightAnchor /==/ 45

        commentView.topAnchor /==/ subtitleLbl.bottomAnchor + 15
        commentView.leadingAnchor /==/ containerView.leadingAnchor + 20
        commentView.trailingAnchor /==/ containerView.trailingAnchor - 20
        commentView.heightAnchor /==/ 170

        saveWithCommentBtn.topAnchor /==/ commentView.bottomAnchor + 20
        saveWithCommentBtn.leftAnchor /==/ containerView.leftAnchor + 63
        saveWithCommentBtn.rightAnchor /==/ containerView.rightAnchor - 62
        saveWithCommentBtn.heightAnchor /==/ 55

        saveWithoutCommentBtn.topAnchor /==/ saveWithCommentBtn.bottomAnchor
        saveWithoutCommentBtn.rightAnchor /==/ saveWithCommentBtn.rightAnchor
        saveWithoutCommentBtn.leftAnchor /==/ saveWithCommentBtn.leftAnchor
        saveWithoutCommentBtn.heightAnchor /==/ saveWithCommentBtn.heightAnchor
        saveWithoutCommentBtn.bottomAnchor /==/ bottomAnchor - 30
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        saveWithCommentBtn.layer.cornerRadius = 28
        saveWithoutCommentBtn.layer.cornerRadius = 28
        containerView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }

    @objc func saveWithCommentDidTap() {
        guard let comment = commentView.text else { return }
        saveWithCommentBtn.tapAnimation {
            self.saveWithCommentTap?(comment)
        }
    }

    @objc func saveWithoutCommentDidTap() {
        saveWithoutCommentBtn.tapAnimation {
            self.saveWithoutCommentTap?()
        }
    }
}

extension FanCamAddCommentView: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == L10n.surveyPlaceholder {
            textView.text.removeAll()
            textView.textColor = AppAsset.grayOpaque.color
            textView.tintColor = AppAsset.grayOpaque.color
        }
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = UIColor.lightGray.color
            textView.tintColor = UIColor.lightGray.color
            textView.text = L10n.surveyPlaceholder
        }
    }
}
