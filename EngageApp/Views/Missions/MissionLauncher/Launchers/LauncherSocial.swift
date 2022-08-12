//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit

public class LauncherSocialView: LauncherBaseBS {
    var launcher: Launcher? { didSet { didSetLauncher() }}

    override func configureConstraints() {
        super.configureConstraints()

        bodyView.heightAnchor /==/ 00
        bodyView.constraints.forEach { c in
            bodyView.removeConstraint(c)
        }

        descriptionLbl.bottomAnchor /==/ timerLbl.topAnchor - 30
    }

    private func didSetLauncher() {
        guard let launcher = launcher else { return }

        titleLbl.text = L10n.missionSocialTitle
        descriptionLbl.text = launcher.description
        launcherBtn.setTitle(L10n.launcherEarnCoins2Button.replacingOccurrences(of: "%1", with: "\(launcher.coins!)".formatValue()), for: .normal)

        switch IdentityTouchpointType(launcher.provider ?? "") {
        case .socialGoogle:
            subtitleLbl.text = launcher.subTitle?.replacingOccurrences(of: "%1", with: L10n.missionTypeSocialGoogle)
            foreImgView.image = AppAsset.launcherTypeSocialGoogle.image
        case .socialFacebook:
            subtitleLbl.text = launcher.subTitle?.replacingOccurrences(of: "%1", with: L10n.missionTypeSocialFacebook)
            foreImgView.image = AppAsset.launcherTypeSocialFacebook.image
        case .socialTwitter:
            subtitleLbl.text = launcher.subTitle?.replacingOccurrences(of: "%1", with: L10n.missionTypeSocialTwitter)
            foreImgView.image = AppAsset.launcherTypeSocialTwitter.image
        case .socialLinkedin:
            subtitleLbl.text = launcher.subTitle?.replacingOccurrences(of: "%1", with: L10n.missionTypeSocialLinkedin)
            foreImgView.image = AppAsset.launcherTypeSocialLinkedin.image
        default:
            break
        }
        if let endAt = launcher.endAt { timerLbl.setExpiringTime(endDate: endAt) }
    }
}
