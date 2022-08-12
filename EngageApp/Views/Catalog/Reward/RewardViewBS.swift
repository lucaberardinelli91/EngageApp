//
//  EngageApp
//  Created by Luca Berardinelli
//
//  Resource : https://iosexample.com/bottom-sheet-modal-view-controller-with-swift/

import Anchorage
import Combine
import UIKit

public class RewardViewBS: BottomSheetDraggable {
    private lazy var backgroundImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = ContentMode.scaleAspectFill
        imgView.image = AppAsset.reward.image

        return imgView
    }()

    private let titleLbl: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        LabelStyle.rewardBSTitle.apply(to: label)
        label.numberOfLines = 0

        return label
    }()

    private let subtitleLbl: UILabel = {
        var label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .left
        LabelStyle.rewardBSSubTitle.apply(to: label)
        label.numberOfLines = 0

        return label
    }()

    private lazy var descriptionScrollView: UIScrollView = {
        var scrollView = UIScrollView(frame: .zero)
        scrollView.showsVerticalScrollIndicator = false

        return scrollView
    }()

    private let descriptionLbl: UILabel = {
        var label = UILabel()
        LabelStyle.descriptionSubTitle.apply(to: label)
        label.numberOfLines = 0

        return label
    }()

    private lazy var rewardCoinsView: RewardCoinsView = {
        let view = RewardCoinsView()
        view.inCatalog = false

        return view
    }()

    private lazy var swipeBtn: SwipeButton = {
        let button = SwipeButton()
        button.backgroundColor = AppAsset.clear.color
        button.swipeEnd = {
            self.swipeTap?()
        }

        return button
    }()

    private lazy var rewardBtn: UIButton = {
        let button = UIButton(frame: .zero)
        ButtonStyle.secondaryButton.apply(to: button)
        button.hero.id = Constants.HeroTransitionsID.welcomeContinueButton
        button.addTarget(self, action: #selector(earnMoreCoinsDidTap), for: .touchUpInside)
        button.setTitle(L10n.launcherEarnMoreCoins, for: .normal)

        return button
    }()

    lazy var coinsNotEnoughView: UIView = {
        var view = UIView(frame: .zero)

        var containerView = UIView(frame: .zero)

        var text = UILabel()
        text.numberOfLines = 1
        text.textAlignment = .right
        LabelStyle.needMoreCoinsTextLabel.apply(to: text)
        text.numberOfLines = 0

        var value = UILabel()
        value.numberOfLines = 1
        value.textAlignment = .left
        LabelStyle.needMoreCoinsValueLabel.apply(to: value)
        value.numberOfLines = 0

        view.addSubview(containerView)
        containerView.addSubview(text)
        containerView.addSubview(value)

        text.leadingAnchor /==/ containerView.leadingAnchor + 20
        text.bottomAnchor /==/ containerView.bottomAnchor
        text.heightAnchor /==/ 30

        value.leadingAnchor /==/ text.trailingAnchor
        value.trailingAnchor /==/ containerView.trailingAnchor - 20
        value.bottomAnchor /==/ containerView.bottomAnchor
        value.heightAnchor /==/ 30

        containerView.centerXAnchor /==/ view.centerXAnchor
        containerView.bottomAnchor /==/ view.bottomAnchor

        return view
    }()

    var data: (Reward, Int)? { didSet { didSetData() }}

    override func configureUI() {
        super.configureUI()

        defaultHeight = 350
        currentContainerHeight = 350
        dismissibleHeight = 300
        maximumContainerHeight = UIScreen.main.bounds.height - 150

        addSubview(pullView)
        containerView.addSubview(rewardCoinsView)
        containerView.addSubview(titleLbl)
        containerView.addSubview(subtitleLbl)
        descriptionScrollView.addSubview(descriptionLbl)
        containerView.addSubview(descriptionScrollView)
        containerView.addSubview(coinsNotEnoughView)
    }

    override func configureConstraints() {
        super.configureConstraints()

        rewardCoinsView.trailingAnchor /==/ containerView.trailingAnchor - 20
        rewardCoinsView.topAnchor /==/ pullView.bottomAnchor + 15
        rewardCoinsView.heightAnchor /==/ 40

        titleLbl.topAnchor /==/ rewardCoinsView.topAnchor
        titleLbl.leadingAnchor /==/ containerView.leadingAnchor + 20
        titleLbl.widthAnchor /==/ 268

        subtitleLbl.topAnchor /==/ titleLbl.bottomAnchor + 5
        subtitleLbl.leadingAnchor /==/ titleLbl.leadingAnchor
        subtitleLbl.widthAnchor /==/ titleLbl.widthAnchor

        descriptionScrollView.topAnchor /==/ subtitleLbl.bottomAnchor + 10
        descriptionScrollView.bottomAnchor /==/ coinsNotEnoughView.topAnchor + 20
        descriptionScrollView.leadingAnchor /==/ containerView.leadingAnchor + 20
        descriptionScrollView.trailingAnchor /==/ containerView.trailingAnchor - 20

        descriptionLbl.topAnchor /==/ descriptionScrollView.topAnchor
        descriptionLbl.bottomAnchor /==/ descriptionScrollView.bottomAnchor
        descriptionLbl.widthAnchor /==/ descriptionScrollView.widthAnchor

        coinsNotEnoughView.centerXAnchor /==/ containerView.centerXAnchor
        coinsNotEnoughView.leadingAnchor /==/ containerView.leadingAnchor + 20
        coinsNotEnoughView.trailingAnchor /==/ containerView.trailingAnchor - 20
        coinsNotEnoughView.heightAnchor /==/ 60
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        rewardCoinsView.clipsToBounds = true
        rewardCoinsView.layer.cornerRadius = 20
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        coinsNotEnoughView.setGradientBackground(locations: [0.0, 0.4], colorTop: AppAsset.clear.color, colorBottom: .white)
    }

    private func didSetData() {
        guard let data = data else { return }

        backgroundImgView.sd_setImage(with: URL(string: data.0.image ?? ""), completed: { image, _, _, _ in
            self.backgroundImg = image
        })

        backgroundColor = AppAsset.backgroundColor.color

        let reward = data.0
        let coins = data.1
        let coinsView = coinsNotEnoughView.subviews[0]

        titleLbl.text = reward.title
        descriptionLbl.text = reward.description
        rewardCoinsView.coins = "\(reward.cost ?? 0)".formatValue()

        subtitleLbl.text = reward.digital ?? false ? L10n.rewardTypeDigital.uppercased() : L10n.rewardTypeReal.uppercased()

        let coinsTotal = Int(coins)
        let coinsReward = reward.cost ?? 0

        if coinsTotal >= coinsReward {
            addSubview(swipeBtn)

            (coinsView.subviews[0] as! UILabel).text = ""
            (coinsView.subviews[1] as! UILabel).text = ""

            descriptionScrollView.bottomAnchor /==/ coinsNotEnoughView.topAnchor + 45
            coinsNotEnoughView.heightAnchor /==/ 55
            coinsNotEnoughView.bottomAnchor /==/ swipeBtn.topAnchor - 5

            swipeBtn.leftAnchor /==/ leftAnchor + 25
            swipeBtn.rightAnchor /==/ rightAnchor - 25
            swipeBtn.heightAnchor /==/ 60
            swipeBtn.bottomAnchor /==/ bottomAnchor - 40
        } else {
            addSubview(rewardBtn)

            let coinsToRedeem = "\(coinsReward - Int(coinsTotal))".formatValue()
            (coinsView.subviews[0] as! UILabel).text = L10n.rewardCoinsNotEnough
            (coinsView.subviews[1] as! UILabel).text = " \(coinsToRedeem) coins"

            descriptionScrollView.bottomAnchor /==/ coinsNotEnoughView.topAnchor + 20
            coinsNotEnoughView.heightAnchor /==/ 60
            coinsNotEnoughView.bottomAnchor /==/ rewardBtn.topAnchor - 10

            rewardBtn.leftAnchor /==/ leftAnchor + 25
            rewardBtn.rightAnchor /==/ rightAnchor - 25
            rewardBtn.heightAnchor /==/ 55
            rewardBtn.bottomAnchor /==/ bottomAnchor - 40
        }

        guard let limited = reward.limited_availability else { return }

        if limited {
            backgroundView.addSubview(limitedView)
            limitedView.heightAnchor /==/ 35
            limitedView.widthAnchor /==/ 100
            limitedView.centerXAnchor /==/ backgroundView.centerXAnchor
            limitedView.topAnchor /==/ backgroundView.topAnchor + 50
        }
    }

    @objc func earnMoreCoinsDidTap() {
        rewardBtn.tapAnimation {
            self.earnMoreCoinsTap?()
        }
    }
}
