//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

/// Struct used to make HTTP multipart call.
public struct NetworkingMedia {
    public let data: Data
    public let key: String
    public let filename: String
    public let mimeType: String
    
    public init(data: Data, key: String, filename: String, mimeType: String) {
        self.data = data
        self.key = key
        self.filename = filename
        self.mimeType = mimeType
    }
}
