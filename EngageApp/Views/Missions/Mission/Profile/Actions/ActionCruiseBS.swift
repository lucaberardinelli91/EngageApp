//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit

public class CruiseBS: BottomSheet {
    @objc var exitButtonTap: (() -> Void)?
    @objc var helpButtonTap: (() -> Void)?

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

    private lazy var foreImgView: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.image = AppAsset.userForeMyAccount.image

        return imageView
    }()

    private lazy var titleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .center
        LabelStyle.cruiseTitle.apply(to: label)
        label.text = L10n.profileCruiseTitle

        return label
    }()

    private lazy var cruiseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 2
        view.layer.borderColor = ThemeManager.currentTheme().secondaryColor.withAlphaComponent(0.2).cgColor

        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = ContentMode.scaleAspectFill
        imgView.image = AppAsset.userMyAccountCruise.image

        let title = UILabel()
        title.numberOfLines = 1
        LabelStyle.userCruiseTitle.apply(to: title)

        let subTitle = UILabel()
        subTitle.numberOfLines = 1
        LabelStyle.userCruiseSubTitle.apply(to: subTitle)

        view.addSubview(imgView)
        view.addSubview(title)
        view.addSubview(subTitle)

        imgView.widthAnchor /==/ 45
        imgView.heightAnchor /==/ imgView.widthAnchor
        imgView.centerYAnchor /==/ view.centerYAnchor
        imgView.leadingAnchor /==/ view.leadingAnchor + 15

        title.topAnchor /==/ view.topAnchor + 15
        title.leadingAnchor /==/ imgView.trailingAnchor + 15

        subTitle.topAnchor /==/ title.bottomAnchor + 5
        subTitle.leadingAnchor /==/ title.leadingAnchor

        return view
    }()

    private lazy var subTitleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.cruiseSubTitle.apply(to: label)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "You're gonna break his arm. Biff, leave him alone. Let him go. Let him go. Yeah, but I never picked a fight"

        return label
    }()

    private lazy var exitBtn: UIButton = {
        var button = UIButton(frame: .zero)
        ButtonStyle.secondaryButton.apply(to: button)
        button.setTitle(L10n.profileExit, for: .normal)
        button.hero.id = Constants.HeroTransitionsID.welcomeContinueButton
        button.addTarget(self, action: #selector(shareDidTap), for: .touchUpInside)

        return button
    }()

    private lazy var helpBtn: UIButton = {
        var button = UIButton(frame: .zero)
        ButtonStyle.secondaryReverseButton.apply(to: button)
        button.setTitle(L10n.profileCallHelp, for: .normal)
        button.hero.id = Constants.HeroTransitionsID.welcomeContinueButton
        button.addTarget(self, action: #selector(closeDidTap), for: .touchUpInside)

        return button
    }()

    var cruise: (String, String)? { didSet { didSetCruise() }}

    init() {
        super.init(height: 570)

        configureUI()
        configureConstraints()
    }

    override func configureUI() {
        super.configureUI()

        backgroundColor = .white

        addSubview(pullView)
        addSubview(foreImgView)
        addSubview(titleLbl)
        addSubview(cruiseView)
        addSubview(subTitleLbl)
        addSubview(exitBtn)
        addSubview(helpBtn)
    }

    override func configureConstraints() {
        super.configureConstraints()

        pullView.topAnchor /==/ topAnchor + 10
        pullView.centerXAnchor /==/ centerXAnchor
        pullView.heightAnchor /==/ 5
        pullView.widthAnchor /==/ 55

        foreImgView.topAnchor /==/ topAnchor + 30
        foreImgView.centerXAnchor /==/ centerXAnchor
        foreImgView.widthAnchor /==/ widthAnchor / 3
        foreImgView.heightAnchor /==/ foreImgView.widthAnchor

        titleLbl.topAnchor /==/ foreImgView.bottomAnchor + 10
        titleLbl.centerXAnchor /==/ centerXAnchor
        titleLbl.leadingAnchor /==/ leadingAnchor + 25
        titleLbl.trailingAnchor /==/ trailingAnchor - 25

        cruiseView.topAnchor /==/ titleLbl.bottomAnchor + 20
        cruiseView.leadingAnchor /==/ leadingAnchor + 20
        cruiseView.trailingAnchor /==/ trailingAnchor - 20
        cruiseView.heightAnchor /==/ 80
        cruiseView.centerXAnchor /==/ centerXAnchor

        subTitleLbl.topAnchor /==/ cruiseView.bottomAnchor + 15
        subTitleLbl.centerXAnchor /==/ centerXAnchor
        subTitleLbl.leadingAnchor /==/ leadingAnchor + 25
        subTitleLbl.trailingAnchor /==/ trailingAnchor - 25

        exitBtn.topAnchor /==/ subTitleLbl.bottomAnchor + 25
        exitBtn.leftAnchor /==/ leftAnchor + 32
        exitBtn.rightAnchor /==/ rightAnchor - 32
        exitBtn.heightAnchor /==/ 55

        helpBtn.topAnchor /==/ exitBtn.bottomAnchor + 5
        helpBtn.leftAnchor /==/ leftAnchor + 32
        helpBtn.rightAnchor /==/ rightAnchor - 32
        helpBtn.heightAnchor /==/ 55
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        roundCorners(corners: [.topLeft, .topRight], radius: 30)
        cruiseView.layer.cornerRadius = 10
    }

    @objc func shareDidTap() {
        exitBtn.tapAnimation {
            self.exitButtonTap?()
        }
    }

    @objc func closeDidTap() {
        helpBtn.tapAnimation {
            self.helpButtonTap?()
        }
    }

    private func didSetCruise() {
        guard let cruise = cruise else { return }

        (cruiseView.subviews[1] as! UILabel).text = cruise.0
        (cruiseView.subviews[2] as! UILabel).text = cruise.1
    }
}
