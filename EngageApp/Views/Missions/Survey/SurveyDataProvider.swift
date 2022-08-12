//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import Foundation
import UIKit

class SurveyDataProvider: DiffableDataSourceProvider {
    private var cancellables = Set<AnyCancellable>()
    var continueButtonDidTap = PassthroughSubject<Void, Never>()

    enum Sections: String {
        case firstSection
    }

    typealias SectionValue = Sections

    struct ItemModel: Hashable {
        let questionItem: SurveyQuestion?
    }

    private let collectionView: UICollectionView

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    var setionsDisplayed = [SurveyQuestion]()

    lazy var dataSource = DataSource<SectionValue, ItemModel>(collectionView: collectionView) { collectionView, indexPath, item in

        switch item.section.value {
        case .firstSection:
            guard let questionItem = item.model.questionItem else { return UICollectionViewCell() }

            let cell: SurveyAnswerCollectionViewCell = collectionView.dequeueReusableCell(SurveyAnswerCollectionViewCell.self, for: indexPath)
            let viewModel = SurveyCollectionViewViewModel(configurator: questionItem, cell: cell, questionsNumber: self.setionsDisplayed.count)
            cell.configureViewModel(viewModel: viewModel)

            viewModel.continueButtonDidTap
                .sink { _ in
                    self.continueButtonDidTap.send()
                }
                .store(in: &self.cancellables)

            return cell
        }
    }

    func applySnapshot(entries: [SurveyQuestion]) {
        setionsDisplayed = entries

        DispatchQueue.main.async {
            var snapshot = Snapshot<SectionValue, ItemModel>()

            let firstSection = Section<SectionValue>(value: .firstSection)
            snapshot.appendSections([firstSection])

            var firsSectionItems = [Item<SectionValue, ItemModel>]()
            for item in entries {
                let sectionItem = Item(section: firstSection, model: ItemModel(questionItem: item))
                firsSectionItems.append(sectionItem)
            }
            snapshot.appendItems(firsSectionItems, toSection: firstSection)

            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
