//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import Foundation
import UIKit

public class SurveyAnswersView: BaseView {
    var closeButtonDidTap = PassthroughSubject<Void, Never>()
    var backButtonDidTap = PassthroughSubject<Void, Never>()

    private var answersProgressBar: UIProgressView = {
        var view = UIProgressView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.sublayers?[1].cornerRadius = 5
        view.subviews[1].clipsToBounds = true

        view.progressTintColor = ThemeManager.currentTheme().secondaryColor
        view.trackTintColor = ThemeManager.currentTheme().secondaryColor.withAlphaComponent(0.25)

        return view
    }()

    private var progressLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.surveyProgressLabel.apply(to: label)

        return label
    }()

    private var closeBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.tintColor = AppAsset.grayBase.color
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(closeDidTap), for: .touchUpInside)

        return button
    }()

    var surveyImgView: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()

    var answersCollView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.backgroundColor = AppAsset.grayLighter.color
        collectionView.clipsToBounds = false
        collectionView.isScrollEnabled = false
        collectionView.register(SurveyAnswerCollectionViewCell.self)

        return collectionView
    }()

    private var backBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = AppAsset.grayBase.color
        button.addTarget(self, action: #selector(backDidTap), for: .touchUpInside)
        button.isHidden = true

        return button
    }()

    var questionImg: String? { didSet { didSetSurveyImg() }}
    var isSurveyWithImages: Bool = false

    override func configureUI() {
        super.configureUI()

        backgroundColor = AppAsset.grayLighter.color

        addSubview(closeBtn)
        addSubview(backBtn)
        addSubview(progressLbl)
        progressLbl.text = "0%"
        addSubview(answersProgressBar)
        addSubview(surveyImgView)
        addSubview(answersCollView)
        answersCollView.setCollectionViewLayout(makeLayout(), animated: true)
    }

    override func configureConstraints() {
        super.configureConstraints()
    }

    func refreshConstraints() {
        closeBtn.rightAnchor /==/ rightAnchor - 15
        closeBtn.topAnchor /==/ safeAreaLayoutGuide.topAnchor + 15
        closeBtn.widthAnchor /==/ 25
        closeBtn.heightAnchor /==/ 25

        backBtn.centerYAnchor /==/ closeBtn.centerYAnchor
        backBtn.leftAnchor /==/ leftAnchor + 15
        backBtn.widthAnchor /==/ 25
        backBtn.heightAnchor /==/ 25

        answersProgressBar.centerYAnchor /==/ closeBtn.centerYAnchor
        answersProgressBar.centerXAnchor /==/ centerXAnchor * 0.85
        answersProgressBar.heightAnchor /==/ 10
        answersProgressBar.widthAnchor /==/ widthAnchor * 0.6

        progressLbl.centerYAnchor /==/ closeBtn.centerYAnchor
        progressLbl.leftAnchor /==/ answersProgressBar.rightAnchor + 15
        progressLbl.widthAnchor /==/ 40
        progressLbl.heightAnchor /==/ 40

        surveyImgView.topAnchor /==/ answersProgressBar.bottomAnchor + 20
        surveyImgView.horizontalAnchors /==/ horizontalAnchors

        answersCollView.leftAnchor /==/ leftAnchor
        answersCollView.rightAnchor /==/ rightAnchor

        if isSurveyWithImages {
            surveyImgView.image == nil ? surveyImgView.image = AppAsset.surveyBackground.image : nil
            surveyImgView.heightAnchor /==/ 215
            answersCollView.heightAnchor /==/ 600
        } else {
            surveyImgView.heightAnchor /==/ 0
            answersCollView.bottomAnchor /==/ bottomAnchor
        }

//        surveyImgView.image = !isSurveyWithImages || surveyImgView.image == nil ? nil : AppAsset.surveyBackground.image

//        if surveyImgView.image != nil {
//            surveyImgView.heightAnchor /==/ 215
//            answersCollView.heightAnchor /==/ 600
//        } else {
//            surveyImgView.heightAnchor /==/ 0
//            answersCollView.bottomAnchor /==/ bottomAnchor
//        }
        answersCollView.topAnchor /==/ surveyImgView.bottomAnchor + 10
    }

    private func didSetSurveyImg() {
        guard let surveyImg = questionImg else {
            refreshConstraints()
            return
        }

        surveyImgView.sd_setImage(with: URL(string: surveyImg)) { [self] image, _, _, _ in
            surveyImgView.image = image
            refreshConstraints()
        }
    }

    @objc func closeDidTap() {
        closeBtn.tapAnimation {
            self.closeButtonDidTap.send()
        }
    }

    @objc func backDidTap() {
        backBtn.tapAnimation {
            self.backButtonDidTap.send()
        }
    }

    func showBackButton() {
        if backBtn.isHidden {
            UIView.transition(with: backBtn, duration: 0.4, options: .transitionFlipFromLeft) {
                self.backBtn.isHidden = false
            }
        }
    }

    func hideBackButton() {
        UIView.transition(with: backBtn, duration: 0.4, options: .transitionFlipFromRight) {
            self.backBtn.isHidden = true
        }
    }

    func setProgress(progress: Float) {
        if answersProgressBar.progress != progress {
            answersProgressBar.setProgress(progress, animated: true)
            UIView.transition(with: progressLbl, duration: 0.4, options: .transitionCrossDissolve) {
                self.progressLbl.text = String(format: "%.0f", progress * 100) + "%"
            }
        }
    }

    func showProgressBar(_ show: Bool) {
        answersProgressBar.isHidden = show ? false : true
        progressLbl.isHidden = answersProgressBar.isHidden
    }
}
