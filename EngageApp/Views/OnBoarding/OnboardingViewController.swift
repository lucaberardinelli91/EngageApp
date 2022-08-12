//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Combine
import UIKit
public protocol OnboardingViewControllerProtocol {
    func getOnBoarding()
    func routeToWelcome()
}

public class OnboardingViewController: BasePackedViewController<OnboardingView, OnboardingViewModel>, OnboardingViewControllerProtocol {
    private var onBoardingDataProvider: OnBoardingDataProvider!
    public weak var onBoardingCoordinator: OnBoardingCoordinatorProtocol?
    var index: Int? { didSet { didSetIndex() }}

    override public init(viewModel: OnboardingViewModel) {
        super.init(viewModel: viewModel)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        configureBinds()
        setDataProvider()
        setInteractions()
        getOnBoarding()

        /// Hide navigation bar
        navigationController?.isNavigationBarHidden = true
    }

    private func configureBinds() {
        handle(viewModel.$getOnboardingState, showLoader: false, success: { onBoardingPages in
            self._view.setOnBoardingViewConfigurator(onBoardingPages: onBoardingPages)
            self.onBoardingDataProvider?.applySnapshot(onBoardingPages: onBoardingPages)
        })

        handle(viewModel.$nextIndexPathState, showLoader: false, success: { indexPath in
            self._view.onBoardingCollView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        })
    }

    private func setInteractions() {
        interaction(_view.nextButtonTap) { _ in
            let collectionView = self._view.onBoardingCollView
            self.viewModel.getNextIndexToScroll(collectionView: collectionView)
        }

        interaction(_view.onboardingFinishedTap) { _ in
            self.onBoardingCoordinator?.routeToWelcome(withFade: false)
        }
    }

    private func setDataProvider() {
        let collectionView = _view.onBoardingCollView
        onBoardingDataProvider = OnBoardingDataProvider(collectionView: collectionView)

        onBoardingDataProvider.skipTap = {
            self.onBoardingCoordinator?.routeToWelcome(withFade: false)
        }

        onBoardingDataProvider.updateIndex = { index in
            self.index = index
        }
    }

    public func getOnBoarding() {
        viewModel.getOnBoarding()
    }

    public func routeToWelcome() {
        onBoardingCoordinator?.routeToWelcome(withFade: true)
    }

    private func didSetIndex() {
        _view.timer = index ?? 0
    }
}

public extension OnboardingViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIScrollView.appearance().bounces = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIScrollView.appearance().bounces = true
    }
}
