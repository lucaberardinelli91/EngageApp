//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import Foundation

class FanCamRepository: FanCamRepositoryProtocol {
    private var networkingWorker: NetworkingDataSourceProtocol
    private var localStorageWorker: UserProtocol

    private var cancellables = Set<AnyCancellable>()

    private var capturedPhoto: Data?

    public init(networkingWorker: NetworkingDataSourceProtocol, localStorageWorker: UserProtocol) {
        self.networkingWorker = networkingWorker
        self.localStorageWorker = localStorageWorker
    }

    func saveCapturedPhoto(photo: Data) {
        capturedPhoto = photo
    }

    func getCapturedPhoto() -> AnyPublisher<Data, CustomError> {
        guard let capturedPhoto = capturedPhoto else {
            return Fail(error: CustomError.genericError(L10n.error))
                .eraseToAnyPublisher()
        }

        return Just(capturedPhoto)
            .setFailureType(to: CustomError.self)
            .eraseToAnyPublisher()
    }

    func uploadFancam(uploadId: String, photo: Data?, comment: String) -> AnyPublisher<Bool, CustomError> {
        let campaignId = localStorageWorker.getCampaignId()
        let encodablePhoto = EncodableImage(image: photo)
        return networkingWorker.uploadFancam(campaignId: campaignId, uploadId: uploadId, image: encodablePhoto, comment: comment)
            .map { _ in
                true
            }
            .eraseToAnyPublisher()
    }
}
