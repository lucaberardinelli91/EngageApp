//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public class NotificationsView: BaseView, UICollectionViewDelegate {
    var notificationDidTap = PassthroughSubject<IndexPath, Never>()

    lazy var notificationsCollView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.backgroundColor = AppAsset.background.color
        collectionView.bounces = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(NotificationCell.self)
        collectionView.register(PageControlView.self, forSupplementaryViewOfKind: HomeElementKind.sectionFooter, withReuseIdentifier: HomeElementKind.sectionFooter)

        return collectionView
    }()

    override func configureUI() {
        super.configureUI()

        backgroundColor = .green

        addSubview(notificationsCollView)
        notificationsCollView.setCollectionViewLayout(makeLayout(), animated: false)

        heightAnchor /==/ 260 // 300

        notificationsCollView.delegate = self
    }

    override func configureConstraints() {
        super.configureConstraints()

        notificationsCollView.widthAnchor /==/ widthAnchor
        notificationsCollView.heightAnchor /==/ 250
        notificationsCollView.topAnchor /==/ topAnchor
        notificationsCollView.bottomAnchor /==/ bottomAnchor
    }
}

extension NotificationsView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = collectionView.cellForItem(at: indexPath)
        item?.tapAnimation { [self] in
            self.notificationDidTap.send(indexPath)
        }
    }

    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (_: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(250)))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(250))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            section.orthogonalScrollingBehavior = .groupPagingCentered

            section.boundarySupplementaryItems = [self.buildPageControlFooter()]

            section.visibleItemsInvalidationHandler = { [self] visibleItems, point, _ in

                visibleItems.forEach { item in
                    if let cell = self.notificationsCollView.cellForItem(at: item.indexPath) as? NotificationCell {
                        let itemIndex = CGFloat(item.indexPath.item)
                        let relativePoint: CGFloat = (point.x / self.notificationsCollView.bounds.width) / (itemIndex > 0 ? itemIndex : 1)
                        var parallaxedOffset = (-relativePoint * (bounds.width / 2))
                        /// If it's the first item, we must not shift it forward. Instead we shift the next element forward. When scroll the view, the element it will position itself at center of the view
                        if item.indexPath.item > 0 {
                            parallaxedOffset += (cell.bounds.width / 2)
                        }
                        /// Multiply the parallax to shift it forward even further on
                        let shiftConstant: CGFloat = 1.5
                        parallaxedOffset = parallaxedOffset * shiftConstant
                        let transform = CGAffineTransform(translationX: parallaxedOffset, y: 0)
                    }

                    guard let footer = self.notificationsCollView.supplementaryView(forElementKind: HomeElementKind.sectionFooter, at: item.indexPath) as? PageControlView else { return }
                    guard let index = visibleItems.last?.indexPath.item else { return }
                    footer.updatePageControlIndex(index: index)
                }
            }

            return section
        }

        return layout
    }

    private func buildPageControlFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerFooterSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )

        let footerAnchor = NSCollectionLayoutAnchor(edges: [.bottom, .leading], fractionalOffset: CGPoint(x: 0, y: 0))
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: HomeElementKind.sectionFooter, containerAnchor: footerAnchor)
        sectionFooter.zIndex = 1
        return sectionFooter
    }
}

public enum HomeElementKind {
    static let sectionFooter = "section-footer-element-kind"
}
