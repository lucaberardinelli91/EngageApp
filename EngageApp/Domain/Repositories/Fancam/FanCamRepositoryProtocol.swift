//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import Foundation

public protocol FanCamRepositoryProtocol {
    func saveCapturedPhoto(photo: Data)
    func getCapturedPhoto() -> AnyPublisher<Data, CustomError>
    func uploadFancam(uploadId: String, photo: Data?, comment: String) -> AnyPublisher<Bool, CustomError>
}
