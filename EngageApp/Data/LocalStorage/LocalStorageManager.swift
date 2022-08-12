//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Foundation
import KeychainAccess

public struct LocalStorageManager {
    public let user: UserProtocol = {
        let userCoreData = UserCoreDataHelper()
        let keychain = Keychain(service: Constants.appBundle)

        return UserDatabaseWorker(localStorageDB: userCoreData, localStorageKeychain: AuthWorker(keychain: keychain))
    }()
}
