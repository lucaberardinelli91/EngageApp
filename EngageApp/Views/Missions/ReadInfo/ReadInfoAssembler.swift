//
//  EngageApp
//  Created by Luca Berardinelli
//
import Foundation

public protocol ReadInfoAssemblerInjector {
    func resolve() -> ReadInfoViewController

    func resolve() -> ReadInfoViewModel
}

public class ReadInfoAssembler: NSObject, ReadInfoAssemblerInjector {
    var container: MainContainerProtocol

    public init(container: MainContainerProtocol) {
        self.container = container
    }
}

public extension ReadInfoAssembler {
    func resolve() -> ReadInfoViewController {
        return ReadInfoViewController(viewModel: resolve())
    }

    func resolve() -> ReadInfoViewModel {
        return ReadInfoViewModel(markInformationAsReadUseCase: container.markInformationAsRead)
    }
}
