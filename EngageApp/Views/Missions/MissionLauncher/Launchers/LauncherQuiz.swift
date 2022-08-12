//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit

public class LauncherQuizView: LauncherBaseBS {
    private let questionsView: LauncherBox = {
        let view = LauncherBox()

        return view
    }()

    private let timerView: LauncherBox = {
        let view = LauncherBox()

        return view
    }()

    var launcher: Launcher? { didSet { didSetLauncher() }}

    override func configureUI() {
        super.configureUI()

        bodyView.addSubview(questionsView)
        bodyView.addSubview(timerView)
    }

    override func configureConstraints() {
        super.configureConstraints()

        questionsView.heightAnchor == bodyView.heightAnchor
        questionsView.widthAnchor == 75
        questionsView.centerXAnchor == centerXAnchor - 50

        timerView.heightAnchor == bodyView.heightAnchor
        timerView.widthAnchor == 75
        timerView.centerXAnchor == centerXAnchor + 50
    }

    private func didSetLauncher() {
        guard let launcher = launcher else { return }

        titleLbl.text = launcher.title
        subtitleLbl.text = launcher.subTitle
        descriptionLbl.text = launcher.description
        questionsView.launcherInfo = LauncherBoxInfo(type: .plain, value: launcher.questions)
        timerView.launcherInfo = LauncherBoxInfo(type: .vertical, value: launcher.time)
        launcherBtn.setTitle(L10n.launcherEarnCoins2Button.replacingOccurrences(of: "%1", with: "\(launcher.coins!) ".formatValue()), for: .normal)
        foreImgView.image = AppAsset.launcherTypeQuiz.image
        if let endAt = launcher.endAt { timerLbl.setExpiringTime(endDate: endAt) }
    }
}
