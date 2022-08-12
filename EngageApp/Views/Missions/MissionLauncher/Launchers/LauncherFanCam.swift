//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit

public class LauncherFanCamView: LauncherBaseBS {
    private lazy var backLauncherFancam: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.backLauncherFancam.image
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()

    private lazy var frontLauncherFancam: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.frontLauncherFancam.image
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()

    let titleMissionLbl: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        LabelStyle.launcherFancamTitle.apply(to: label)
        label.numberOfLines = 1

        return label
    }()

    let descrMissionLbl: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        LabelStyle.launcherFancamDescr.apply(to: label)
        label.numberOfLines = 0

        return label
    }()

    var launcher: Launcher? { didSet { didSetLauncher() }}

    override func configureUI() {
        super.configureUI()

        backLauncherFancam.addSubview(frontLauncherFancam)
        backLauncherFancam.addSubview(titleMissionLbl)
        backLauncherFancam.addSubview(descrMissionLbl)

        bodyView.addSubview(backLauncherFancam)
    }

    override func configureConstraints() {
        super.configureConstraints()

        backLauncherFancam.topAnchor /==/ bodyView.topAnchor
        backLauncherFancam.leadingAnchor /==/ bodyView.leadingAnchor
        backLauncherFancam.trailingAnchor /==/ bodyView.trailingAnchor
        backLauncherFancam.bottomAnchor /==/ bodyView.bottomAnchor - 10

        frontLauncherFancam.topAnchor /==/ backLauncherFancam.topAnchor + 6
        frontLauncherFancam.widthAnchor /==/ 27
        frontLauncherFancam.heightAnchor /==/ frontLauncherFancam.widthAnchor
        frontLauncherFancam.centerXAnchor /==/ backLauncherFancam.centerXAnchor

        titleMissionLbl.topAnchor /==/ frontLauncherFancam.bottomAnchor + 7
        titleMissionLbl.centerXAnchor /==/ backLauncherFancam.centerXAnchor
        titleMissionLbl.widthAnchor /==/ 120

        descrMissionLbl.topAnchor /==/ titleMissionLbl.bottomAnchor + 5
        descrMissionLbl.centerXAnchor /==/ backLauncherFancam.centerXAnchor
        descrMissionLbl.widthAnchor /==/ 280
    }

    private func didSetLauncher() {
        guard let launcher = launcher else { return }

        titleLbl.text = launcher.title
        subtitleLbl.text = launcher.subTitle
        descriptionLbl.text = launcher.description
        launcherBtn.setTitle(L10n.launcherEarnCoins1Button.replacingOccurrences(of: "%1", with: "\(launcher.coins!)".formatValue()), for: .normal)
        foreImgView.image = AppAsset.launcherTypeFancam.image
        titleMissionLbl.text = L10n.launcherFancam
        descrMissionLbl.text = launcher.fancam
        if let endAt = launcher.endAt { timerLbl.setExpiringTime(endDate: endAt) }
    }
}
