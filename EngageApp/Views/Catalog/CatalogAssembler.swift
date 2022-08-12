//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public class CatalogAssembler: NSObject, CatalogAssemblerInjector {
    public var container: MainContainerProtocol
    public var fromRedeem: Bool = false
    public var coins: Int?

    public init(container: MainContainerProtocol, coins: Int, fromRedeem: Bool = false) {
        self.container = container
        self.fromRedeem = fromRedeem
        self.coins = coins
    }
}

public protocol CatalogAssemblerInjector {
    func resolve() -> CatalogViewController

    func resolve() -> CatalogViewModel
}

public extension CatalogAssembler {
    func resolve() -> CatalogViewController {
        return CatalogViewController(viewModel: resolve())
    }

    func resolve() -> CatalogViewModel {
        return CatalogViewModel(getCatalogUseCase: container.getCatalog, coins: coins ?? 0, fromRedeem: fromRedeem)
    }
}
