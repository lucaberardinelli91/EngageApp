//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import Hero
import UIKit

class CatalogDataProvider: DiffableDataSourceProvider {
    enum Sections: String {
        case firstSection
    }

    typealias SectionValue = Sections

    struct ItemModel: Hashable {
        let reward: Reward?
    }

    private let collectionView: UICollectionView

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    var setionsDisplayed = [Reward]()

    lazy var dataSource = DataSource<SectionValue, ItemModel>(collectionView: collectionView) { collectionView, indexPath, item in

        guard let rewardModel = item.model.reward else { return UICollectionViewCell() }
        let viewModel = RewardCellViewModel(configurator: rewardModel)

        switch item.section.value {
        case .firstSection:
            let cell: RewardCell = collectionView.dequeueReusableCell(RewardCell.self, for: indexPath)
            cell.configureViewModel(viewModel: viewModel)

            return cell
        }
    }

    // MARK: - Snapshot

    func applySnapshot(entries: [Reward]) {
        setionsDisplayed = entries

        DispatchQueue.main.async {
            var snapshot = Snapshot<SectionValue, ItemModel>()

            let firstSection = Section<SectionValue>(value: .firstSection)
            snapshot.appendSections([firstSection])

            var firsSectionItems = [Item<SectionValue, ItemModel>]()
            for item in entries {
                if item.redeemable ?? false {
                    let sectionItem = Item(section: firstSection, model: ItemModel(reward: item))
                    firsSectionItems.append(sectionItem)
                }
            }
            snapshot.appendItems(firsSectionItems, toSection: firstSection)

            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
