//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import Foundation
import UIKit

public class LauncherViewController: BasePackedViewController<LauncherView, LauncherViewModel> {
    private var refreshControl = UIRefreshControl()
    public weak var launcherCoordinator: LauncherCoordinatorProtocol?

    public var mission: Mission? { didSet { didSetMission() }}

    override public init(viewModel: LauncherViewModel) {
        super.init(viewModel: viewModel)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        configureBinds()
        setInteractions()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    private func didSetMission() {
        guard let mission = mission, let type = mission.type, let id = mission.data?.id else { return }

        if type.contains("survey") {
            viewModel.getSurveyQuestions(surveyId: id)
        } else {
            _view.mission = mission
        }
    }

    private func setInteractions() {
        _view.dismiss = {
            self.dismiss(animated: true, completion: nil)
        }

        _view.quizDidTap = { [self] in
            guard let mission = mission else { return }
            self.dismiss(animated: true) {
                self.launcherCoordinator?.routeToQuiz(mission: mission)
            }
        }

        _view.surveyDidTap = { [self] in
            guard let surveyId = mission?.data?.id, let points = mission?.data?.points else { return }
            dismiss(animated: true) {
                launcherCoordinator?.routeToSurvey(surveyId: surveyId, points: points)
            }
        }

        _view.fancamDidTap = { [self] in
            guard let mission = mission else { return }
            self.dismiss(animated: true) {
                self.launcherCoordinator?.routeToFancam(mission: mission)
            }
        }

        _view.instantwinDidTap = { [self] in
            guard let mission = mission, let id = mission.data?.id else { return }

            viewModel.instantwinPlay(instantwinRandomId: id)
        }

        _view.infoDidTap = { info in
            self.dismiss(animated: true) {
                self.launcherCoordinator?.routeToLauncherInfo(info)
            }
        }

        _view.socialDidTap = {
            self.dismiss(animated: true) {
                // TODO:
            }
        }
    }
}

extension LauncherViewController {
    private func configureBinds() {
        handle(viewModel.$instantwinPlayState, success: { [self] result in
            guard let points = self.mission?.data?.points else { return }

            result.won ? self.launcherCoordinator?.routeToHome(feedback: (true, "\(points)")) : self.launcherCoordinator?.routeToHome(feedback: (false, ""))

            self.dismiss(animated: true, completion: nil)
        }, failure: { error in
            self.launcherCoordinator?.routeToHome(feedback: (false, ""))
            print("[ERROR] instant win play: \(error)")
        })

        handle(viewModel.$getSurveyQuestionsState, success: { totalQuestions in
            guard let totalQuestions = totalQuestions else { return }

            var mission = self.mission
            mission?.data?.totalQuestions = totalQuestions.count

            self._view.mission = mission
        })
    }
}
