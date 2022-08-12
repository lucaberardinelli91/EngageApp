//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit

public class WalletViewBS: BottomSheet, UICollectionViewDelegate {
    @objc var earnCoinsTap: (() -> Void)?

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

    private lazy var imgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.walletButton.image
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()

    private lazy var coinsLbl: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        LabelStyle.coinsWallet.apply(to: label)
        label.numberOfLines = 0

        return label
    }()

    private lazy var subTitleLbl: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        LabelStyle.coinsWalletSubTitle.apply(to: label)
        label.text = "Oh, I've been so worried about you ever since your ran off the other"
        label.numberOfLines = 0

        return label
    }()

    private lazy var earnCoinsBtn: UIButton = {
        var button = UIButton(frame: .zero)
        ButtonStyle.secondaryButton.apply(to: button)
        button.setTitle(L10n.launcherEarnMoreCoins, for: .normal)
        button.hero.id = Constants.HeroTransitionsID.welcomeContinueButton
        button.addTarget(self, action: #selector(earnCoinsDidTap), for: .touchUpInside)

        return button
    }()

    lazy var walletCollView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(TransactionCell.self)

        return collectionView
    }()

    var coins: String? { didSet { didSetCoins() }}

    init() {
        super.init(height: UIScreen.main.bounds.height * 0.75)

        configureUI()
        configureConstraints()
    }

    override func configureUI() {
        super.configureUI()

        backgroundColor = .white

        addSubview(pullView)
        addSubview(coinsLbl)
        addSubview(imgView)
        addSubview(subTitleLbl)
        addSubview(walletCollView)
        addSubview(earnCoinsBtn)

        walletCollView.delegate = self
        walletCollView.setCollectionViewLayout(makeLayout(), animated: false)
    }

    override func configureConstraints() {
        super.configureConstraints()

        pullView.topAnchor /==/ topAnchor + 10
        pullView.centerXAnchor /==/ centerXAnchor
        pullView.heightAnchor /==/ 5
        pullView.widthAnchor /==/ 55

        coinsLbl.topAnchor /==/ pullView.bottomAnchor + 20
        coinsLbl.centerXAnchor /==/ centerXAnchor - 15

        imgView.centerYAnchor /==/ coinsLbl.centerYAnchor
        imgView.leadingAnchor /==/ coinsLbl.trailingAnchor + 10
        imgView.heightAnchor /==/ 33
        imgView.widthAnchor /==/ imgView.heightAnchor

        subTitleLbl.topAnchor /==/ coinsLbl.bottomAnchor + 10
        subTitleLbl.leadingAnchor /==/ leadingAnchor + 47
        subTitleLbl.trailingAnchor /==/ trailingAnchor - 47

        walletCollView.topAnchor /==/ subTitleLbl.bottomAnchor + 10
        walletCollView.leadingAnchor /==/ leadingAnchor
        walletCollView.trailingAnchor /==/ trailingAnchor
        walletCollView.bottomAnchor /==/ bottomAnchor - 10

        earnCoinsBtn.leftAnchor /==/ leftAnchor + 55
        earnCoinsBtn.rightAnchor /==/ rightAnchor - 55
        earnCoinsBtn.bottomAnchor /==/ bottomAnchor - 50
        earnCoinsBtn.heightAnchor /==/ 55
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }

    private func didSetCoins() {
        coinsLbl.text = "5.700"
//        guard let coins = coins else { return }
//        coinsLbl.text = coins
    }

    @objc func earnCoinsDidTap() {
        earnCoinsBtn.tapAnimation {
            self.earnCoinsTap?()
        }
    }
}

extension WalletViewBS {
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (_: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(120)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 10)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

            return section
        }

        return layout
    }
}
