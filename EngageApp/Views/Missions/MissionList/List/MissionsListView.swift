//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public enum ScrollDirection {
    case up
    case down
}

public class MissionsListView: BaseView, UICollectionViewDelegate {
    var missionDidTap = PassthroughSubject<IndexPath, Never>()
    var collectionViewScroll = PassthroughSubject<ScrollDirection, Never>()
    var closeTap = PassthroughSubject<Void, Never>()
    var walletTap = PassthroughSubject<Void, Never>()
    var coins: Int? { didSet { didSetCoins() }}
    var viewConstraintHeight: NSLayoutConstraint?

    private lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.closeTap = closeDidTap
        view.walletTap = walletDidTap

        return view
    }()

    let missionsCollView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.backgroundColor = AppAsset.background.color
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.bounces = true
        collectionView.register(MissionCell.self)

        return collectionView
    }()

    var isHeaderHidden: Bool? { didSet { didSetIsHeaderHidden() }}
    var numMissions: Int? { didSet { didSetNumMissions() }}

    override func configureUI() {
        super.configureUI()

        backgroundColor = AppAsset.background.color
    }

    override func configureConstraints() {
        super.configureConstraints()
    }

    private func didSetIsHeaderHidden() {
        guard let isHeaderHidden = isHeaderHidden else { return }

        missionsCollView.delegate = self
        missionsCollView.setCollectionViewLayout(makeLayout(), animated: false)

        if isHeaderHidden {
            headerView.removeFromSuperview()
            addSubview(missionsCollView)

            missionsCollView.widthAnchor /==/ widthAnchor
            missionsCollView.topAnchor /==/ topAnchor
            missionsCollView.bottomAnchor /==/ bottomAnchor
        } else {
            addSubview(headerView)
            addSubview(missionsCollView)

            headerView.colorsHeader = (ThemeManager.currentTheme().primaryColor, ThemeManager.currentTheme().secondaryColor)

            headerView.topAnchor /==/ topAnchor
            headerView.widthAnchor /==/ widthAnchor
            headerView.heightAnchor /==/ 175

            missionsCollView.widthAnchor /==/ widthAnchor
            missionsCollView.topAnchor /==/ headerView.bottomAnchor + 10
        }
    }

    private func didSetCoins() {
        guard let coins = coins else { return }
        headerView.header = HeaderCollection(title: L10n.missions,
                                             subTitle: L10n.homeMissionsGoal,
                                             coins: "\(self.coins ?? 0)")
    }

    private func didSetNumMissions() {
        guard let numMissions = numMissions else { return }
        numMissions > 1 ? missionsCollView.bottomAnchor /==/ bottomAnchor : nil
    }

    func closeDidTap() {
        closeTap.send()
    }

    func walletDidTap() {
        walletTap.send()
    }
}

extension MissionsListView {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = collectionView.cellForItem(at: indexPath)
        item?.tapAnimation { [self] in
            self.missionDidTap.send(indexPath)
        }
    }

    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (_: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(120)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 10)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

            section.visibleItemsInvalidationHandler = { _, _, _ in
                if self.missionsCollView.panGestureRecognizer.translation(in: self).y >= 0 {
                    self.collectionViewScroll.send(.up)
                } else {
                    self.collectionViewScroll.send(.down)
                }
            }
            return section
        }
        return layout
    }

    func scrollByView(direction: ScrollDirection) {
        DispatchQueue.main.async {
            if direction == .up {
                self.showSubHeader(view: self.headerView.subHeaderView)
            } else if direction == .down {
                self.hideSubHeader(view: self.headerView.subHeaderView)
            }
        }
    }

    func hideSubHeader(view: UIView) {
        UIView.animate(withDuration: 0.5, animations: {
            self.updateHeaderHeight(125)
            view.alpha = 0
        }) { _ in
            view.isHidden = true
        }
    }

    func showSubHeader(view: UIView) {
        UIView.animate(withDuration: 0.1, animations: {
            self.updateHeaderHeight(175)
            view.alpha = 1
        }) { _ in
            view.isHidden = false
        }
    }

    func updateHeaderHeight(_ height: Int) {
        headerView.constraints.forEach { c in
            if c == self.viewConstraintHeight {
                self.headerView.removeConstraint(c)
            }
        }
        headerView.heightAnchor /==/ CGFloat(height)
        viewConstraintHeight = headerView.constraintHeight
        headerView.layoutIfNeeded()
        headerView.updateConstraints()
        headerView.updateConstraintsIfNeeded()
        headerView.setNeedsUpdateConstraints()
    }
}

extension UIView {
    var constraintHeight: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
}
