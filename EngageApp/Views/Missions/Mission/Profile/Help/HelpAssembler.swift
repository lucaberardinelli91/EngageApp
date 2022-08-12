//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol HelpAssemblerInjector {
    func resolve() -> HelpViewController

    func resolve() -> HelpViewModel
}

public class HelpAssembler: NSObject, HelpAssemblerInjector {
    var container: MainContainerProtocol

    public init(container: MainContainerProtocol) {
        self.container = container
    }
}

public extension HelpAssembler {
    func resolve() -> HelpViewController {
        return HelpViewController(viewModel: resolve())
    }

    func resolve() -> HelpViewModel {
        return HelpViewModel()
    }
}
