//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public class RewardCell: BaseCell {
    private var viewModel: RewardCellViewModel?
    private var cancellables = Set<AnyCancellable>()

    private lazy var containerView: UIView = {
        var view = UIView(frame: .zero)
        view.layer.cornerRadius = 10

        return view
    }()

    private lazy var footerView: UIView = {
        var view = UIView(frame: .zero)
        view.layer.cornerRadius = 10

        return view
    }()

    private lazy var rewardImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = ContentMode.scaleAspectFill
        imgView.image = AppAsset.reward.image

        return imgView
    }()

    private lazy var rewardTitleLbl: UILabel = {
        var label = UILabel()
        LabelStyle.rewardListTitle.apply(to: label)
        label.textAlignment = .left
        label.numberOfLines = 0

        return label
    }()

    private lazy var rewardCoinsView: RewardCoinsView = {
        let view = RewardCoinsView()
        view.inCatalog = true

        return view
    }()

    private lazy var limitedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.4)

        var label = UILabel()
        label.textAlignment = .center
        LabelStyle.limitedView.apply(to: label)
        label.text = L10n.rewardLimited

        view.addSubview(label)

        label.centerYAnchor /==/ view.centerYAnchor
        label.centerXAnchor /==/ view.centerXAnchor

        return view
    }()

    override public func configureUI() {
        super.configureUI()

        backgroundColor = AppAsset.backgroundColor.color

        footerView.addSubview(rewardTitleLbl)
        footerView.addSubview(rewardCoinsView)

        containerView.addSubview(rewardImgView)
        containerView.addSubview(footerView)
        containerView.addSubview(limitedView)
        addSubview(containerView)
    }

    override public func configureConstraints() {
        super.configureConstraints()

        containerView.edgeAnchors /==/ edgeAnchors

        rewardImgView.edgeAnchors == containerView.edgeAnchors

        footerView.widthAnchor /==/ containerView.widthAnchor
        footerView.bottomAnchor /==/ containerView.bottomAnchor
        footerView.heightAnchor /==/ containerView.heightAnchor / 2

        rewardCoinsView.heightAnchor /==/ 29
        rewardCoinsView.bottomAnchor /==/ footerView.bottomAnchor - 15
        rewardCoinsView.leadingAnchor /==/ footerView.leadingAnchor + 15

        rewardTitleLbl.leadingAnchor /==/ rewardCoinsView.leadingAnchor
        rewardTitleLbl.bottomAnchor /==/ rewardCoinsView.topAnchor - 10
        rewardTitleLbl.trailingAnchor /==/ footerView.trailingAnchor - 15

        limitedView.topAnchor /==/ containerView.topAnchor
        limitedView.trailingAnchor /==/ containerView.trailingAnchor
        limitedView.heightAnchor /==/ 40
        limitedView.widthAnchor /==/ 80
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        clipsToBounds = true
        layer.cornerRadius = 10

        rewardCoinsView.clipsToBounds = true
        rewardCoinsView.layer.cornerRadius = 14

        limitedView.layer.borderWidth = 0.2
        limitedView.layer.borderColor = UIColor.white.cgColor
        limitedView.layer.cornerRadius = 11
        limitedView.layer.maskedCorners = [.layerMinXMaxYCorner]

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.commit()
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        containerView.addShadow(color: AppAsset.background.color, opacity: 0.8, radius: 10, offset: .zero)

        footerView.removeGradient()
        footerView.setGradientBackground(locations: [0.2, 1.0], colorTop: .clear, colorBottom: ThemeManager.currentTheme().primaryColor.withAlphaComponent(0.9))
    }

    public func configureViewModel(viewModel: RewardCellViewModel) {
        self.viewModel = viewModel

        configureBinds()
        viewModel.getInfo()
    }

    private func configureBinds() {
        viewModel?.$rewardCollectionViewCellState
            .sink(receiveValue: { state in
                switch state {
                case let .success(reward):
                    self.refreshUI(reward: reward)
                default:
                    break
                }
            })
            .store(in: &cancellables)
    }

    private func refreshUI(reward: Reward) {
        rewardTitleLbl.text = reward.title
        rewardCoinsView.coins = "\(reward.cost ?? 0)".formatValue()
        
        switch reward.id {
        case "1":
            rewardImgView.image = AppAsset.reward4.image
        case "2":
            rewardImgView.image = AppAsset.reward5.image
        case "3":
            rewardImgView.image = AppAsset.reward1.image
        case "4":
            rewardImgView.image = AppAsset.reward3.image
        case "5":
            rewardImgView.image = AppAsset.reward2.image
        case "6":
            rewardImgView.image = AppAsset.reward6.image
        case "7":
            rewardImgView.image = AppAsset.reward7.image
        case "8":
            rewardImgView.image = AppAsset.reward8.image
        default:
            break
        }
        
        guard let limited = reward.limited_availability else { return }
        limitedView.isHidden = !limited
    }
}
