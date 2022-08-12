//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public struct UploadImageRequest: Encodable {
    var uploadedContent: Data?
    var comment: String?

    init(uploadedContent: Data, comment: String) {
        self.uploadedContent = uploadedContent
        self.comment = comment
    }
}
