//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public class CatalogView: BaseView, UICollectionViewDelegate {
    var closeTap = PassthroughSubject<Void, Never>()
    var rewardDidTap = PassthroughSubject<IndexPath, Never>()
    var walletTap = PassthroughSubject<Void, Never>()
    var coins: Int? { didSet { didSetCoins() }}

    private lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.closeTap = closeDidTap
        view.walletTap = walletDidTap

        return view
    }()

    lazy var catalogCollView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.backgroundColor = AppAsset.background.color
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RewardCell.self)

        return collectionView
    }()

    var inHome: Bool? { didSet { didSetIsHeaderHidden() }}

    override func configureUI() {
        super.configureUI()

        backgroundColor = AppAsset.background.color

        catalogCollView.delegate = self
    }

    override func configureConstraints() {
        super.configureConstraints()
    }

    private func didSetIsHeaderHidden() {
        guard let isHome = inHome else { return }

        if isHome {
            catalogCollView.setCollectionViewLayout(makeLayoutHorizontal(), animated: false)

            addSubview(catalogCollView)

            catalogCollView.widthAnchor /==/ widthAnchor
            catalogCollView.topAnchor /==/ topAnchor
            catalogCollView.bottomAnchor /==/ bottomAnchor
        } else {
            catalogCollView.setCollectionViewLayout(makeLayoutVertical(), animated: false)

            addSubview(headerView)
            addSubview(catalogCollView)

            headerView.colorsHeader = (ThemeManager.currentTheme().tertiaryColor, AppAsset.brandTertiaryGradient.color)

            headerView.topAnchor /==/ topAnchor
            headerView.widthAnchor /==/ widthAnchor
            headerView.heightAnchor /==/ 175

            catalogCollView.widthAnchor /==/ widthAnchor
            catalogCollView.topAnchor /==/ headerView.bottomAnchor
            catalogCollView.bottomAnchor /==/ bottomAnchor
        }
    }

    private func didSetCoins() {
        guard let coins = coins else { return }
        headerView.header = HeaderCollection(title: L10n.catalog,
                                             subTitle: L10n.homeCatalogGoal,
                                             coins: "\(self.coins ?? 0)")
    }

    func closeDidTap() {
        closeTap.send()
    }

    func walletDidTap() {
        walletTap.send()
    }
}

extension CatalogView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (catalogCollView.frame.size.width - space) / 2.0

        guard let inHome = inHome else { return CGSize(width: size, height: size + 30) }
        return inHome ? CGSize(width: size + 10, height: size + 30) : CGSize(width: size, height: size + 70)
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 50
    }

    func makeLayoutVertical() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 15, left: 10, bottom: 20, right: 10)
        layout.scrollDirection = .vertical

        return layout
    }

    func makeLayoutHorizontal() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 25)
        layout.scrollDirection = .horizontal

        return layout
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = collectionView.cellForItem(at: indexPath)
        item?.tapAnimation { [self] in
            self.rewardDidTap.send(indexPath)
        }
    }
}
