//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct CheckEmailPost: Codable {
    var email: String?

    public init(email: String?) {
        self.email = email
    }
}
