//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import SDWebImage
import UIKit

public class OnboardingView: BaseView {
    var nextButtonTap = PassthroughSubject<Void, Never>()
    var onboardingFinishedTap = PassthroughSubject<Void, Never>()
    private var nextButtonTimer: Timer?
    private var now = Date()
    var timer: Int = 1

    private var onBoardingPages: [OnBoardingPage]? {
        didSet {
            configureUI()
            configureConstraints()
        }
    }

    var onBoardingCollView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.bounces = false
        collectionView.register(OnBoardingPageCollectionViewCell.self)

        return collectionView
    }()

    private lazy var nextBtn: ButtonRounded = {
        let btn = ButtonRounded()
        btn.btnTapped = nextBtnTapped

        return btn
    }()

    override func configureUI() {
        super.configureUI()

        backgroundColor = .black

        onBoardingCollView.setCollectionViewLayout(makeLayout(), animated: false)
        addSubview(onBoardingCollView)

        addSubview(nextBtn)
    }

    override func configureConstraints() {
        super.configureConstraints()

        onBoardingCollView.edgeAnchors /==/ edgeAnchors

        nextBtn.centerXAnchor /==/ centerXAnchor
        nextBtn.widthAnchor /==/ 145
        nextBtn.heightAnchor /==/ 55

        switch UIScreen.main.bounds.height {
        case let h where h < Constants.screenHeightSmall:
            nextBtn.bottomAnchor /==/ bottomAnchor - 50
        case let h where h < Constants.screenHeightMedium:
            nextBtn.bottomAnchor /==/ bottomAnchor - 84
        case let h where h >= Constants.screenHeightMedium:
            nextBtn.bottomAnchor /==/ bottomAnchor - 130
        default: break
        }
    }
}

extension OnboardingView {
    func setOnBoardingViewConfigurator(onBoardingPages: [OnBoardingPage]?) {
        self.onBoardingPages = onBoardingPages
    }

    @objc func nextBtnTapped() {
        if timer == 3 {
            onboardingFinishedTap.send()
        } else {
            timer += 1
            nextButtonTap.send()
        }
    }
}

enum ButtonAnimationState {
    case forward
    case backward
}
