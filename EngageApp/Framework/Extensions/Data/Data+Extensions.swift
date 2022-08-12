//
//  EngageApp
//  Created by Luca Berardinelli
//

import CryptoKit
import Foundation

public extension Data {
    // MARK: - Internal properties

    var md5: String? {
        let digest = Insecure.MD5.hash(data: self)

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }

    var sha256: String {
        return SHA256.hash(data: self).description
    }
}
