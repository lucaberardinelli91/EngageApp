//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Combine
import UIKit

public protocol OnboardingViewModelProtocol {
    func getOnBoarding()
    func getNextIndexToScroll(collectionView: UICollectionView)
}

public class OnboardingViewModel: BaseViewModel, OnboardingViewModelProtocol {
    @Published var getOnboardingState: LoadingState<[OnBoardingPage], CustomError> = .idle
    @Published var nextIndexPathState: LoadingState<IndexPath, Never> = .idle

    private var lastIndex: Int = -1

    public func getOnBoarding() {
        getOnboardingState = .success(OnBoardingPage.getOnBoardingPages())
    }

    public func getNextIndexToScroll(collectionView: UICollectionView) {
        let visibleItems = collectionView.visibleCells
            .sorted { cell0, cell1 in
                guard let indexPathCell0 = collectionView.indexPath(for: cell0), let indexPathCell1 = collectionView.indexPath(for: cell1) else { return true }

                return indexPathCell0.item < indexPathCell1.item
            }

        guard let firstItem = visibleItems.first, let currentIndexPath = collectionView.indexPath(for: firstItem) else { return }

        let finalIndexPath = IndexPath(item: currentIndexPath.item + 1, section: currentIndexPath.section)

        nextIndexPathState = .success(finalIndexPath)
    }
}
