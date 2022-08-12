//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Combine
import Foundation
import UIKit

class OnBoardingDataProvider: DiffableDataSourceProvider {
    var skipTap: (() -> Void)?
    var updateIndex: ((Int) -> Void)?

    enum Sections: String {
        case onBoardingPage
    }

    struct ItemModel: Hashable {
        let onBoardingPage: OnBoardingPage?
    }

    typealias SectionValue = Sections

    var tutorialPageDisplayed = [OnBoardingPage]()
    private let collectionView: UICollectionView

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    lazy var dataSource = DataSource<SectionValue, ItemModel>(collectionView: collectionView) { [self] collectionView, indexPath, item in

        switch item.section.value {
        case .onBoardingPage:
            let cell: OnBoardingPageCollectionViewCell = collectionView.dequeueReusableCell(OnBoardingPageCollectionViewCell.self, for: indexPath) as! OnBoardingPageCollectionViewCell
            if let onBoardingPageConfiguration = item.model.onBoardingPage {
                let viewModel = OnBoardingPageCollectionViewCellViewModel(configurator: onBoardingPageConfiguration)
                cell.configureViewModel(viewModel: viewModel)
                self.updateIndex?(cell.index)
            }

            cell.skipTap = {
                self.skipTap?()
            }

            return cell
        }
    }

    func applySnapshot(onBoardingPages: [OnBoardingPage]) {
        var snapshot = Snapshot<SectionValue, ItemModel>()

        let onBoardingPageSection = Section<SectionValue>(value: .onBoardingPage)
        snapshot.appendSections([onBoardingPageSection])

        var tutorialPagesItem = [Item<SectionValue, ItemModel>]()
        tutorialPagesItem = onBoardingPages.map { onBoardingPage -> Item<SectionValue, ItemModel> in
            Item(section: onBoardingPageSection, model: ItemModel(onBoardingPage: onBoardingPage))
        }
        snapshot.appendItems(tutorialPagesItem, toSection: onBoardingPageSection)

        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
