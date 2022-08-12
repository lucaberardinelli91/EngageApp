//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public class CoinsView: BaseView {
    private lazy var horizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()

    private lazy var verticalView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()

    private lazy var bodyContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()

    private lazy var bodyView: UIView = {
        let view = UIView()
        view.backgroundColor = AppAsset.walletBackButton.color.withAlphaComponent(0.5)

        return view
    }()

    private lazy var coinsLbl: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        LabelStyle.missionCoins.apply(to: label)
        label.textAlignment = .left
        label.numberOfLines = 0

        return label
    }()

    private lazy var walletImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.walletButtonSmall.image
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()

    var coins: String? { didSet { didSetCoins() }}

    override public func configureUI() {
        super.configureUI()

        backgroundColor = AppAsset.walletBackButton.color.withAlphaComponent(0.5)

        addSubview(horizontalView)
        addSubview(verticalView)

        bodyView.addSubview(coinsLbl)
        bodyView.addSubview(walletImgView)
        bodyContainerView.addSubview(bodyView)
        addSubview(bodyContainerView)
    }

    override public func configureConstraints() {
        super.configureConstraints()

        horizontalView.widthAnchor /==/ widthAnchor
        horizontalView.topAnchor /==/ topAnchor
        horizontalView.heightAnchor /==/ 15

        verticalView.widthAnchor /==/ 15
        verticalView.heightAnchor /==/ heightAnchor
        verticalView.leadingAnchor /==/ leadingAnchor

        bodyContainerView.trailingAnchor /==/ trailingAnchor
        bodyContainerView.bottomAnchor /==/ bottomAnchor
        bodyContainerView.topAnchor /==/ horizontalView.bottomAnchor
        bodyContainerView.leadingAnchor /==/ verticalView.trailingAnchor

        bodyView.edgeAnchors /==/ bodyContainerView.edgeAnchors

        coinsLbl.centerYAnchor /==/ bodyView.centerYAnchor
        coinsLbl.trailingAnchor /==/ walletImgView.leadingAnchor - 5

        walletImgView.trailingAnchor /==/ bodyView.trailingAnchor - 6
        walletImgView.centerYAnchor /==/ coinsLbl.centerYAnchor
        walletImgView.widthAnchor /==/ 18
        walletImgView.heightAnchor /==/ walletImgView.widthAnchor
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        horizontalView.layer.cornerRadius = 11
        horizontalView.layer.maskedCorners = [.layerMaxXMaxYCorner]

        verticalView.layer.cornerRadius = 11
        verticalView.layer.maskedCorners = [.layerMaxXMaxYCorner]

        bodyView.layer.cornerRadius = 13
        bodyView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]

        roundCorners(corners: [.bottomRight], radius: 11)
    }

    private func didSetCoins() {
        coinsLbl.text = "5.700"
//        guard let coins = coins else { return }
//        coinsLbl.text = "+\(coins.formatValue())"
    }
}
