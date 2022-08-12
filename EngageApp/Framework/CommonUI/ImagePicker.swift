//
//  EngageApp
//  Created by Luca Berardinelli
//

import AVFoundation
import Photos
import UIKit

// MARK: - ImagePicker

public class ImagePicker: NSObject {
    private weak var controller: UIImagePickerController?

    @Published public var grantedAccessState: LoadingState<(
        imagePicker: ImagePicker,
        grantedAccess: Bool,
        sourceType: UIImagePickerController.SourceType
    ), CustomError> = .idle

    @Published public var imageDidSelectState: LoadingState<(
        imagePicker: ImagePicker,
        image: UIImage
    ), Never> = .idle

    @Published public var cancelState: LoadingState<ImagePicker, Never> = .idle

    var isAccessGuaranteed = true
    public func dismiss() {
        controller?.dismiss(animated: true, completion: nil)
    }

    public func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
        DispatchQueue.main.async {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = sourceType
            self.controller = controller
            viewController.present(controller, animated: true, completion: nil)
        }
    }
}

// MARK: Get access to camera or photo library

public extension ImagePicker {
    func cameraAccessRequest() {
        grantedAccessState = .loading

        let source = UIImagePickerController.SourceType.camera
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            grantedAccessState = .success((imagePicker: self, grantedAccess: true, sourceType: source))
        } else {
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard let self = self else { return }
                self.grantedAccessState = .success((imagePicker: self, grantedAccess: granted, sourceType: source))
            }
        }
    }

    func photoGalleryAccessRequest() {
        PHPhotoLibrary.requestAuthorization { [weak self] result in
            guard let self = self else { return }
            self.grantedAccessState = .loading

            let source = UIImagePickerController.SourceType.photoLibrary
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                self.grantedAccessState = .success((imagePicker: self, grantedAccess: result == .authorized, sourceType: source))
            }
        }
    }
}

// MARK: UINavigationControllerDelegate

extension ImagePicker: UINavigationControllerDelegate {}

// MARK: UIImagePickerControllerDelegate

extension ImagePicker: UIImagePickerControllerDelegate {
    public func imagePickerController(
        _ pickerController: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let image = info[.editedImage] as? UIImage {
            imageDidSelectState = .success((imagePicker: self, image: image))
        } else if let image = info[.originalImage] as? UIImage {
            imageDidSelectState = .success((imagePicker: self, image: image))
        }
        pickerController.dismiss(animated: true)
    }

    public func imagePickerControllerDidCancel(_ pickerController: UIImagePickerController) {
        cancelState = .success(self)
        pickerController.dismiss(animated: true)
    }
}
