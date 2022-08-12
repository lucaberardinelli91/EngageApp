//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import Foundation
import Hero
import UIKit

class MissionsListDataProvider: DiffableDataSourceProvider {
    var heightConstraint: NSLayoutConstraint?

    var numItems: ((Int) -> Void)?

    enum Sections: String {
        case firstSection
    }

    typealias SectionValue = Sections

    struct ItemModel: Hashable {
        let mission: Mission?
    }

    private let collectionView: UICollectionView

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    var setionsDisplayed = [Mission]()

    lazy var dataSource = DataSource<SectionValue, ItemModel>(collectionView: collectionView) { collectionView, indexPath, item in

        guard let missionModel = item.model.mission else { return UICollectionViewCell() }
        let viewModel = MissionCellViewModel(configurator: missionModel)

        switch item.section.value {
        case .firstSection:
            let cell: MissionCell = collectionView.dequeueReusableCell(MissionCell.self, for: indexPath)
            cell.configureViewModel(viewModel: viewModel)

            return cell
        }
    }

    // MARK: - Snapshot

    func applySnapshot(entries: [Mission], inHome: Bool) {
        setionsDisplayed = entries

        DispatchQueue.main.async {
            var snapshot = Snapshot<SectionValue, ItemModel>()

            let firstSection = Section<SectionValue>(value: .firstSection)
            snapshot.appendSections([firstSection])

            var firstSectionItems = [Item<SectionValue, ItemModel>]()

            var index = 0, height = 0, numberRows = 0
            for item in entries {
                let missionType = MissionType(item.type ?? "")
                if missionType != .unknown {
                    if missionType == .identityTouchpoint, IdentityTouchpointType(item.data?.provider ?? "") == .unknown {
                        continue
                    }
                    let sectionItem = Item(section: firstSection, model: ItemModel(mission: item))
                    firstSectionItems.append(sectionItem)
                    let title = ((item.data?.title) != nil) ? item.data?.title : item.data?.label
                    if index < 5 {
                        numberRows = Int(round(Float(title?.count ?? 0) / 30)) > 0 ? Int(round(Float(title?.count ?? 0) / 30)) : 1
                        height += (80 + (numberRows * 22))
                        index += 1
                    }
                }
            }

            self.updateCollectionViewHeight(height)

            // show only 5 missions in home
            firstSectionItems = inHome && firstSectionItems.count > 5 ? Array(firstSectionItems[0 ... 4]) : firstSectionItems

            self.numItems?(firstSectionItems.count)

            snapshot.appendItems(firstSectionItems, toSection: firstSection)

            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }

    private func updateCollectionViewHeight(_ height: Int) {
        collectionView.constraints.forEach { c in
            if c == self.heightConstraint {
                self.collectionView.removeConstraint(c)
            }
        }
        collectionView.heightAnchor /==/ CGFloat(height)
        heightConstraint = collectionView.heightConstraint
        collectionView.layoutIfNeeded()
        collectionView.updateConstraints()
        collectionView.updateConstraintsIfNeeded()
        collectionView.setNeedsUpdateConstraints()
    }
}

extension UIScrollView {
    var heightConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
}
