//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

struct HeaderCollection {
    let title: String?
    let subTitle: String?
    let coins: String?
}

class HeaderView: BaseView {
    var closeTap: (() -> Void)?
    var walletTap: (() -> Void)?

    private lazy var headerView: UIView = {
        let view = UIView()

        return view
    }()

    private lazy var walletBtn: WalletButton = {
        let wallet = WalletButton()
        wallet.btnTapped = walletBtnTapped

        return wallet
    }()

    private lazy var titleLbl: UILabel = {
        var label = UILabel()
        LabelStyle.headerListTitle.apply(to: label)
        label.numberOfLines = 0

        return label
    }()

    private lazy var closeBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.setImage(AppAsset.headerClose.image, for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true

        return button
    }()

    lazy var subHeaderView: UIView = {
        let view = UIView()

        var label = UILabel()
        LabelStyle.listHeaderSubTitle.apply(to: label)
        label.numberOfLines = 0
        label.textAlignment = .center

        view.addSubview(label)

        label.leadingAnchor /==/ view.leadingAnchor + 74
        label.trailingAnchor /==/ view.trailingAnchor - 74
        label.bottomAnchor /==/ view.bottomAnchor - 13
        label.widthAnchor /==/ 200

        return view
    }()

    var header: HeaderCollection? { didSet { didSetHeader() }}
    var colorsHeader: (UIColor, UIColor)?

    override public func configureUI() {
        super.configureUI()

        headerView.addSubview(walletBtn)
        headerView.addSubview(titleLbl)
        headerView.addSubview(closeBtn)

        addSubview(headerView)
        addSubview(subHeaderView)
    }

    override public func configureConstraints() {
        super.configureConstraints()

        headerView.topAnchor /==/ topAnchor
        headerView.widthAnchor /==/ widthAnchor
        headerView.heightAnchor /==/ 125

        walletBtn.topAnchor /==/ topAnchor + 54
        walletBtn.leadingAnchor /==/ headerView.leadingAnchor + 20
        walletBtn.heightAnchor /==/ 45

        titleLbl.centerYAnchor /==/ walletBtn.centerYAnchor
        titleLbl.centerXAnchor /==/ headerView.centerXAnchor

        closeBtn.widthAnchor /==/ 45
        closeBtn.heightAnchor /==/ closeBtn.widthAnchor
        closeBtn.topAnchor /==/ walletBtn.topAnchor
        closeBtn.trailingAnchor /==/ headerView.trailingAnchor - 20

        subHeaderView.topAnchor /==/ headerView.bottomAnchor
        subHeaderView.widthAnchor /==/ widthAnchor
        subHeaderView.heightAnchor /==/ 50
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
        subHeaderView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)

        guard let colorsHeader = colorsHeader else { return }

        headerView.setGradientBackground(locations: [0.0, 1.0], colorTop: colorsHeader.0, colorBottom: colorsHeader.1)

        subHeaderView.setGradientBackground(locations: [0.0, 1.0], colorTop: colorsHeader.1, colorBottom: colorsHeader.1)
    }

    private func didSetHeader() {
        guard let header = header else { return }

        walletBtn.coins = "5.700"
//        walletBtn.coins = header.coins
        titleLbl.text = header.title
        (subHeaderView.subviews[0] as! UILabel).text = header.subTitle
    }

    @objc func closeButtonDidTap() {
        closeBtn.tapAnimation {
            self.closeTap?()
        }
    }
}

extension HeaderView {
    @objc func walletBtnTapped() {
        walletBtn.tapAnimation {
            self.walletTap?()
        }
    }
}
