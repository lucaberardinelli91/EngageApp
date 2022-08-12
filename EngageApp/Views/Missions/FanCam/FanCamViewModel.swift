//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import UIKit

public protocol FanCamViewModelProtocol {
    func savePhoto(photo: UIImage)
    func uploadPhoto(photo: UIImage, comment: String)
}

public class FanCamViewModel: BaseViewModel, FanCamViewModelProtocol {
    @Published var uploadPhotoState: LoadingState<Void, CustomError> = .idle
    private let savePhotoUseCase: SaveFancamPhotoProtocol
    private let uploadPhotoUseCase: UploadFancamPhotoProtocol
    var mission: Mission

    public init(saveCapturedPhotoUseCase: SaveFancamPhotoProtocol, uploadPhotoUseCase: UploadFancamPhotoProtocol, mission: Mission) {
        savePhotoUseCase = saveCapturedPhotoUseCase
        self.uploadPhotoUseCase = uploadPhotoUseCase
        self.mission = mission
    }

    public func savePhoto(photo: UIImage) {
        guard let photoData = photo.pngData() else { return }
        savePhotoUseCase.execute(photo: photoData)
    }

    public func uploadPhoto(photo: UIImage, comment: String) {
        uploadPhotoState = .loading

        uploadPhotoUseCase.execute(uploadId: mission.data?.id ?? "", photo: photo.pngData(), comment: comment)
            .receive(on: RunLoop.main)
            .sink { [self] _ in
                uploadPhotoState = .success(())
            } receiveValue: { [self] _ in
                uploadPhotoState = .success(())
            }.store(in: &cancellables)
    }
}
