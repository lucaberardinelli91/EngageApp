//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import Foundation
import UIKit

public class HelpView: BaseView {
    var closeTap = PassthroughSubject<Void, Never>()
    var goToWebTap = PassthroughSubject<Void, Never>()
    var tosTap = PassthroughSubject<Void, Never>()
    var phoneTap = PassthroughSubject<Void, Never>()
    var emailTap = PassthroughSubject<Void, Never>()

    private lazy var foreImgView: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.image = AppAsset.userBackHelp.image

        return imageView
    }()

    private lazy var titleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .center
        LabelStyle.help.apply(to: label)
        label.text = L10n.help

        return label
    }()

    private var closeBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.setImage(AppAsset.closeHelp.image, for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)

        return button
    }()

    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        let title = UILabel()
        title.numberOfLines = 0
        title.textAlignment = .center
        title.text = L10n.helpTitle
        LabelStyle.helpTitle.apply(to: title)

        let subTitle = UILabel()
        subTitle.numberOfLines = 0
        subTitle.textAlignment = .center
        subTitle.text = L10n.helpSubTitle
        LabelStyle.helpSubTitle.apply(to: subTitle)

        var brand = UIImageView(frame: .zero)
        brand.contentMode = .scaleAspectFill
        brand.image = AppAsset.brandNameColor.image

        var button = UIButton(frame: .zero)
        ButtonStyle.secondaryButton.apply(to: button)
        button.setTitle(L10n.helpGoToWeb, for: .normal)
        button.hero.id = Constants.HeroTransitionsID.welcomeContinueButton
        button.addTarget(self, action: #selector(goToWebDidTap), for: .touchUpInside)

        view.addSubview(title)
        view.addSubview(subTitle)
        view.addSubview(brand)
        view.addSubview(button)

        title.topAnchor /==/ view.topAnchor + 46
        title.centerXAnchor /==/ view.centerXAnchor
        title.widthAnchor /==/ 260

        subTitle.topAnchor /==/ title.bottomAnchor + 20
        subTitle.centerXAnchor /==/ view.centerXAnchor
        subTitle.widthAnchor /==/ 270

        brand.topAnchor /==/ subTitle.bottomAnchor + 40
        brand.centerXAnchor /==/ view.centerXAnchor

        button.topAnchor /==/ brand.bottomAnchor + 30
        button.leftAnchor /==/ view.leftAnchor + 32
        button.rightAnchor /==/ view.rightAnchor - 32
        button.bottomAnchor /==/ view.bottomAnchor - 20
        button.heightAnchor /==/ 55

        return view
    }()

    private lazy var tosView: UIView = {
        let view = UIView()

        var imgView = UIImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFill
        imgView.image = AppAsset.tosHelp.image

        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = L10n.helpToS
        LabelStyle.helpTos.apply(to: label)

        view.addSubview(imgView)
        view.addSubview(label)

        imgView.centerYAnchor /==/ view.centerYAnchor
        imgView.leadingAnchor /==/ view.leadingAnchor

        label.centerYAnchor /==/ imgView.centerYAnchor
        label.leadingAnchor /==/ imgView.trailingAnchor + 10
        label.trailingAnchor /==/ view.trailingAnchor

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tosDidTap(recognizer:)))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)

        return view
    }()

    private lazy var problemsLbl: UIView = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = L10n.helpProblems
        LabelStyle.helpProblems.apply(to: label)

        return label
    }()

    private lazy var phoneView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.gray.cgColor

        var imgView = UIImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFill
        imgView.image = AppAsset.phoneHelp.image

        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = L10n.helpPhone
        LabelStyle.helpPhone.apply(to: label)

        view.addSubview(imgView)
        view.addSubview(label)

        imgView.centerYAnchor /==/ view.centerYAnchor
        imgView.leadingAnchor /==/ view.leadingAnchor + 15

        label.centerYAnchor /==/ imgView.centerYAnchor
        label.centerXAnchor /==/ view.centerXAnchor

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(phoneDidTap(recognizer:)))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)

        return view
    }()

    private lazy var emailView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.gray.cgColor

        var imgView = UIImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFill
        imgView.image = AppAsset.emailHelp.image

        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = L10n.helpEmail
        LabelStyle.helpPhone.apply(to: label)

        view.addSubview(imgView)
        view.addSubview(label)

        imgView.centerYAnchor /==/ view.centerYAnchor
        imgView.leadingAnchor /==/ view.leadingAnchor + 15

        label.centerYAnchor /==/ imgView.centerYAnchor
        label.centerXAnchor /==/ view.centerXAnchor

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(emailDidTap(recognizer:)))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)

        return view
    }()

    override func configureUI() {
        super.configureUI()

        backgroundColor = AppAsset.background.color

        addSubview(foreImgView)
        addSubview(titleLbl)
        addSubview(closeBtn)
        addSubview(headerView)
        addSubview(tosView)
        addSubview(problemsLbl)
        addSubview(phoneView)
        addSubview(emailView)
    }

    override func configureConstraints() {
        foreImgView.centerXAnchor /==/ centerXAnchor
        foreImgView.widthAnchor /==/ widthAnchor
        foreImgView.heightAnchor /==/ 300

        titleLbl.centerXAnchor /==/ centerXAnchor
        titleLbl.topAnchor /==/ topAnchor + 60

        closeBtn.centerYAnchor /==/ titleLbl.centerYAnchor
        closeBtn.trailingAnchor /==/ trailingAnchor - 20

        headerView.topAnchor /==/ titleLbl.bottomAnchor + 30
        headerView.leadingAnchor /==/ leadingAnchor + 20
        headerView.trailingAnchor /==/ trailingAnchor - 20
        headerView.widthAnchor /==/ 335
        headerView.heightAnchor /==/ 360

        tosView.topAnchor /==/ headerView.bottomAnchor + 20
        tosView.heightAnchor /==/ 50
        tosView.centerXAnchor /==/ centerXAnchor

        problemsLbl.centerXAnchor /==/ centerXAnchor

        phoneView.topAnchor /==/ problemsLbl.bottomAnchor + 15
        phoneView.heightAnchor /==/ 50
        phoneView.leadingAnchor /==/ leadingAnchor + 35
        phoneView.trailingAnchor /==/ trailingAnchor - 35
        phoneView.centerXAnchor /==/ centerXAnchor

        emailView.topAnchor /==/ phoneView.bottomAnchor + 20
        emailView.heightAnchor /==/ 50
        emailView.leadingAnchor /==/ leadingAnchor + 35
        emailView.trailingAnchor /==/ trailingAnchor - 35
        emailView.centerXAnchor /==/ centerXAnchor
        emailView.bottomAnchor /==/ bottomAnchor - 42
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        roundCorners(corners: [.topLeft, .topRight], radius: 30)
        headerView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 30)

        phoneView.layer.cornerRadius = 25
        emailView.layer.cornerRadius = 25
    }

    @objc func closeButtonDidTap() {
        closeBtn.tapAnimation {
            self.closeTap.send()
        }
    }

    @objc func goToWebDidTap() {
        let button = (headerView.subviews[3] as! UIButton)
        button.tapAnimation {
            self.goToWebTap.send()
        }
    }

    @objc func tosDidTap(recognizer _: UIPanGestureRecognizer) {
        tosView.tapAnimation { [self] in
            tosTap.send()
        }
    }

    @objc func phoneDidTap(recognizer _: UIPanGestureRecognizer) {
        phoneView.tapAnimation { [self] in
            phoneTap.send()
        }
    }

    @objc func emailDidTap(recognizer _: UIPanGestureRecognizer) {
        emailView.tapAnimation { [self] in
            emailTap.send()
        }
    }
}
