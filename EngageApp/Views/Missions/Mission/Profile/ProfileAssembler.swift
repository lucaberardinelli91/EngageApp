//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol ProfileAssemblerInjector {
    func resolve() -> ProfileViewController

    func resolve() -> ProfileViewModel
}

public class ProfileAssembler: NSObject, ProfileAssemblerInjector {
    var container: MainContainerProtocol

    public init(container: MainContainerProtocol) {
        self.container = container
    }
}

public extension ProfileAssembler {
    func resolve() -> ProfileViewController {
        return ProfileViewController(viewModel: resolve())
    }

    func resolve() -> ProfileViewModel {
        return ProfileViewModel(getUserUseCase: container.getUserLocal, saveUserUseCase: container.saveUserLocal, deleteAccessTokenUseCase: container.deleteAccessToken, updatePrivacyConditions: container.updatePrivacyConditions)
    }
}
