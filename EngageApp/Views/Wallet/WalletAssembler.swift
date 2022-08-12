//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public class WalletAssembler: WalletAssemblerInjector {
    var container: MainContainerProtocol
    var coins: Int?

    public init(container: MainContainerProtocol, coins: Int) {
        self.container = container
        self.coins = coins
    }
}

public protocol WalletAssemblerInjector {
    func resolve() -> WalletListViewController

    func resolve() -> WalletListViewModel
}

public extension WalletAssembler {
    func resolve() -> WalletListViewController {
        return WalletListViewController(viewModel: resolve())
    }

    func resolve() -> WalletListViewModel {
        return WalletListViewModel(getWalletUseCase: container.getWallet, coins: coins ?? 0)
    }
}
