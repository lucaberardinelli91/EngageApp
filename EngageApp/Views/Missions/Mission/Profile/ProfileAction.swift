//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Foundation
import UIKit

struct ActionUser {
    let icon: UIImage?
    let title: String?
    let subTitle: String?
}

class ProfileAction: BaseView {
    @objc var actionTap: (() -> Void)?

    private lazy var iconImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.userBackground.image
        imgView.contentMode = .scaleToFill
        return imgView
    }()

    private lazy var bodyView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = .white

        return view
    }()

    private lazy var titleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.userActionTitle.apply(to: label)

        return label
    }()

    private lazy var subTitleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.userActionSubTitle.apply(to: label)

        return label
    }()

    private lazy var actionImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.userArrowRight.image
        imgView.contentMode = .scaleToFill
        return imgView
    }()

    var actionUser: ActionUser? { didSet { didSetActionUser() }}

    override func configureUI() {
        super.configureUI()

        bodyView.addSubview(titleLbl)
        bodyView.addSubview(subTitleLbl)

        addSubview(iconImgView)
        addSubview(bodyView)
        addSubview(actionImgView)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionDidTap(recognizer:)))
        tapGesture.delegate = self
        addGestureRecognizer(tapGesture)
    }

    override func configureConstraints() {
        super.configureConstraints()

        iconImgView.widthAnchor /==/ 22
        iconImgView.heightAnchor /==/ iconImgView.heightAnchor
        iconImgView.centerYAnchor /==/ centerYAnchor
        iconImgView.leadingAnchor /==/ leadingAnchor + 10

        bodyView.topAnchor /==/ topAnchor + 10
        bodyView.bottomAnchor /==/ bottomAnchor - 10
        bodyView.leadingAnchor /==/ iconImgView.trailingAnchor + 20
        bodyView.heightAnchor /==/ 50
        bodyView.widthAnchor /==/ 220

        titleLbl.topAnchor /==/ bodyView.topAnchor
        titleLbl.leadingAnchor /==/ bodyView.leadingAnchor

        subTitleLbl.topAnchor /==/ titleLbl.bottomAnchor
        subTitleLbl.leadingAnchor /==/ bodyView.leadingAnchor
        subTitleLbl.widthAnchor /==/ bodyView.widthAnchor

        actionImgView.widthAnchor /==/ 7
        actionImgView.heightAnchor /==/ 14
        actionImgView.centerYAnchor /==/ centerYAnchor
        actionImgView.trailingAnchor /==/ trailingAnchor - 10
    }

    private func didSetActionUser() {
        guard let actionUser = actionUser else { return }

        titleLbl.text = actionUser.title
        subTitleLbl.text = actionUser.subTitle
        iconImgView.image = actionUser.icon
    }

    @objc func actionDidTap(recognizer _: UIPanGestureRecognizer) {
        tapAnimation {
            self.actionTap?()
        }
    }
}
