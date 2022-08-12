//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol ShareHelperProtocol {
    func share(title: String, url: String?)
    func shareImage(image: Data)
}
