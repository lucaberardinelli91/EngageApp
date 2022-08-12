//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import Foundation
import UIKit

public class ReadInfoViewController: BasePackedViewController<ReadInfoView, ReadInfoViewModel> {
    public weak var launcherCoordinator: LauncherCoordinatorProtocol?
    public var info: LauncherInfo? { didSet { didSetInfo() }}

    override public init(viewModel: ReadInfoViewModel) {
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

    private func setInteractions() {
        interaction(_view.closeTap) { _ in
            self.navigationController?.popViewController(animated: true)
        }

        interaction(_view.markAsReadTap) { [self] _ in
            guard let infoId = info?.id else { return }

            viewModel.markInformationAsRead(infoId: infoId)
        }
    }

    private func didSetInfo() {
        _view.info = info
    }
}

extension ReadInfoViewController {
    private func configureBinds() {
        handle(viewModel.$markInformationAsReadState, success: { [self] _ in
            self.launcherCoordinator?.routeToHome(feedback: (true, self.info?.coins ?? ""))
        }, failure: { error in
            self.launcherCoordinator?.routeToHome(feedback: (false, ""))
            print("[ERROR] mark information as read: \(error)")
        })
    }
}
