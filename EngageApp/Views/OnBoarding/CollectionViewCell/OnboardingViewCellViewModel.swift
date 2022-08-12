//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Foundation

protocol OnBoardingPageCollectionViewCellViewModelProtocol {
    func getInfo()
    func nextButtonTap()
    func notNowButtonTap()
}

class OnBoardingPageCollectionViewCellViewModel: OnBoardingPageCollectionViewCellViewModelProtocol {
    @Published var onboardinCollectionViewCellState: LoadingState<OnBoardingPage, CustomError> = .idle
    private var onboardingPage: OnBoardingPage
    var nextButtonDidTap: (() -> Void)?
    var notNowButtonDidTap: (() -> Void)?

    init(configurator: OnBoardingPage) {
        onboardingPage = configurator
    }

    func getInfo() {
        onboardinCollectionViewCellState = .success(onboardingPage)
    }

    func nextButtonTap() {
        nextButtonDidTap?()
    }

    func notNowButtonTap() {
        notNowButtonDidTap?()
    }
}
