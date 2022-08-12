//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public class FanCamAssembler: FanCamAssemblerInjector {
    var container: MainContainerProtocol
    var mission: Mission

    public init(container: MainContainerProtocol, mission: Mission) {
        self.container = container
        self.mission = mission
    }
}

public protocol FanCamAssemblerInjector {
    func resolve() -> FanCamViewController

    func resolve() -> FanCamViewModel
}

public extension FanCamAssembler {
    func resolve() -> FanCamViewController {
        return FanCamViewController(viewModel: resolve())
    }

    func resolve() -> FanCamViewModel {
        return FanCamViewModel(saveCapturedPhotoUseCase: container.saveFancamPhoto, uploadPhotoUseCase: container.uploadFancamPhoto, mission: mission)
    }
}
