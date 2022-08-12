//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit

public class LauncherInstantWin: LauncherBaseBS {
    private let questionsView: LauncherBox = {
        let view = LauncherBox()

        return view
    }()

    var launcher: Launcher? { didSet { didSetLauncher() }}

    override func configureUI() {
        super.configureUI()

        bodyView.addSubview(questionsView)
    }

    override func configureConstraints() {
        super.configureConstraints()

        questionsView.heightAnchor == bodyView.heightAnchor
        questionsView.widthAnchor == 75
        questionsView.centerXAnchor == bodyView.centerXAnchor

        bodyView.heightAnchor /==/ 100
    }

    private func didSetLauncher() {
        guard let launcher = launcher else { return }

        titleLbl.text = launcher.title
        subtitleLbl.text = launcher.subTitle
        descriptionLbl.text = launcher.description
        questionsView.launcherInfo = LauncherBoxInfo(type: .horizontal, value: launcher.questions, isInstantwin: true)
        launcherBtn.setTitle(L10n.launcherInstantwinButton, for: .normal)
        launcherBtn.setImage(nil, for: .normal)
        ButtonStyle.instantwinButton.apply(to: launcherBtn)
        foreImgView.image = AppAsset.launcherTypeInstantwin.image
        if let endAt = launcher.endAt { timerLbl.setExpiringTime(endDate: endAt) }
    }
}
