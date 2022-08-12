//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public struct LauncherInfo {
    let id: String?
    let cta: String?
    let title: String?
    let subTitle: String?
    let text: String?
    let coins: String?
}

public class ReadInfoView: BaseView {
    var markAsReadTap = PassthroughSubject<Void, Never>()
    var closeTap = PassthroughSubject<Void, Never>()

    var info: LauncherInfo? { didSet { didSetInfo() }}

    private var closeBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.setImage(AppAsset.close.image, for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true

        return button
    }()

    private lazy var titleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.launcherInfoTitle.apply(to: label)
        label.text = L10n.missionReadInfo
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()

    private lazy var subTitleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        LabelStyle.launcherInfoSubTitle.apply(to: label)
        label.numberOfLines = 0
        label.textAlignment = .left

        return label
    }()

    private lazy var textScrollView: UIScrollView = {
        var scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false

        return scrollView
    }()

    private lazy var textLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .left

        return label
    }()

    private lazy var markAsReadBtn: UIButton = {
        var button = UIButton(frame: .zero)
        ButtonStyle.coinsButton.apply(to: button)
        button.hero.id = Constants.HeroTransitionsID.welcomeContinueButton
        button.addTarget(self, action: #selector(markAsReadDidTap), for: .touchUpInside)

        return button
    }()

    override func configureUI() {
        super.configureUI()

        backgroundColor = .white

        addSubview(closeBtn)
        addSubview(titleLbl)
        addSubview(subTitleLbl)
        textScrollView.addSubview(textLbl)
        addSubview(textScrollView)
    }

    override func configureConstraints() {
        super.configureConstraints()

        closeBtn.topAnchor /==/ topAnchor + 55
        closeBtn.trailingAnchor /==/ trailingAnchor - 30
        closeBtn.widthAnchor /==/ 45
        closeBtn.heightAnchor /==/ 45

        titleLbl.centerYAnchor /==/ closeBtn.centerYAnchor
        titleLbl.leftAnchor /==/ leftAnchor + 30
        titleLbl.rightAnchor /==/ closeBtn.rightAnchor - 30

        subTitleLbl.topAnchor /==/ titleLbl.bottomAnchor + 20
        subTitleLbl.leftAnchor /==/ leftAnchor + 30
        subTitleLbl.rightAnchor /==/ rightAnchor - 50

        textScrollView.topAnchor /==/ subTitleLbl.bottomAnchor + 20
        textScrollView.leftAnchor /==/ subTitleLbl.leftAnchor
        textScrollView.rightAnchor /==/ subTitleLbl.rightAnchor
        textScrollView.bottomAnchor /==/ bottomAnchor

        textLbl.topAnchor /==/ textScrollView.topAnchor
        textLbl.widthAnchor /==/ textScrollView.widthAnchor
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        if textScrollView.contentSize.height != 0, textScrollView.contentSize.height < UIScreen.main.bounds.height {
            addSubview(markAsReadBtn)

            markAsReadBtn.bottomAnchor /==/ bottomAnchor - 40
            markAsReadBtn.widthAnchor /==/ 270
            markAsReadBtn.centerXAnchor /==/ centerXAnchor
            markAsReadBtn.heightAnchor /==/ 55

        } else {
            textScrollView.addSubview(markAsReadBtn)

            textLbl.bottomAnchor /==/ markAsReadBtn.topAnchor - 20

            markAsReadBtn.bottomAnchor /==/ textScrollView.bottomAnchor - 40
            markAsReadBtn.widthAnchor /==/ 270
            markAsReadBtn.centerXAnchor /==/ centerXAnchor
            markAsReadBtn.heightAnchor /==/ 55
        }
    }

    private func didSetInfo() {
        guard let info = info else { return }

        subTitleLbl.text = info.subTitle
        textLbl.text = info.text
        markAsReadBtn.setTitle(info.cta, for: .normal)
    }

    @objc func markAsReadDidTap() {
        markAsReadBtn.tapAnimation {
            self.markAsReadTap.send()
        }
    }

    @objc func closeButtonDidTap() {
        closeBtn.tapAnimation {
            self.closeTap.send()
        }
    }
}
