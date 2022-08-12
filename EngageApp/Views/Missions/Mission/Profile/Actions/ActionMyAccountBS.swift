//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit

struct Account {
    let name: String?
    let surname: String?
    let email: String?
}

public class ActionMyAccountBS: BottomSheet {
    @objc var saveBtnTap: (() -> Void)?
    @objc var logoutBtnTap: (() -> Void)?
    @objc var userImgTap: (() -> Void)?

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

    lazy var userImgView: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = AppAsset.userMyAccountPlaceholder.image
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(userImgDidTap(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)

        return imageView
    }()

    private lazy var titleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .center
        LabelStyle.accountTitle.apply(to: label)
        label.text = L10n.profileMyAcountTitle

        return label
    }()

    private lazy var subTitleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.accountSubTitle.apply(to: label)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Well just gimme something without"

        return label
    }()

    private lazy var nameLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.accountName.apply(to: label)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = L10n.name

        return label
    }()

    private lazy var nameView: UIView = {
        let view = UIView()
        view.backgroundColor = AppAsset.background.color

        let label = UILabel()
        LabelStyle.accountNameValue.apply(to: label)
        label.numberOfLines = 0

        view.addSubview(label)
        label.centerYAnchor /==/ view.centerYAnchor
        label.leadingAnchor /==/ view.leadingAnchor + 15

        return view
    }()

    private lazy var surnameLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.accountName.apply(to: label)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = L10n.name

        return label
    }()

    private lazy var surnameView: UIView = {
        let view = UIView()
        view.backgroundColor = AppAsset.background.color

        let label = UILabel()
        LabelStyle.accountNameValue.apply(to: label)
        label.numberOfLines = 0

        view.addSubview(label)
        label.centerYAnchor /==/ view.centerYAnchor
        label.leadingAnchor /==/ view.leadingAnchor + 15

        return view
    }()

    private lazy var emailLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.accountName.apply(to: label)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = L10n.name

        return label
    }()

    private lazy var emailView: UIView = {
        let view = UIView()
        view.backgroundColor = AppAsset.background.color

        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.emailOff.image
        imgView.contentMode = .scaleAspectFit

        let label = UILabel()
        LabelStyle.accountNameValue.apply(to: label)
        label.numberOfLines = 0

        view.addSubview(imgView)
        view.addSubview(label)

        imgView.widthAnchor /==/ 36
        imgView.heightAnchor /==/ imgView.widthAnchor
        imgView.centerYAnchor /==/ view.centerYAnchor
        imgView.leadingAnchor /==/ view.leadingAnchor + 15

        label.centerYAnchor /==/ view.centerYAnchor
        label.leadingAnchor /==/ imgView.trailingAnchor + 10

        return view
    }()

    private lazy var saveBtn: UIButton = {
        var button = UIButton(frame: .zero)
        ButtonStyle.secondaryButton.apply(to: button)
        button.setTitle(L10n.profileSave, for: .normal)
        button.hero.id = Constants.HeroTransitionsID.welcomeContinueButton
        button.addTarget(self, action: #selector(saveDidTap), for: .touchUpInside)

        return button
    }()

    private lazy var logoutBtn: UIButton = {
        var button = UIButton(frame: .zero)
        ButtonStyle.dangerReverseButton.apply(to: button)
        button.setTitle(L10n.profileLogout, for: .normal)
        button.hero.id = Constants.HeroTransitionsID.welcomeContinueButton
        button.addTarget(self, action: #selector(logoutDidTap), for: .touchUpInside)

        return button
    }()

    var account: Account? { didSet { didSetAccount() }}

    init() {
        super.init(height: 625)

        configureUI()
        configureConstraints()
    }

    override func configureUI() {
        super.configureUI()

        backgroundColor = .white

        addSubview(pullView)
        addSubview(userImgView)
        addSubview(titleLbl)
        addSubview(subTitleLbl)
        addSubview(nameLbl)
        addSubview(nameView)
        addSubview(surnameLbl)
        addSubview(surnameView)
        addSubview(emailLbl)
        addSubview(emailView)
        addSubview(saveBtn)
        addSubview(logoutBtn)
    }

    override func configureConstraints() {
        super.configureConstraints()

        pullView.topAnchor /==/ topAnchor + 10
        pullView.centerXAnchor /==/ centerXAnchor
        pullView.heightAnchor /==/ 5
        pullView.widthAnchor /==/ 55

        userImgView.topAnchor /==/ pullView.bottomAnchor + 20
        userImgView.centerXAnchor /==/ centerXAnchor
        userImgView.widthAnchor /==/ 90
        userImgView.heightAnchor /==/ userImgView.heightAnchor

        titleLbl.topAnchor /==/ userImgView.bottomAnchor + 5
        titleLbl.centerXAnchor /==/ centerXAnchor
        titleLbl.leadingAnchor /==/ leadingAnchor + 25
        titleLbl.trailingAnchor /==/ trailingAnchor - 25

        subTitleLbl.topAnchor /==/ titleLbl.bottomAnchor + 5
        subTitleLbl.centerXAnchor /==/ centerXAnchor
        subTitleLbl.leadingAnchor /==/ leadingAnchor + 25
        subTitleLbl.trailingAnchor /==/ trailingAnchor - 25

        nameLbl.topAnchor /==/ subTitleLbl.bottomAnchor + 15
        nameLbl.leadingAnchor /==/ leadingAnchor + 20

        nameView.topAnchor /==/ nameLbl.bottomAnchor + 5
        nameView.leadingAnchor /==/ nameLbl.leadingAnchor
        nameView.trailingAnchor /==/ trailingAnchor - 20
        nameView.heightAnchor /==/ 54

        surnameLbl.topAnchor /==/ nameView.bottomAnchor + 10
        surnameLbl.leadingAnchor /==/ leadingAnchor + 20

        surnameView.topAnchor /==/ surnameLbl.bottomAnchor + 5
        surnameView.leadingAnchor /==/ surnameLbl.leadingAnchor
        surnameView.trailingAnchor /==/ trailingAnchor - 20
        surnameView.heightAnchor /==/ 54

        emailLbl.topAnchor /==/ surnameView.bottomAnchor + 10
        emailLbl.leadingAnchor /==/ leadingAnchor + 20

        emailView.topAnchor /==/ emailLbl.bottomAnchor + 5
        emailView.leadingAnchor /==/ emailLbl.leadingAnchor
        emailView.trailingAnchor /==/ trailingAnchor - 20
        emailView.heightAnchor /==/ 54

        logoutBtn.topAnchor /==/ emailView.bottomAnchor + 25
        logoutBtn.leftAnchor /==/ leftAnchor + 32
        logoutBtn.rightAnchor /==/ rightAnchor - 32
        logoutBtn.heightAnchor /==/ 55
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        roundCorners(corners: [.topLeft, .topRight], radius: 30)

        userImgView.layer.cornerRadius = userImgView.bounds.width / 2
        nameView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
        surnameView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
        emailView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
    }

    @objc func saveDidTap() {
        saveBtn.tapAnimation {
            self.saveBtnTap?()
        }
    }

    @objc func logoutDidTap() {
        logoutBtn.tapAnimation {
            self.logoutBtnTap?()
        }
    }

    private func didSetAccount() {
        guard let account = account else { return }

        (nameView.subviews[0] as! UILabel).text = account.name
        (surnameView.subviews[0] as! UILabel).text = account.surname
        (emailView.subviews[1] as! UILabel).text = account.email
    }

    @objc func userImgDidTap(tapGestureRecognizer _: UITapGestureRecognizer) {
        userImgView.tapAnimation {
            GalleryHelper.checkGalleryPermission { authorized in
                authorized ? self.userImgTap?() : nil
            }
        }
    }
}
