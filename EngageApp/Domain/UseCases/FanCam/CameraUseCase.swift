//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import Foundation

public protocol SaveFancamPhotoProtocol {
    func execute(photo: Data)
}

public protocol GetFancamPhotoProtocol {
    func execute() -> AnyPublisher<Data, CustomError>
}

public protocol UploadFancamPhotoProtocol {
    func execute(uploadId: String, photo: Data?, comment: String) -> AnyPublisher<Bool, CustomError>
}

enum CameraUseCase {
    public class SaveCapturedPhoto: SaveFancamPhotoProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var fanCamRepository: FanCamRepositoryProtocol

        public init(fanCamRepository: FanCamRepositoryProtocol) {
            self.fanCamRepository = fanCamRepository
        }

        public func execute(photo: Data) {
            fanCamRepository.saveCapturedPhoto(photo: photo)
        }
    }

    public class GetCapturedPhoto: GetFancamPhotoProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var fanCamRepository: FanCamRepositoryProtocol

        public init(fanCamRepository: FanCamRepositoryProtocol) {
            self.fanCamRepository = fanCamRepository
        }

        public func execute() -> AnyPublisher<Data, CustomError> {
            return fanCamRepository.getCapturedPhoto()
        }
    }

    public class UploadFancamPhoto: UploadFancamPhotoProtocol {
        private var cancellables = Set<AnyCancellable>()

        private var fanCamRepository: FanCamRepositoryProtocol

        public init(fanCamRepository: FanCamRepositoryProtocol) {
            self.fanCamRepository = fanCamRepository
        }

        public func execute(uploadId: String, photo: Data?, comment: String) -> AnyPublisher<Bool, CustomError> {
            return fanCamRepository.uploadFancam(uploadId: uploadId, photo: photo, comment: comment)
        }
    }
}
