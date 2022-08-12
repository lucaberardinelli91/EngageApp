//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Combine
import Foundation

// MARK: - UserDatabaseWorker

class UserDatabaseWorker: UserProtocol {
    // MARK: - Protocol properties

    var localStorageDB: UserCoreDataHelper
    private var localStorageKeychain: AuthWorker

    // MARK: - Object lifecycle

    init(localStorageDB: UserCoreDataHelper, localStorageKeychain: AuthWorker) {
        self.localStorageDB = localStorageDB
        self.localStorageKeychain = localStorageKeychain
    }

    func getUser() -> AnyPublisher<UserInfo?, CustomError> {
        return Future { promise in
            guard let user = self.localStorageDB.getUser().first else {
                promise(.success(nil))
                return
            }
            promise(.success(self.mapToUserDomainModel(user: user)))
        }.eraseToAnyPublisher()
    }

    func saveUser(user: UserInfo) -> AnyPublisher<Bool, CustomError> {
        return Future { promise in
            self.localStorageDB.saveUser(user: user)
            promise(.success(true))
        }.eraseToAnyPublisher()
    }

    // MARK: - Campaign Id

    func getCampaignId() -> String {
        return localStorageKeychain.campaignId
    }

    func saveCampaignId(id: String) -> AnyPublisher<Bool, CustomError> {
        return Future { promise in
            self.localStorageKeychain.campaignId = id

            promise(.success(true))
        }.eraseToAnyPublisher()
    }

    // MARK: - Access token

    func getAccessToken() -> TokenKeyChain? {
        guard let accessToken = localStorageKeychain.accessToken,
              let expiresIn = localStorageKeychain.accessTokenExpiresIn
        else { return nil }

        let token = TokenKeyChain(accessToken: accessToken,
                                  expiresIn: expiresIn)
        return token
    }

    func saveAccessToken(token: LoginByOtpToken) -> AnyPublisher<Bool, CustomError> {
        return Future { promise in
            self.localStorageKeychain.accessToken = token.accessToken

            let expiresInDays = token.expiresIn / 86400

            guard let expiresInDate = Calendar.current.date(byAdding: .day, value: expiresInDays, to: Date()) else { return }
            self.localStorageKeychain.accessTokenExpiresIn = "\(expiresInDate)"

            promise(.success(true))
        }.eraseToAnyPublisher()
    }

    func deleteAccessToken() -> AnyPublisher<Void, CustomError> {
        return Future { promise in
            self.localStorageKeychain.accessToken = "_"
            self.localStorageKeychain.accessTokenExpiresIn = ""

            promise(.success(()))
        }.eraseToAnyPublisher()
    }
}

extension UserDatabaseWorker {
    func mapToUserDomainModel(user: User) -> UserInfo {
        return UserInfo(agreeTerms: user.agreeTerms, agreeMarketing: user.agreeMarketing, agreeMarketingThirdParty: user.agreeMarketingThirdParty, agreeProfiling: user.agreeProfiling, agreeProfilingThirdParty: user.agreeProfilingThirdParty, agreeNewsletter: user.agreeNewsletter, id: "\(user.id)")
//        return UserDomainModel(agreeTerms: user.agreeTerms, agreeMarketing: user.agreeMarketing, agreeMarketingThirdParty: user.agreeMarketingThirdParty, agreeProfiling: user.agreeProfiling, agreeSMS: user.agreeSMS, agreeProfilingThirdParty: user.agreeProfilingThirdParty, agreeNewsletter: user.agreeNewsletter, email: user.email, firstName: user.firstName, lastName: user.lastName, fullName: user.fullName, id: Int(user.id), birthday: user.birthday, gender: user.gender, country: user.country, phone: user.phone, picture: user.picture, roles: user.mebershipLevels as? [String])
    }
}
