//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit

public class Feedback: BottomSheet {
    @objc var closeButtonTap: (() -> Void)?
    @objc var shareButtonTap: (() -> Void)?

    private lazy var missionImgView: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.image = AppAsset.missionSuccess.image

        return imageView
    }()

    private let titleLbl: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        LabelStyle.feedbackSubtitle.apply(to: label)

        return label
    }()

    private let subtitleLbl: UILabel = {
        var label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        LabelStyle.feedbackSubtitle.apply(to: label)
        label.numberOfLines = 0

        return label
    }()

    private lazy var coinsView: UIView = {
        let view = UIView()

        var label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        LabelStyle.feedbackCoins.apply(to: label)
        label.numberOfLines = 0

        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.walletButtonSmall.image
        imgView.contentMode = .scaleAspectFill

        view.addSubview(label)
        view.addSubview(imgView)

        label.centerYAnchor /==/ view.centerYAnchor
        label.leadingAnchor /==/ view.leadingAnchor

        imgView.leadingAnchor /==/ label.trailingAnchor + 5
        imgView.centerYAnchor /==/ label.centerYAnchor
        imgView.widthAnchor /==/ 24
        imgView.heightAnchor /==/ imgView.widthAnchor

        return view
    }()

    private lazy var shareBtn: UIButton = {
        var button = UIButton(frame: .zero)
        ButtonStyle.feedbackShareButton.apply(to: button)
        button.setTitle("\(L10n.share) ", for: .normal)
        button.setImage(AppAsset.share.image, for: .normal)
        button.hero.id = Constants.HeroTransitionsID.welcomeContinueButton
        button.addTarget(self, action: #selector(shareDidTap), for: .touchUpInside)
        button.semanticContentAttribute = .forceRightToLeft

        return button
    }()

    private lazy var closeBtn: UIButton = {
        var button = UIButton(frame: .zero)
        ButtonStyle.secondaryButton.apply(to: button)
        button.setTitle(L10n.close, for: .normal)
        button.hero.id = Constants.HeroTransitionsID.welcomeContinueButton
        button.addTarget(self, action: #selector(closeDidTap), for: .touchUpInside)

        return button
    }()

    var feedback: (Bool, String)? { didSet { didSetFeedback() }}

    override init(height: CGFloat) {
        super.init(height: UIScreen.main.bounds.height * height)

        configureUI()
        configureConstraints()
    }

    // MARK: - Configure methods

    override func configureUI() {
        super.configureUI()

        backgroundColor = .white

        addSubview(missionImgView)
        addSubview(titleLbl)
        addSubview(subtitleLbl)
        addSubview(coinsView)
        addSubview(shareBtn)
        addSubview(closeBtn)
    }

    override func configureConstraints() {
        super.configureConstraints()

        missionImgView.topAnchor /==/ topAnchor + 35
        missionImgView.centerXAnchor /==/ centerXAnchor
        missionImgView.widthAnchor /==/ 210
        missionImgView.heightAnchor /==/ 170

        titleLbl.topAnchor /==/ missionImgView.bottomAnchor + 20
        titleLbl.leftAnchor /==/ leftAnchor + 32
        titleLbl.rightAnchor /==/ rightAnchor - 32

        subtitleLbl.topAnchor /==/ titleLbl.bottomAnchor + 10
        subtitleLbl.leftAnchor /==/ leftAnchor + 25
        subtitleLbl.rightAnchor /==/ rightAnchor - 25

        coinsView.topAnchor /==/ subtitleLbl.bottomAnchor + 25
        coinsView.widthAnchor /==/ 70
        coinsView.centerXAnchor /==/ centerXAnchor

        shareBtn.topAnchor /==/ coinsView.bottomAnchor + 25
        shareBtn.leftAnchor /==/ leftAnchor + 32
        shareBtn.rightAnchor /==/ rightAnchor - 32
        shareBtn.heightAnchor /==/ 55

        closeBtn.topAnchor /==/ shareBtn.bottomAnchor + 12
        closeBtn.leftAnchor /==/ leftAnchor + 32
        closeBtn.rightAnchor /==/ rightAnchor - 32
        closeBtn.heightAnchor /==/ 55
        closeBtn.bottomAnchor /==/ bottomAnchor - 20
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        closeBtn.layer.cornerRadius = 28
        roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 30)
    }

    private func didSetFeedback() {
        guard let feedback = feedback else { return }

        if feedback.0 {
            missionImgView.image = AppAsset.missionSuccess.image
            titleLbl.text = L10n.missionSuccessTitle
            LabelStyle.feedbackTitleSuccess.apply(to: titleLbl)
            subtitleLbl.text = L10n.missionSuccessSubTitle
            (coinsView.subviews[0] as! UILabel).text = feedback.1.formatValue()
        } else {
            missionImgView.image = AppAsset.missionFailure.image
            titleLbl.text = L10n.missionFailureTitle
            LabelStyle.feedbackTitleFailure.apply(to: titleLbl)
            subtitleLbl.text = L10n.missionFailureSubTitle
            closeBtn.topAnchor /==/ subtitleLbl.bottomAnchor + 20
            coinsView.isHidden = true
            shareBtn.isHidden = true
        }
    }

    @objc func shareDidTap() {
        shareBtn.tapAnimation {
            self.shareButtonTap?()
        }
    }

    @objc func closeDidTap() {
        closeBtn.tapAnimation {
            self.closeButtonTap?()
        }
    }
}
