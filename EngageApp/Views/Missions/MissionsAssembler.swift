//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public class MissionsAssembler: NSObject, MissionsAssemblerInjector {
    var container: MainContainerProtocol
    var coins: Int?

    public init(container: MainContainerProtocol, coins: Int) {
        self.container = container
        self.coins = coins
    }
}

public protocol MissionsAssemblerInjector {
    func resolve() -> MissionsListViewController

    func resolve() -> MissionsListViewModel
}

public extension MissionsAssembler {
    func resolve() -> MissionsListViewController {
        return MissionsListViewController(viewModel: resolve())
    }

    func resolve() -> MissionsListViewModel {
        return MissionsListViewModel(getMissionsUseCase: container.getMissions, coins: coins ?? 0)
    }
}
