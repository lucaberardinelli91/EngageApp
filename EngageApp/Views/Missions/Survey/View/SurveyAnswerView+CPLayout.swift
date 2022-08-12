//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

extension SurveyAnswersView {
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (_: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)

            section.visibleItemsInvalidationHandler = { items, offset, environment in
                items.forEach { item in
                    let distanceFromCenter = abs((item.frame.midY - offset.y) - environment.container.contentSize.height / 2.0)
                    let minScale: CGFloat = 0.8
                    let maxScale: CGFloat = 1.0
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.height), minScale)
                    item.transform = .init(scaleX: scale, y: scale)

                    let minAlpha: CGFloat = 0
                    let maxAlpha: CGFloat = 1.0
                    let alpha = max(maxAlpha - (distanceFromCenter / environment.container.contentSize.height), minAlpha)

                    item.alpha = alpha

                    if scale > 0.95 {
                        item.transform = .identity
                        item.alpha = 1
                    }
                }
            }
            return section
        }
        return layout
    }
}
