//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit

public class RewardCoinsView: BaseView {
    private lazy var coinsView: UIView = {
        let view = UIView()

        return view
    }()

    private lazy var coinsImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.walletButton.image
        imgView.contentMode = .scaleAspectFill

        return imgView
    }()

    private lazy var coinsLbl: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()

    var coins: String? { didSet { didSetCoins() }}
    var inCatalog: Bool? { didSet { didSetInCatalog() }}

    override public func configureUI() {
        super.configureUI()

        coinsView.addSubview(coinsImgView)
        coinsView.addSubview(coinsLbl)

        addSubview(coinsView)
    }

    override public func configureConstraints() {
        super.configureConstraints()

        coinsView.edgeAnchors /==/ edgeAnchors

        coinsImgView.widthAnchor /==/ 20
        coinsImgView.heightAnchor /==/ coinsImgView.widthAnchor
        coinsImgView.centerYAnchor /==/ coinsView.centerYAnchor
        coinsImgView.trailingAnchor /==/ coinsView.trailingAnchor - 10

        coinsLbl.centerYAnchor /==/ coinsImgView.centerYAnchor
        coinsLbl.trailingAnchor /==/ coinsImgView.leadingAnchor - 5
        coinsLbl.leadingAnchor /==/ coinsView.leadingAnchor + 10
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        coinsView.setGradientBackground(startPoint: CGPoint(x: 0.0, y: 0.5), endPoint: CGPoint(x: 0.5, y: 0.0), startColor: AppAsset.walletBackButton.color.withAlphaComponent(0.5), endColor: AppAsset.walletBackEndButton.color.withAlphaComponent(0.5))
    }

    private func didSetCoins() {
        coinsLbl.text = "5.700"
//        guard let coins = coins else { return }
//        coinsLbl.text = coins
    }

    private func didSetInCatalog() {
        guard let inCatalog = inCatalog else { return }

        inCatalog ? LabelStyle.rewardBaseCoinView.apply(to: coinsLbl) : LabelStyle.rewardPrimaryCoinView.apply(to: coinsLbl)
    }
}
