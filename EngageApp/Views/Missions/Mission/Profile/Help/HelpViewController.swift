//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import Foundation
import UIKit

public protocol HelpViewControllerProtocol {}

public class HelpViewController: BasePackedViewController<HelpView, HelpViewModel>, HelpViewControllerProtocol {
    public weak var helpCoordinator: HelpCoordinatorProtocol?

    override public init(viewModel: HelpViewModel) {
        super.init(viewModel: viewModel)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        setInteractions()

        /// Hide navigation bar
        navigationController?.isNavigationBarHidden = true
    }

    private func setInteractions() {
        interaction(_view.closeTap) {
            self.dismiss(animated: true, completion: nil)
        }

        interaction(_view.goToWebTap) {
            self.helpCoordinator?.routeTowebView(url: URL(string: "https://www.google.it")!)
        }

        interaction(_view.tosTap) {
            self.helpCoordinator?.routeTowebView(url: URL(string: "https://www.google.it")!)
        }

        interaction(_view.phoneTap) {
            if let url = URL(string: "tel://0230416161") {
                UIApplication.shared.openURL(url)
            }
        }

        interaction(_view.emailTap) {
            MailHelper.shared.present(from: self)
        }
    }
}
