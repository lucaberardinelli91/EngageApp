//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public class WebViewAssembler: WebViewAssemblerInjector {
    var container: MainContainerProtocol
    var url: URL
    var title: String?

    public init(container: MainContainerProtocol, url: URL, title: String?) {
        self.container = container
        self.url = url
        self.title = title
    }
}

public protocol WebViewAssemblerInjector {
    func resolve() -> WebViewViewController

    func resolve() -> WebViewViewModel
}

public extension WebViewAssembler {
    func resolve() -> WebViewViewController {
        return WebViewViewController(viewModel: resolve())
    }

    func resolve() -> WebViewViewModel {
        return WebViewViewModel(url: url, title: title)
    }
}
