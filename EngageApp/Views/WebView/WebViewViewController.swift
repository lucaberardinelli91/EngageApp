//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import Foundation
import UIKit
import WebKit

public protocol WebViewControllerProtocol {
    func getURLAndTitle()

    var delegate: WebViewDelegate? { get set }
}

public class WebViewViewController: BasePackedViewController<WebViewView, WebViewViewModel>, WebViewControllerProtocol {
    public weak var delegate: WebViewDelegate?

    override public init(viewModel: WebViewViewModel) {
        super.init(viewModel: viewModel)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        configureBinds()

        stylizeNavigationBar()
        addsCloseButton = true

        getURLAndTitle()
    }

    override public func closeAction() {
        delegate?.onDisappear()

        if isModal {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.async {
            self.delegate?.onAppear()
        }
    }

    public func getURLAndTitle() {
        viewModel.getTitleFromURL()
    }
}

extension WebViewViewController {
    private func configureBinds() {
        handle(viewModel.$getURLState, success: { url, title in
            self._view.load(url: url)
            self.title = title
        })
    }

    private func stylizeNavigationBar() {
        ThemeManager.applyOpaqueTheme(to: navigationController)
    }
}
