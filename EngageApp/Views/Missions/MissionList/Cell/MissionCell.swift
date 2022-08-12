//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public class MissionCell: BaseCell {
    private var viewModel: MissionCellViewModel?
    private var cancellables = Set<AnyCancellable>()

    private lazy var containerView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = AppAsset.background.color
        view.layer.cornerRadius = 10

        return view
    }()

    private lazy var bodyView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10

        return view
    }()

    private lazy var typeImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()

    private lazy var typeLbl: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        LabelStyle.missionType.apply(to: label)
        label.textAlignment = .left
        label.numberOfLines = 0

        return label
    }()

    private lazy var textLbl: UILabel = {
        var label = UILabel()
        LabelStyle.missionText.apply(to: label)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var timerLbl: TimerMission = {
        let timer = TimerMission()
        timer.isHidden = true

        return timer
    }()

    private lazy var coinsView: CoinsView = {
        let view = CoinsView()

        return view
    }()

    override public func configureUI() {
        super.configureUI()

        bodyView.addSubview(typeImgView)
        bodyView.addSubview(typeLbl)
        bodyView.addSubview(textLbl)
        bodyView.addSubview(timerLbl)
        bodyView.addSubview(coinsView)

        containerView.addSubview(bodyView)
        addSubview(containerView)
    }

    override public func configureConstraints() {
        super.configureConstraints()

        containerView.edgeAnchors /==/ edgeAnchors

        bodyView.topAnchor /==/ containerView.topAnchor + 7
        bodyView.bottomAnchor /==/ containerView.bottomAnchor - 4
        bodyView.leadingAnchor /==/ containerView.leadingAnchor + 4
        bodyView.trailingAnchor /==/ containerView.trailingAnchor - 7

        typeImgView.centerYAnchor /==/ centerYAnchor
        typeImgView.leadingAnchor /==/ bodyView.leadingAnchor + 10
        typeImgView.heightAnchor /==/ 22
        typeImgView.widthAnchor /==/ typeImgView.heightAnchor

        typeLbl.topAnchor /==/ bodyView.topAnchor + 18
        typeLbl.leadingAnchor /==/ typeImgView.trailingAnchor + 12

        textLbl.topAnchor /==/ typeLbl.bottomAnchor + 3
        textLbl.leadingAnchor /==/ typeImgView.trailingAnchor + 12
        textLbl.bottomAnchor /==/ bodyView.bottomAnchor - 17
        textLbl.widthAnchor /==/ 230

        coinsView.trailingAnchor /==/ bodyView.trailingAnchor
        coinsView.bottomAnchor /==/ bodyView.bottomAnchor
        coinsView.heightAnchor /==/ 52

        timerLbl.trailingAnchor /==/ bodyView.trailingAnchor - 15
        timerLbl.topAnchor /==/ bodyView.topAnchor + 7

        layoutIfNeeded()
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        bodyView.addShadow(color: AppAsset.background.color, opacity: 0.8, radius: 10, offset: .zero)
    }

    public func configureViewModel(viewModel: MissionCellViewModel) {
        self.viewModel = viewModel

        configureBinds()
        viewModel.getInfo()
    }

    private func configureBinds() {
        viewModel?.$missionCollectionViewCellState
            .sink(receiveValue: { state in
                switch state {
                case let .success(mission):
                    self.refreshUI(mission: mission)
                default:
                    break
                }
            })
            .store(in: &cancellables)
    }

    private func refreshUI(mission: Mission) {
        guard let data = mission.data, let points = data.points, let type = mission.type
        else { return }

        textLbl.text = data.title ?? ""

//        if let maxPoints = data.maxPoints {
//            if maxPoints < 10 {
//                coinsView.widthAnchor /==/ 75
//            } else if maxPoints < 100 {
//                coinsView.widthAnchor /==/ 85
//            } else if maxPoints < 1000 {
//                coinsView.widthAnchor /==/ 95
//            } else {
//                coinsView.widthAnchor /==/ 105
//            }
//            coinsView.coins = "\(maxPoints)"
//        } else {
//            if points < 10 {
//                coinsView.widthAnchor /==/ 75
//            } else if points < 100 {
//                coinsView.widthAnchor /==/ 85
//            } else if points < 1000 {
//                coinsView.widthAnchor /==/ 95
//            } else {
//                coinsView.widthAnchor /==/ 105
//            }
//            coinsView.coins = "\(points)"
//        }

        if let maxPoints = data.maxPoints {
            coinsView.coins = "\(maxPoints)"
        } else {
            coinsView.coins = "\(points)"
        }
        coinsView.widthAnchor /==/ 85

        switch MissionType(type) {
        case .quiz:
            typeImgView.image = AppAsset.missionTypeQuiz.image
            typeLbl.text = L10n.missionTypeQuiz.uppercased()
        case .survey:
            typeImgView.image = AppAsset.missionTypeSurvey.image
            typeLbl.text = L10n.missionTypeSurvey.uppercased()
        case .info:
            typeImgView.image = AppAsset.missionTypeInfo.image
            typeLbl.text = L10n.missionTypeInfo.uppercased()
        case .fancam:
            typeImgView.image = AppAsset.missionTypeFancam.image
            typeLbl.text = L10n.missionTypeFancam.uppercased()
        case .instantwin:
            typeImgView.image = AppAsset.missionTypeInstantwin.image
            typeLbl.text = L10n.missionTypeInstantwin.uppercased()
        case .identityTouchpoint:
            guard let provider = mission.data?.provider else { return }
            switch IdentityTouchpointType(provider) {
            case .socialGoogle:
                typeImgView.image = AppAsset.missionTypeSocialGoogle.image
                typeLbl.text = L10n.missionTypeSocialGoogle.uppercased()
            case .socialFacebook:
                typeImgView.image = AppAsset.missionTypeSocialFacebook.image
                typeLbl.text = L10n.missionTypeSocialFacebook.uppercased()
            case .socialTwitter:
                typeImgView.image = AppAsset.missionTypeSocialTwitter.image
                typeLbl.text = L10n.missionTypeSocialTwitter.uppercased()
            case .socialLinkedin:
                typeImgView.image = AppAsset.missionTypeSocialLinkedin.image
                typeLbl.text = L10n.missionTypeSocialLinkedin.uppercased()
            default:
                break
            }
        default: break
        }

        guard let schedules = data.mission?.schedules, let endAt = schedules[0].endAt else { return }
        timerLbl.setExpiringTime(endDate: endAt)

        layoutIfNeeded()
    }

    override public func prepareForReuse() {
        typeImgView.image = nil
        typeLbl.text = ""
        textLbl.text = ""
        timerLbl.time = nil
        timerLbl.isHidden = true
    }
}
