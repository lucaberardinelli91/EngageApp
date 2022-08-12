//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import Hero
import UIKit

class WalletListDataProvider: DiffableDataSourceProvider {
    enum Sections: String {
        case firstSection
    }

    typealias SectionValue = Sections

    struct ItemModel: Hashable {
        let transaction: WalletTransaction?
    }

    private let collectionView: UICollectionView

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    var setionsDisplayed = [WalletTransaction]()
    private var nextMatch: WalletTransaction?

    lazy var dataSource = DataSource<SectionValue, ItemModel>(collectionView: collectionView) { collectionView, indexPath, item in

        guard let transactionModel = item.model.transaction else { return UICollectionViewCell() }
        let viewModel = TransactionCellViewModel(configurator: transactionModel)

        switch item.section.value {
        case .firstSection:
            let cell: TransactionCell = collectionView.dequeueReusableCell(TransactionCell.self, for: indexPath)
            cell.configureViewModel(viewModel: viewModel)

            return cell
        }
    }

    // MARK: - Snapshot

    func applySnapshot(entries: [WalletTransaction]) {
        setionsDisplayed = entries

        DispatchQueue.main.async {
            var snapshot = Snapshot<SectionValue, ItemModel>()

            let firstSection = Section<SectionValue>(value: .firstSection)
            snapshot.appendSections([firstSection])

            var firsSectionItems = [Item<SectionValue, ItemModel>]()
            for item in entries {
                let sectionItem = Item(section: firstSection, model: ItemModel(transaction: item))
                firsSectionItems.append(sectionItem)
            }
            snapshot.appendItems(firsSectionItems, toSection: firstSection)

            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
