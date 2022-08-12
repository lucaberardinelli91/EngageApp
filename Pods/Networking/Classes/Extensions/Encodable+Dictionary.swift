//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

internal extension Encodable {
    
    /// Transform an Encodable in a dictionary. It's used to encode object in HTTP body.
    var dictionary: [AnyHashable: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return nil
        }
        
        return dictionary
    }
    
}
