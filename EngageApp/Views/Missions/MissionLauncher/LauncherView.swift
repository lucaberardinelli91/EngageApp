//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public class LauncherView: BaseView {
    var mission: Mission? { didSet { didSetMission() }}
    var dismiss: (() -> Void)?
    var surveyDidTap: (() -> Void)?
    var quizDidTap: (() -> Void)?
    var fancamDidTap: (() -> Void)?
    var socialDidTap: (() -> Void)?
    var instantwinDidTap: (() -> Void)?
    var infoDidTap: ((LauncherInfo) -> Void)?

    lazy var launcherView: LauncherBaseBS = {
        var view = LauncherBaseBS(height: UIScreen.main.bounds.height * 0.62)

        return view
    }()

    lazy var backLayerView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear

        return view
    }()

    override func configureUI() {
        super.configureUI()

        backgroundColor = .clear
    }

    override func configureConstraints() {
        super.configureConstraints()
    }

    private func didSetMission() {
        guard let mission = mission, let type = mission.type else { return }

        switch MissionType(type) {
        case .quiz, .survey, .fancam, .instantwin, .identityTouchpoint:
            openLaucher()
        case .info:
            guard let data = mission.data, let id = data.id, let cta = data.cta, let title = data.title, let content = data.content, let points = data.points else { return }

            self.infoDidTap?(LauncherInfo(id: id,
                                          cta: cta,
                                          title: title,
                                          subTitle: title,
                                          text: content,
                                          coins: "\(points)"))
        default: break
        }
    }
}

extension LauncherView {
    func openLaucher() {
        guard let type = self.mission?.type else { return }

        switch MissionType(type) {
        case .quiz:
            openLauncherQuiz()
        case .survey:
            openLauncherSurvey()
        case .fancam:
            openLauncherFancam()
        case .instantwin:
            openLauncherInstantWin()
        case .identityTouchpoint:
            openLauncherSocial()
        default: break
        }
    }

    /// Launcher Quiz
    func openLauncherQuiz() {
        guard let data = self.mission?.data, let schedules = data.schedules, let endAt = schedules[0].endAt
        else { return }

        let launcher = LauncherQuizView(height: 540)
        launcher.launcher = Launcher(title: L10n.missionQuiz,
                                     subTitle: data.title,
                                     description: data.claim,
                                     questions: data.totalQuestions,
                                     time: data.seconds,
                                     coins: data.maxPoints,
                                     fancam: "",
                                     endAt: endAt,
                                     provider: "")

        presentLauncher(launcher)
        launcher.launcherBtnTap = {
            self.quizDidTap?()
        }
    }

    /// Launcher Survey
    func openLauncherSurvey() {
        guard let data = self.mission?.data, let schedules = data.mission?.schedules, let endAt = schedules[0].endAt
        else { return }

        let launcher = LauncherSurveyView(height: 540)
        launcher.launcher = Launcher(title: L10n.missionSurvey,
                                     subTitle: data.title,
                                     description: data.claim,
                                     questions: data.totalQuestions,
                                     time: 0,
                                     coins: data.points,
                                     fancam: "",
                                     endAt: endAt,
                                     provider: "")

        presentLauncher(launcher)
        launcher.launcherBtnTap = {
            self.surveyDidTap?()
        }
    }

    /// Launcher Fancam
    func openLauncherFancam() {
        guard let data = self.mission?.data, let title = data.title else { return }

        let launcher = LauncherFanCamView(height: 560)
        launcher.launcher = Launcher(title: L10n.missionFancam,
                                     subTitle: data.title,
                                     description: data.schedules?[0].claim,
                                     questions: 0,
                                     time: 0,
                                     coins: data.points,
                                     fancam: data.schedules?[0].claim,
                                     endAt: data.schedules?[0].endAt,
                                     provider: "")

        presentLauncher(launcher)
        launcher.launcherBtnTap = {
            self.fancamDidTap?()
        }
    }

    /// Launcher Instantwin
    func openLauncherInstantWin() {
        guard let data = self.mission?.data else { return }

        let launcher = LauncherInstantWin(height: 540)
        launcher.launcher = Launcher(title: L10n.missionInstantwin,
                                     subTitle: data.title,
                                     description: data.claim,
                                     questions: data.points,
                                     time: 0,
                                     coins: data.points,
                                     fancam: "",
                                     endAt: "2022-07-29 22:00:00", // <--- TEST !!!
                                     provider: "")

        presentLauncher(launcher)
        launcher.launcherBtnTap = {
            self.instantwinDidTap?()
        }
    }

    /// Launcher Social
    func openLauncherSocial() {
        guard let data = self.mission?.data, let provider = data.provider else { return }

        let launcher = LauncherSocialView(height: 440)
        launcher.launcher = Launcher(title: L10n.missionSocialTitle,
                                     subTitle: L10n.missionSocialSubTitle,
                                     description: data.claim,
                                     questions: data.totalQuestions,
                                     time: data.seconds,
                                     coins: data.points,
                                     fancam: "",
                                     endAt: "2022-07-29 22:00:00", // <--- TEST !!!
                                     provider: provider)

        presentLauncher(launcher)
        launcher.launcherBtnTap = {
            self.socialDidTap?()
        }
    }

    /// Launcher main
    func presentLauncher(_ launcher: LauncherBaseBS) {
        backLayerView.removeFromSuperview()
        backLayerView.subviews.forEach { s in
            s.removeFromSuperview()
        }

        self.addSubview(backLayerView)
        backLayerView.edgeAnchors /==/ self.edgeAnchors
        backLayerView.alpha = 0
        self.layoutIfNeeded()

        UIView.animate(withDuration: 0.3) { [self] in
            backLayerView.alpha = 1
        } completion: { [self] _ in
            backLayerView.addSubview(launcher)

            launcher.dismiss = {
                dismissLauncher(launcher)
            }

            launcher.topAnchor /==/ backLayerView.bottomAnchor - 20
            launcher.rightAnchor /==/ backLayerView.rightAnchor - 10
            launcher.leftAnchor /==/ backLayerView.leftAnchor + 10
            launcher.centerXAnchor /==/ backLayerView.centerXAnchor
            launcher.heightAnchor /==/ launcher.getHeight()
            self.layoutIfNeeded()

//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 1) {
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1) {
                launcher.transform = .init(translationX: 0, y: -launcher.getHeight())
            }
        }
    }

    func dismissLauncher(_ launcher: LauncherBaseBS) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, animations: {
            launcher.transform = .identity
        }) { _ in
            self.dismiss?()
        }
    }
}
