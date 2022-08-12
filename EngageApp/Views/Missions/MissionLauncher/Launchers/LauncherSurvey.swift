//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit

public class LauncherSurveyView: LauncherBaseBS {
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
        questionsView.launcherInfo = LauncherBoxInfo(type: .horizontal, value: launcher.questions)
        launcherBtn.setTitle(L10n.launcherEarnCoins1Button.replacingOccurrences(of: "%1", with: "\(launcher.coins!)".formatValue()), for: .normal)
        foreImgView.image = AppAsset.launcherTypeSurvey.image
        if let endAt = launcher.endAt { timerLbl.setExpiringTime(endDate: endAt) }
    }
}
