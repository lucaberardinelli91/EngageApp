//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Foundation
import UIKit

class WalletButton: BaseView {
    private lazy var btnView: UIView = {
        let view = UIView()
        view.backgroundColor = AppAsset.walletBackButton.color
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(recognizer:)))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)

        return view
    }()

    private lazy var imgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.walletButton.image
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()

    private lazy var coinsLbl: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        LabelStyle.coinsButton.apply(to: label)
        label.numberOfLines = 0
        label.text = "5.700"

        return label
    }()

    var btnTapped: (() -> Void)?
    var coins: String? { didSet { didSetCoins() }}

    override func configureUI() {
        super.configureUI()

        btnView.addSubview(imgView)
        btnView.addSubview(coinsLbl)
        addSubview(btnView)
    }

    override func configureConstraints() {
        super.configureConstraints()

        btnView.edgeAnchors /==/ edgeAnchors

        imgView.heightAnchor /==/ 39
        imgView.widthAnchor /==/ imgView.heightAnchor
        imgView.centerYAnchor /==/ btnView.centerYAnchor
        imgView.leadingAnchor /==/ btnView.leadingAnchor + 5

        coinsLbl.centerYAnchor /==/ btnView.centerYAnchor
        coinsLbl.leadingAnchor /==/ imgView.trailingAnchor + 8
        coinsLbl.trailingAnchor /==/ trailingAnchor - 10
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        btnView.clipsToBounds = true
        btnView.layer.cornerRadius = 22
    }

    private func didSetCoins() {
        coinsLbl.text = "5.700"
//        guard let coins = coins else { return }
//        coinsLbl.text = coins.formatValue()
    }

    @objc func handleTapGesture(recognizer _: UIPanGestureRecognizer) {
        btnView.tapAnimation {
            self.btnTapped?()
        }
    }
}
