//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit

public class ActionHowBS: BottomSheet {
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

    init() {
        super.init(height: UIScreen.main.bounds.height * 0.62)

        configureUI()
        configureConstraints()
    }

    override func configureUI() {
        super.configureUI()

        backgroundColor = .clear

        addSubview(pullView)
        addSubview(confirmEmailImgView)
    }

    override func configureConstraints() {
        super.configureConstraints()

        pullView.topAnchor /==/ topAnchor + 10
        pullView.centerXAnchor /==/ centerXAnchor
        pullView.heightAnchor /==/ 5
        pullView.widthAnchor /==/ 55

        confirmEmailImgView.centerXAnchor /==/ centerXAnchor
        confirmEmailImgView.widthAnchor /==/ 210
        confirmEmailImgView.heightAnchor /==/ 170
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
}
