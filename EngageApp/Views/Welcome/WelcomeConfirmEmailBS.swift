//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit

public class WelcomeConfirmEmailBS: BottomSheet {
    @objc var continueButtonTap: (() -> Void)?

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

    private lazy var confirmEmailImgView: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.image = AppAsset.emailConfirm.image

        return imageView
    }()

    private let titleLbl: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        LabelStyle.welcomeTitle.apply(to: label)
        label.text = L10n.welcomeConfirmEmailTitle

        return label
    }()

    private let subtitleLbl: UILabel = {
        var label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        LabelStyle.welcomeSubTitle.apply(to: label)
        label.text = L10n.welcomeConfirmEmailSubTitle
        label.numberOfLines = 0

        return label
    }()

    private lazy var readEmailBtn: UIButton = {
        var button = UIButton(frame: .zero)
        ButtonStyle.secondaryButton.apply(to: button)
        button.setTitle(L10n.welcomeOpenEmailClient.uppercased(), for: .normal)
        button.hero.id = Constants.HeroTransitionsID.welcomeContinueButton
        button.addTarget(self, action: #selector(readEmailDidTap), for: .touchUpInside)

        return button
    }()

    init() {
        super.init(height: 473)

        configureUI()
        configureConstraints()
    }

    override func configureUI() {
        super.configureUI()

        backgroundColor = .white

        addSubview(pullView)
        addSubview(confirmEmailImgView)
        addSubview(titleLbl)
        addSubview(subtitleLbl)
        addSubview(readEmailBtn)
    }

    override func configureConstraints() {
        super.configureConstraints()

        pullView.topAnchor /==/ topAnchor + 10
        pullView.centerXAnchor /==/ centerXAnchor
        pullView.heightAnchor /==/ 5
        pullView.widthAnchor /==/ 55

        confirmEmailImgView.topAnchor /==/ pullView.bottomAnchor + 30
        confirmEmailImgView.centerXAnchor /==/ centerXAnchor
        confirmEmailImgView.widthAnchor /==/ 210
        confirmEmailImgView.heightAnchor /==/ 170

        titleLbl.topAnchor /==/ confirmEmailImgView.bottomAnchor + 30
        titleLbl.leftAnchor /==/ leftAnchor + 54
        titleLbl.rightAnchor /==/ rightAnchor - 54

        subtitleLbl.topAnchor /==/ titleLbl.bottomAnchor + 14
        subtitleLbl.leftAnchor /==/ leftAnchor + 20
        subtitleLbl.rightAnchor /==/ rightAnchor - 20

        readEmailBtn.topAnchor /==/ subtitleLbl.bottomAnchor + 40
        readEmailBtn.leftAnchor /==/ leftAnchor + 63
        readEmailBtn.rightAnchor /==/ rightAnchor - 62
        readEmailBtn.heightAnchor /==/ 55
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        readEmailBtn.layer.cornerRadius = 28
        roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }

    @objc func readEmailDidTap() {
        readEmailBtn.tapAnimation {
            self.continueButtonTap?()
        }
    }
}
