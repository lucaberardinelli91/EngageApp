//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public enum NotificationType: String {
    case mission
    case missionList = "mission-general"
    case reward
    case rewardList = "reward-general"
    case profile = "profile-general"
    case unknown

    public init(type: String) {
        switch type {
        case "mission":
            self = .mission
        case "mission-general":
            self = .missionList
        case "reward":
            self = .reward
        case "reward-general":
            self = .rewardList
        case "profile-general":
            self = .profile
        default:
            self = .unknown
        }
    }

    public func getStringType() -> String {
        switch self {
        case .mission:
            return L10n.notificationGoToMission
        case .missionList:
            return L10n.notificationGoToMissionList
        case .reward:
            return L10n.notificationGoToReward
        case .rewardList:
            return L10n.notificationGoToRewardList
        case .profile:
            return L10n.notificationGoToProfile
        case .unknown:
            return L10n.notificationUnknown
        }
    }
}

public class NotificationCell: BaseCell {
    private var viewModel: NotificationCellViewModel?
    private var cancellables = Set<AnyCancellable>()

    private lazy var containerView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = AppAsset.background.color

        return view
    }()

    private lazy var bodyView: UIView = {
        let view = UIView()
        view.backgroundColor = AppAsset.background.color

        return view
    }()

    private lazy var backImgContainerView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = .blue

        return view
    }()

    private lazy var backImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = ContentMode.scaleToFill
        imgView.image = AppAsset.notificationBackground.image

        return imgView
    }()

    private lazy var titleLbl: UILabel = {
        var label = UILabel()
        LabelStyle.notificationTitle.apply(to: label)
        label.textAlignment = .left
        label.numberOfLines = 0

        return label
    }()

    private lazy var subTitleLbl: UILabel = {
        var label = UILabel()
        LabelStyle.notificationSubTitle.apply(to: label)
        label.textAlignment = .left
        label.numberOfLines = 0

        return label
    }()

    private lazy var imgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = ContentMode.scaleAspectFill
        imgView.image = AppAsset.notificationImage.image

        return imgView
    }()

    override public func configureUI() {
        super.configureUI()

        backgroundColor = AppAsset.background.color

        bodyView.addSubview(titleLbl)
        bodyView.addSubview(subTitleLbl)
        bodyView.addSubview(imgView)

        backImgContainerView.addSubview(backImgView)

        containerView.addSubview(backImgContainerView)
        containerView.addSubview(bodyView)
        addSubview(containerView)
    }

    override public func configureConstraints() {
        super.configureConstraints()

        heightAnchor /==/ 250

        containerView.topAnchor /==/ topAnchor
        containerView.leadingAnchor /==/ leadingAnchor
        containerView.trailingAnchor /==/ trailingAnchor
        containerView.heightAnchor /==/ 250

        backImgContainerView.topAnchor /==/ containerView.topAnchor
        backImgContainerView.leadingAnchor /==/ containerView.leadingAnchor + 20
        backImgContainerView.trailingAnchor /==/ containerView.trailingAnchor - 20
        backImgContainerView.bottomAnchor /==/ containerView.bottomAnchor - 40

        backImgView.edgeAnchors /==/ backImgContainerView.edgeAnchors

        bodyView.leadingAnchor /==/ containerView.leadingAnchor + 40
        bodyView.trailingAnchor /==/ containerView.trailingAnchor - 40
        bodyView.bottomAnchor /==/ backImgView.bottomAnchor - 22

        imgView.widthAnchor /==/ 43
        imgView.heightAnchor /==/ imgView.widthAnchor
        imgView.centerYAnchor /==/ bodyView.centerYAnchor
        imgView.trailingAnchor /==/ bodyView.trailingAnchor - 20

        titleLbl.topAnchor /==/ bodyView.topAnchor + 15
        titleLbl.leadingAnchor /==/ bodyView.leadingAnchor + 20

        subTitleLbl.topAnchor /==/ titleLbl.bottomAnchor
        subTitleLbl.leadingAnchor /==/ titleLbl.leadingAnchor
        subTitleLbl.trailingAnchor /==/ imgView.leadingAnchor - 20
        subTitleLbl.bottomAnchor /==/ bodyView.bottomAnchor - 15
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        clipsToBounds = true
        layer.cornerRadius = 10
        bodyView.layer.cornerRadius = 10
        backImgView.clipsToBounds = true
        backImgView.layer.cornerRadius = 10
        backImgContainerView.layer.cornerRadius = 10
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        containerView.addShadow(color: AppAsset.background.color, opacity: 0.8, radius: 10, offset: .zero)
    }

    public func configureViewModel(viewModel: NotificationCellViewModel) {
        self.viewModel = viewModel

        configureBinds()
        viewModel.getInfo()
    }

    private func configureBinds() {
        viewModel?.$notificationCollectionViewCellState
            .sink(receiveValue: { state in
                switch state {
                case let .success(notification):
                    self.refreshUI(notification: notification)
                default:
                    break
                }
            })
            .store(in: &cancellables)
    }

    private func refreshUI(notification: Notification) {
        titleLbl.text = NotificationType(type: notification.type ?? "").getStringType()
        subTitleLbl.text = notification.text
    }
}
