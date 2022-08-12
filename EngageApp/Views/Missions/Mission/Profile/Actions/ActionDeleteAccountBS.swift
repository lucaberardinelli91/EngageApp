//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit

public class ActionDeleteAccountBS: BottomSheet {
    @objc var deleteBtnTap: (() -> Void)?
    @objc var cancelBtnTap: (() -> Void)?

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

    private lazy var titleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .center
        LabelStyle.cruiseTitle.apply(to: label)
        label.text = L10n.deleteAccountConfirm

        return label
    }()

    private lazy var subTitleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.cruiseSubTitle.apply(to: label)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "What, I don't get what happened. I guarantee it. I don't know, Doc, I guess she felt sorry for him cause her did hit"

        return label
    }()

    private lazy var descrLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.cruiseDescr.apply(to: label)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "You're gonna break his arm. Biff, leave him alone. Let him go. Let him go. Yeah, but I never picked a fight"

        return label
    }()

    private lazy var deleteBtn: UIButton = {
        var button = UIButton(frame: .zero)
        ButtonStyle.dangerReverseButton.apply(to: button)
        button.setTitle(L10n.deleteAccount, for: .normal)
        button.hero.id = Constants.HeroTransitionsID.welcomeContinueButton
        button.addTarget(self, action: #selector(deleteDidTap), for: .touchUpInside)

        return button
    }()

    private lazy var cancelBtn: UIButton = {
        var button = UIButton(frame: .zero)
        ButtonStyle.secondaryButton.apply(to: button)
        button.setTitle(L10n.cancel, for: .normal)
        button.hero.id = Constants.HeroTransitionsID.welcomeContinueButton
        button.addTarget(self, action: #selector(cancelDidTap), for: .touchUpInside)

        return button
    }()

    init() {
        super.init(height: 430)

        configureUI()
        configureConstraints()
    }

    override func configureUI() {
        super.configureUI()

        backgroundColor = .white

        addSubview(pullView)
        addSubview(titleLbl)
        addSubview(subTitleLbl)
        addSubview(descrLbl)
        addSubview(deleteBtn)
        addSubview(cancelBtn)
    }

    override func configureConstraints() {
        super.configureConstraints()

        pullView.topAnchor /==/ topAnchor + 10
        pullView.centerXAnchor /==/ centerXAnchor
        pullView.heightAnchor /==/ 5
        pullView.widthAnchor /==/ 55

        titleLbl.topAnchor /==/ pullView.bottomAnchor + 20
        titleLbl.centerXAnchor /==/ centerXAnchor
        titleLbl.leadingAnchor /==/ leadingAnchor + 25
        titleLbl.trailingAnchor /==/ trailingAnchor - 25

        subTitleLbl.topAnchor /==/ titleLbl.bottomAnchor + 5
        subTitleLbl.centerXAnchor /==/ centerXAnchor
        subTitleLbl.leadingAnchor /==/ leadingAnchor + 25
        subTitleLbl.trailingAnchor /==/ trailingAnchor - 25

        descrLbl.topAnchor /==/ subTitleLbl.bottomAnchor + 30
        descrLbl.centerXAnchor /==/ centerXAnchor
        descrLbl.leadingAnchor /==/ leadingAnchor + 25
        descrLbl.trailingAnchor /==/ trailingAnchor - 25

        deleteBtn.topAnchor /==/ descrLbl.bottomAnchor + 40
        deleteBtn.leftAnchor /==/ leftAnchor + 32
        deleteBtn.rightAnchor /==/ rightAnchor - 32
        deleteBtn.heightAnchor /==/ 55

        cancelBtn.topAnchor /==/ deleteBtn.bottomAnchor + 5
        cancelBtn.leftAnchor /==/ leftAnchor + 32
        cancelBtn.rightAnchor /==/ rightAnchor - 32
        cancelBtn.heightAnchor /==/ 55
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }

    @objc func deleteDidTap() {
        deleteBtn.tapAnimation {
            self.deleteBtnTap?()
        }
    }

    @objc func cancelDidTap() {
        cancelBtn.tapAnimation {
            self.cancelBtnTap?()
        }
    }
}
