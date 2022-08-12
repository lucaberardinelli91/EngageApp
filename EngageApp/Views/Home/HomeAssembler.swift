//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol HomeAssemblerInjector {
    func resolve() -> HomeViewController

    func resolve() -> HomeViewModel
}

public class HomeAssembler: NSObject, HomeAssemblerInjector {
    var container: MainContainerProtocol

    public init(container: MainContainerProtocol) {
        self.container = container
    }
}

public extension HomeAssembler {
    func resolve() -> HomeViewController {
        return HomeViewController(viewModel: resolve())
    }

    func resolve() -> HomeViewModel {
        return HomeViewModel(getCampaignUseCase: container.getCampaign, saveCampaignIdUseCase: container.saveCampaignId, shareUseCase: container.share, getCampaigIdUseCase: container.getCampaignId, getUserUseCase: container.getUser, saveUserLocalUseCase: container.saveUserLocal, getUserLocalUseCase: container.getUserLocal)
    }
}
