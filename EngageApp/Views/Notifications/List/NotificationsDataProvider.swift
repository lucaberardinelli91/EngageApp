//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import Hero
import UIKit

class NotificationsDataProvider: DiffableDataSourceProvider {
    enum Sections: String {
        case firstSection
    }

    typealias SectionValue = Sections

    struct ItemModel: Hashable {
        let notification: Notification?
    }

    private let collectionView: UICollectionView

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    var setionsDisplayed = [Notification]()

    lazy var dataSource = DataSource<SectionValue, ItemModel>(collectionView: collectionView) { collectionView, indexPath, item in

        guard let notificationModel = item.model.notification else { return UICollectionViewCell() }
        let viewModel = NotificationCellViewModel(configurator: notificationModel)

        switch item.section.value {
        case .firstSection:
            let cell: NotificationCell = collectionView.dequeueReusableCell(NotificationCell.self, for: indexPath)
            cell.configureViewModel(viewModel: viewModel)

            return cell
        }
    }

    // MARK: - Snapshot

    func applySnapshot(entries: [Notification]) {
        setionsDisplayed = entries

        DispatchQueue.main.async {
            var snapshot = Snapshot<SectionValue, ItemModel>()

            let firstSection = Section<SectionValue>(value: .firstSection)
            snapshot.appendSections([firstSection])

            var firsSectionItems = [Item<SectionValue, ItemModel>]()
            for item in entries {
                let sectionItem = Item(section: firstSection, model: ItemModel(notification: item))
                firsSectionItems.append(sectionItem)
            }
            snapshot.appendItems(firsSectionItems, toSection: firstSection)

            self.dataSource.supplementaryViewProvider = { _, kind, indexPath in
                self.getSupplementaryView(kind: kind, indexPath: indexPath)
            }

            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }

    func getSupplementaryView(kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case HomeElementKind.sectionFooter:
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeElementKind.sectionFooter, for: indexPath) as? PageControlView else { return UICollectionReusableView() }
            footerView.pageControl.numberOfPages = setionsDisplayed.count
            return footerView

        default:
            break
        }
        return UICollectionReusableView()
    }
}
