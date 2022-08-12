//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

// MARK: - CheckEmail

public struct CheckEmail {
    public let otp: String

    init(checkEmailDataSource: CheckEmailDataSource) {
        otp = checkEmailDataSource.otp
    }
}
