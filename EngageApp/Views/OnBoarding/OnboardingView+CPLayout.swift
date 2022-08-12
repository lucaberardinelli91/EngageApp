//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

extension OnboardingView {
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (_: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            section.orthogonalScrollingBehavior = .groupPagingCentered

            /// Parallax Animation
            section.visibleItemsInvalidationHandler = { visibleItems, point, _ in
                for currentItem in visibleItems {
                    let itemIndex = CGFloat(currentItem.indexPath.item)
                    /// If `itemIndex` < 0, the division is infinite
                    let relativePoint: CGFloat = (point.x / self.onBoardingCollView.bounds.width) / (itemIndex > 0 ? itemIndex : 1)

                    if let cell = self.onBoardingCollView.cellForItem(at: currentItem.indexPath) as? OnBoardingPageCollectionViewCell {
                        if relativePoint >= 0.0 {
                            var parallaxedOffset = (-relativePoint * (self.bounds.width / 2))
                            /// If it's the first item, we must not shift it forward. Instead we shift the next element forward. When scroll the view, the element it will position itself at center of the view
                            if currentItem.indexPath.item > 0 {
                                parallaxedOffset += (cell.bounds.width / 2)
                            }
                            /// Multiply the parallax to shift it forward even further on
                            let shiftConstant: CGFloat = 3
                            parallaxedOffset = parallaxedOffset * shiftConstant
                            let transform = CGAffineTransform(translationX: parallaxedOffset, y: 0)
                            cell.foregroundImgView.transform = transform
                        }
                    }
                }

                /// Update progress bar
                let xRelativePoint = point.x / self.onBoardingCollView.bounds.width
            }

            return section
        }

        return layout
    }
}
