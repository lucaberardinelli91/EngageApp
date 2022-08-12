//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Combine
import Foundation
import UIKit

public protocol WelcomeViewControllerProtocol {
    func checkEmail()
}

public class WelcomeViewController: BasePackedViewController<WelcomeView, WelcomeViewModel>, WelcomeViewControllerProtocol {
    public weak var welcomeCoordinator: WelcomeCoordinatorProtocol?

    override public init(viewModel: WelcomeViewModel) {
        super.init(viewModel: viewModel)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        setInteractions()
        configureBinds()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    public func checkEmail() {
        // MOCK API
        self.welcomeCoordinator?.routeToHome()
//        viewModel.checkEmail()
    }
}

extension WelcomeViewController {
    private func configureBinds() {
        _view.setConfigurator()

        handle(viewModel.$validateState, success: { inErrors in
            !inErrors.isEmpty ? (self._view.showEmailError()) : (self.checkEmail())
        })

        /// Check email
        handle(viewModel.$checkEmailState, success: { otp in
            self.viewModel.checkLoginByOtp(otp: otp)
        }, failure: { error in
            print("[ERROR] check email: \(error)")
            self.hideLoader()
        }, throwBaseError: false)

        /// Check OTP
        handle(viewModel.$checkLoginByOtpState, success: { token in
            self.viewModel.saveAccessToken(token: token)
        }, failure: { error in
            print("[ERROR] check login by otp: \(error)")
        })

        /// Save access token in KeyChain
        handle(viewModel.$saveAccesTokenState, success: { _ in
            self.welcomeCoordinator?.routeToHome()
        }, failure: { error in
            print("[ERROR] save access token: \(error)")
        })
    }

    private func bindView() {
        viewModel.bindView(view: _view)
    }

    private func setInteractions() {
        interaction(_view.continueButtonDidTap) { email in
            self.viewModel.email = email
            self.viewModel.validate()
        }

        interaction(_view.urlDidTap) { url in
            self.welcomeCoordinator?.routeTowebView(url: url)
        }

        interaction(_view.readEmailDidTap) { _ in
            MailHelper.shared.present(from: self)
        }
    }
}
