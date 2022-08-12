//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import UIKit

public protocol UserViewModelProtocol {
    func getUser()
    func saveUser(_ privacyFlags: PrivacyFlags)
    func deleteAccessToken()
}

public class ProfileViewModel: BaseViewModel, UserViewModelProtocol {
    private let getUserUseCase: GetUserLocalProtocol
    private let saveUserUseCase: SaveUserLocalProtocol
    private let deleteAccessTokenUseCase: DeleteAccessTokenProtocol
    private let updatePrivacyConditions: UpdatePrivacyConditionsProtocol

    @Published var getUserState: LoadingState<PrivacyFlags?, CustomError> = .idle
    @Published var deleteAccessTokenState: LoadingState<Void, CustomError> = .idle
    @Published var updatePrivacyConditionsState: LoadingState<Void, CustomError> = .idle

    public init(getUserUseCase: GetUserLocalProtocol, saveUserUseCase: SaveUserLocalProtocol, deleteAccessTokenUseCase: DeleteAccessTokenProtocol, updatePrivacyConditions: UpdatePrivacyConditionsProtocol) {
        self.getUserUseCase = getUserUseCase
        self.saveUserUseCase = saveUserUseCase
        self.deleteAccessTokenUseCase = deleteAccessTokenUseCase
        self.updatePrivacyConditions = updatePrivacyConditions
    }

    public func getUser() {
        getUserState = .loading
        let agreeNewsletter = UserDefaults.standard.object(forKey: "agreeNewsletter") as? Bool
        let agreeMarketing = UserDefaults.standard.object(forKey: "agreeMarketing") as? Bool
        let agreeMarketingThirdParty = UserDefaults.standard.object(forKey: "agreeMarketingThirdParty") as? Bool
        let agreeProfiling = UserDefaults.standard.object(forKey: "agreeProfiling") as? Bool
        let agreeTerms = UserDefaults.standard.object(forKey: "agreeTerms") as? Bool

        let flags = PrivacyFlags(agreeNewsletter: agreeNewsletter ?? false,
                                 agreeMarketing: agreeMarketing ?? false,
                                 agreeMarketingThirdParty: agreeMarketingThirdParty ?? false,
                                 agreeProfiling: agreeProfiling ?? false,
                                 agreeTerms: true)

        getUserState = .success(flags)
    }

    public func saveUser(_ privacyFlags: PrivacyFlags) {
        //        updatePrivacyConditionsState = .loading
        //
        //        updatePrivacyConditions.execute(privacyFlags: privacyFlags)
        //            .receive(on: RunLoop.main)
        //            .sink { completion in
        //                guard case let .failure(error) = completion else { return }
        //                self.updatePrivacyConditionsState = .failure(error)
        //            } receiveValue: { [self] _ in
        //                // save local
        //                UserDefaults.standard.set(privacyFlags.agreeNewsletter, forKey: "agreeNewsletter")
        //                UserDefaults.standard.set(privacyFlags.agreeMarketing, forKey: "agreeMarketing")
        //                UserDefaults.standard.set(privacyFlags.agreeMarketingThirdParty, forKey: "agreeMarketingThirdParty")
        //                UserDefaults.standard.set(privacyFlags.agreeProfiling, forKey: "agreeProfiling")
        //                UserDefaults.standard.set(privacyFlags.agreeTerms, forKey: "agreeTerms")
        //
        //                updatePrivacyConditionsState = .success(())
        //            }.store(in: &cancellables)

        UserDefaults.standard.set(privacyFlags.agreeNewsletter, forKey: "agreeNewsletter")
        UserDefaults.standard.set(privacyFlags.agreeMarketing, forKey: "agreeMarketing")
        UserDefaults.standard.set(privacyFlags.agreeMarketingThirdParty, forKey: "agreeMarketingThirdParty")
        UserDefaults.standard.set(privacyFlags.agreeProfiling, forKey: "agreeProfiling")
        UserDefaults.standard.set(privacyFlags.agreeTerms, forKey: "agreeTerms")
    }

    public func deleteAccessToken() {
        deleteAccessTokenState = .loading

        deleteAccessTokenUseCase.execute()
            .receive(on: RunLoop.main)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.deleteAccessTokenState = .failure(error)
            } receiveValue: { [self] _ in
                deleteAccessTokenState = .success(())
            }.store(in: &cancellables)
    }
}
