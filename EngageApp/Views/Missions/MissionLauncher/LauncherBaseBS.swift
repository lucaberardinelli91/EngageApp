//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit

enum LauncherType {
    case quiz
    case survey
    case info
    case social
    case fancam
}

public struct Launcher {
    var title: String? = ""
    let subTitle: String?
    let description: String?
    let questions: Int?
    let time: Int?
    let coins: Int?
    let fancam: String?
    let endAt: String?
    let provider: String?
}

public class LauncherBaseBS: BottomSheet {
    @objc var launcherBtnTap: (() -> Void)?

    var pullView: UIView = {
        var containerView = UIView(frame: .zero)
        containerView.backgroundColor = .clear

        var pullView = UIView(frame: .zero)
        pullView.backgroundColor = AppAsset.grayLighter.color
        pullView.layer.cornerRadius = 3
        containerView.addSubview(pullView)

        pullView.centerAnchors /==/ containerView.centerAnchors
        pullView.widthAnchor /==/ 60
        pullView.heightAnchor /==/ 6

        return containerView
    }()

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()

    let backImgView: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.image = AppAsset.launcherBackground.image

        return imageView
    }()

    let foreImgView: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    let titleLbl: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        LabelStyle.launcherTitle.apply(to: label)
        label.numberOfLines = 0

        return label
    }()

    let subtitleLbl: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        LabelStyle.launcherSubTitle.apply(to: label)
        label.numberOfLines = 0

        return label
    }()

    let bodyView: UIView = {
        let view = UIView()

        return view
    }()

    let descriptionLbl: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        LabelStyle.launcherDescription.apply(to: label)
        label.numberOfLines = 0

        return label
    }()

    let timerLbl: TimerMission = {
        let timer = TimerMission()
        timer.inLauncher = true

        return timer
    }()

    let launcherBtn: UIButton = {
        var button = UIButton(frame: .zero)
        ButtonStyle.coinsButton.apply(to: button)
        button.hero.id = Constants.HeroTransitionsID.welcomeContinueButton
        button.addTarget(self, action: #selector(launcherDidTap), for: .touchUpInside)
        button.setImage(AppAsset.walletButtonSmall.image, for: .normal)
        button.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft

        return button
    }()

    override init(height: CGFloat) {
        super.init(height: height)

        configureUI()
        configureConstraints()
    }

    override func configureUI() {
        super.configureUI()

        backgroundColor = .clear

        addSubview(pullView)
        containerView.addSubview(backImgView)
        containerView.addSubview(foreImgView)
        containerView.addSubview(titleLbl)
        containerView.addSubview(subtitleLbl)
        containerView.addSubview(bodyView)
        containerView.addSubview(descriptionLbl)
        containerView.addSubview(timerLbl)
        containerView.addSubview(launcherBtn)
        addSubview(containerView)
    }

    override func configureConstraints() {
        super.configureConstraints()

        containerView.topAnchor == topAnchor + 23
        containerView.widthAnchor == widthAnchor
        containerView.bottomAnchor == bottomAnchor

        pullView.topAnchor /==/ topAnchor + 10
        pullView.centerXAnchor /==/ containerView.centerXAnchor
        pullView.heightAnchor /==/ 5
        pullView.widthAnchor /==/ 55

        backImgView.topAnchor /==/ containerView.topAnchor
        backImgView.centerXAnchor /==/ containerView.centerXAnchor
        backImgView.bottomAnchor /==/ containerView.topAnchor + 70
        backImgView.widthAnchor /==/ 300

        foreImgView.topAnchor /==/ containerView.topAnchor + 30
        foreImgView.centerXAnchor /==/ containerView.centerXAnchor
        foreImgView.widthAnchor /==/ 68
        foreImgView.heightAnchor /==/ 68

        titleLbl.topAnchor /==/ foreImgView.bottomAnchor + 15
        titleLbl.leftAnchor /==/ containerView.leftAnchor + 54
        titleLbl.rightAnchor /==/ containerView.rightAnchor - 54

        subtitleLbl.topAnchor /==/ titleLbl.bottomAnchor + 2
        subtitleLbl.leftAnchor /==/ containerView.leftAnchor + 25
        subtitleLbl.rightAnchor /==/ containerView.rightAnchor - 25

        bodyView.topAnchor /==/ subtitleLbl.bottomAnchor + 30
        bodyView.leadingAnchor /==/ containerView.leadingAnchor + 110
        bodyView.trailingAnchor /==/ containerView.trailingAnchor - 110
        bodyView.heightAnchor /==/ 130 // 100

        descriptionLbl.topAnchor /==/ bodyView.bottomAnchor + 10
        descriptionLbl.leftAnchor /==/ containerView.leftAnchor + 65
        descriptionLbl.rightAnchor /==/ containerView.rightAnchor - 65
        descriptionLbl.bottomAnchor /==/ timerLbl.topAnchor - 20

        timerLbl.centerXAnchor /==/ containerView.centerXAnchor
        timerLbl.bottomAnchor /==/ launcherBtn.topAnchor - 4
        timerLbl.heightAnchor /==/ 20

        launcherBtn.bottomAnchor /==/ containerView.bottomAnchor - 25
        launcherBtn.centerXAnchor /==/ centerXAnchor
        launcherBtn.widthAnchor /==/ 280
        launcherBtn.heightAnchor /==/ 55
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        launcherBtn.layer.cornerRadius = 28

        containerView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 30)
    }

    @objc func launcherDidTap() {
        launcherBtn.tapAnimation {
            self.launcherBtnTap?()
        }
    }
}
