//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public class RewardView: BaseView {
    var closeTap = PassthroughSubject<Void, Never>()
    var earnMoreCoinsTap = PassthroughSubject<Void, Never>()
    var swipeTap = PassthroughSubject<Void, Never>()
    var reward: Reward? { didSet { didSetReward() }}
    var coins: Int?

    lazy var rewardBSView: RewardViewBS = {
        var view = RewardViewBS()

        return view
    }()

    private var closeBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.setImage(AppAsset.fancamClose.image, for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true

        return button
    }()

    private lazy var limitedView: UIView = {
        let view = UIView()
        view.backgroundColor = AppAsset.grayDarker.color

        var label = UILabel()
        LabelStyle.limitedTitle.apply(to: label)
        label.text = L10n.rewardLimited

        view.addSubview(label)
        label.centerYAnchor /==/ view.centerYAnchor
        label.centerXAnchor /==/ view.centerXAnchor

        return view
    }()

    override func configureUI() {
        super.configureUI()

        backgroundColor = AppAsset.backgroundColor.color
    }

    override func configureConstraints() {
        super.configureConstraints()
    }

    private func didSetReward() {
        guard let reward = reward else { return }

        presentRewardBSView(reward)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        limitedView.clipsToBounds = true
        limitedView.layer.cornerRadius = 17
    }

    @objc func closeButtonDidTap() {
        closeBtn.tapAnimation {
            self.closeTap.send()
        }
    }

    func earnMoreCoinsDidTap() {
        earnMoreCoinsTap.send()
    }

    func swipeDidTap() {
        swipeTap.send()
    }
}

extension RewardView {
    func presentRewardBSView(_ reward: Reward) {
        addSubview(rewardBSView)

        rewardBSView.edgeAnchors /==/ edgeAnchors

        rewardBSView.data = (reward, coins ?? 0)

        rewardBSView.dismiss = {
            self.dismissRewardBSView()
        }

        rewardBSView.earnMoreCoinsTap = {
            self.earnMoreCoinsDidTap()
        }

        rewardBSView.swipeTap = {
            self.swipeDidTap()
        }
    }

    func dismissRewardBSView() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, animations: {
            self.rewardBSView.transform = .identity
            self.closeTap.send()
        }) { _ in
            self.closeTap.send()
        }
    }
}
