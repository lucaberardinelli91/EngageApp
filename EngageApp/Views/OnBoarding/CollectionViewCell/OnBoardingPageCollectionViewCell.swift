//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import Foundation
import SDWebImage
import SwiftRichString
import UIKit

class OnBoardingPageCollectionViewCell: BaseCell {
    private var viewModel: OnBoardingPageCollectionViewCellViewModel?
    private var cancellables = Set<AnyCancellable>()
    var skipTap: (() -> Void)?
    var updateIndex: (() -> Void)?
    var index = 0

    lazy var skipBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.setTitle(L10n.skip, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = AppAsset.clear.color
        button.addTarget(self, action: #selector(skipButtonDidTap), for: .touchUpInside)

        return button
    }()

    private lazy var backgroundCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    var foregroundImgView: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private lazy var dottedProgress: DottedProgress = {
        let dottedProgress = DottedProgress()

        return dottedProgress
    }()

    private var titleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()

    private var descriptionLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()

    override func configureUI() {
        super.configureUI()

        addSubview(skipBtn)
        addSubview(backgroundCircleView)
        addSubview(foregroundImgView)
        addSubview(dottedProgress)
        addSubview(titleLbl)
        addSubview(descriptionLbl)
    }

    override func configureConstraints() {
        super.configureConstraints()

        skipBtn.trailingAnchor /==/ trailingAnchor - 20
        skipBtn.widthAnchor /==/ 75
        skipBtn.heightAnchor /==/ 45

        backgroundCircleView.centerXAnchor /==/ centerXAnchor
        backgroundCircleView.topAnchor /==/ foregroundImgView.centerYAnchor - 15
        backgroundCircleView.widthAnchor /==/ widthAnchor * 3
        backgroundCircleView.heightAnchor /==/ backgroundCircleView.widthAnchor

        foregroundImgView.centerXAnchor /==/ centerXAnchor
        foregroundImgView.widthAnchor /==/ widthAnchor / 1.3
        foregroundImgView.heightAnchor /==/ foregroundImgView.widthAnchor

        dottedProgress.centerXAnchor /==/ centerXAnchor

        titleLbl.leftAnchor /==/ leftAnchor + 30
        titleLbl.rightAnchor /==/ rightAnchor - 30
        titleLbl.heightAnchor /==/ 85

        descriptionLbl.topAnchor /==/ titleLbl.bottomAnchor + 15
        descriptionLbl.leftAnchor /==/ leftAnchor + 54
        descriptionLbl.rightAnchor /==/ rightAnchor - 52
        descriptionLbl.heightAnchor /==/ 85

        if UIScreen.main.bounds.height < Constants.screenHeightSmall {
            skipBtn.topAnchor /==/ topAnchor + 30
            foregroundImgView.topAnchor /==/ topAnchor + 90
            dottedProgress.topAnchor /==/ foregroundImgView.bottomAnchor + 18
            titleLbl.topAnchor /==/ dottedProgress.bottomAnchor + 40
            descriptionLbl.bottomAnchor /==/ bottomAnchor - 144
        } else {
            skipBtn.topAnchor /==/ topAnchor + 60
            foregroundImgView.topAnchor /==/ topAnchor + 120
            titleLbl.topAnchor /==/ dottedProgress.bottomAnchor + 40
            dottedProgress.topAnchor /==/ foregroundImgView.bottomAnchor + 14
        }
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        removeGradient()
        setGradientBackground(startPoint: CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint(x: 0.8, y: 0.5), startColor: ThemeManager.currentTheme().tertiaryColor, endColor: AppAsset.orangeLight.color)

        drawStepProgressBar()

        skipBtn.layer.cornerRadius = 22
    }

    private func drawStepProgressBar() {
        dottedProgress.stepStkView.arrangedSubviews.forEach { stackView in
            (stackView as! UIStackView).arrangedSubviews.forEach { view in
                if view.subviews.count > 0 {
                    let subView = view.subviews[0]
                    subView.layer.cornerRadius = 5
                    guard let viewId = subView.accessibilityIdentifier else { return }
                    if Int(viewId) == self.index {
                        view.layer.borderColor = ThemeManager.currentTheme().primaryColor.cgColor
                        subView.backgroundColor = ThemeManager.currentTheme().primaryColor
                    }
                }
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        backgroundCircleView.clipsToBounds = true
        backgroundCircleView.layer.cornerRadius = backgroundCircleView.bounds.width / 2
    }

    private func refreshUI(configurator: OnBoardingPage) {
        foregroundImgView.image = AppAsset.onboarding.image

        titleLbl.text = configurator.title
        LabelStyle.onBoardingTitle.apply(to: titleLbl)

        descriptionLbl.text = configurator.description
        LabelStyle.onBoardingSubTitle.apply(to: descriptionLbl)

        if let index = configurator.index {
            self.index = index
            updateIndex?()
            skipBtn.isHidden = configurator.index == 3 ? true : false
        }
    }

    func configureViewModel(viewModel: OnBoardingPageCollectionViewCellViewModel) {
        self.viewModel = viewModel

        configureBinds()
        viewModel.getInfo()
    }

    private func configureBinds() {
        viewModel?.$onboardinCollectionViewCellState
            .sink(receiveValue: { state in
                switch state {
                case let .success(configurator):
                    self.refreshUI(configurator: configurator)
                    self.configureConstraints()
                default:
                    break
                }
            })
            .store(in: &cancellables)
    }

    @objc func nextAction(_: Any) {
        viewModel?.nextButtonTap()
    }

    @objc func skipButtonDidTap() {
        skipBtn.tapAnimation {
            self.skipTap?()
        }
    }
}
