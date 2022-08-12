//
//  EngageApp
//  Created by Luca Berardinelli
//

import AVFoundation
import Combine
import UIKit

public protocol FanCamViewControllerProtocol {
    func saveCapturedPhoto(photo: UIImage)
}

public class FanCamViewController: BasePackedViewController<FanCamView, FanCamViewModel>, FanCamViewControllerProtocol {
    public weak var fanCamCoordinator: FanCamCoordinatorProtocol?
    var cameraController = CameraController()
    private let imagePicker = ImagePicker()
    private var canPrepareCaptureSession = false
    private var photo: UIImage?

    override public init(viewModel: FanCamViewModel) {
        super.init(viewModel: viewModel)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        configureBinds()
        setInteractions()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        drawView()
        navigationController?.isNavigationBarHidden = true
    }

    public func prepareCaptureSession() {
        cameraController.prepare(cameraPosition: .front) { error in
            if let error = error {
                self.errorHandler?.throw(error)
                return
            }
            try? self.cameraController.displayPreview(on: self._view.previewContainerView)
        }
    }

    public func saveCapturedPhoto(photo: UIImage) {
        self.photo = photo
        viewModel.savePhoto(photo: photo)
    }

    private func drawView() {
        canPrepareCaptureSession = true

        _view.drawView()
        _view.infoView.subtitleLbl.text = viewModel.mission.data?.schedules?[0].claim

        DispatchQueue.main.async {
            self.prepareCaptureSession()
        }
    }

    private func closeFanCam() {
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)

        cameraController.stopRunning()
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                if device.torchMode == AVCaptureDevice.TorchMode.on {
                    device.torchMode = AVCaptureDevice.TorchMode.off
                }
                device.unlockForConfiguration()
            } catch {
                errorHandler?.throw(error)
            }
        }
    }

    public func photoOutput(_: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error _: Error?) {
        guard let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData) else { return }
        saveCapturedPhoto(photo: image.fixOrientation())
        _view.imageCaptured = image

        cameraController.stopRunning()
    }

    private func configureBinds() {
        handle(viewModel.$uploadPhotoState, success: { [self] _ in
            fanCamCoordinator?.routeToHome(feedback: (true, "\(viewModel.mission.data?.points ?? 0)"))
        }, failure: { error in
            print("[ERROR] upload image fancam: \(error)")
        })
    }
}

extension FanCamViewController: AVCapturePhotoCaptureDelegate {
    private func setInteractions() {
        interaction(_view.flipCameraTap) { _ in
            self.cameraController.switchCamera()
            let cameraPosition = self.cameraController.getCameraPosition()
            let orientation = cameraPosition == .rear ? true : false

            self._view.setCameraIcon(cameraPosition: cameraPosition)
        }

        interaction(_view.cheeseTap) { _ in
            self.cameraController.captureImage(delegate: self)
        }

        interaction(_view.imageGalleyTap) { _ in
            self.imagePicker.photoGalleryAccessRequest()
        }

        interaction(_view.closeTap) { _ in
            self.closeFanCam()
        }

        interaction(_view.flashTap) { _ in
            self.flashButtonDidTap()
        }

        interaction(_view.backTap) { _ in
            self.fanCamCoordinator?.start()
        }

        interaction(_view.saveWithCommentTap) { comment in
            guard let photo = self.photo else { return }
            self.viewModel.uploadPhoto(photo: photo, comment: comment)
        }

        interaction(_view.saveWithoutCommentTap) { _ in
            guard let photo = self.photo else { return }
            self.viewModel.uploadPhoto(photo: photo, comment: "")
        }

        handle(imagePicker.$grantedAccessState, success: { imagePicker, grantedAccess, sourceType in
            if !grantedAccess {
                self.errorHandler?.throw(CustomError.cameraPermissionDenied)
            } else {
                DispatchQueue.main.async {
                    imagePicker.present(parent: self, sourceType: sourceType)
                }
            }
        })

        imagePicker.$cancelState
            .sink { state in
                self.handleState(state: state, showLoader: false) { imagePicker in
                    imagePicker.dismiss()
                }
            }
            .store(in: &cancellables)

        handle(imagePicker.$imageDidSelectState, success: { _, image in
            self.saveCapturedPhoto(photo: image.fixOrientation())
            self._view.imageCaptured = image
        })
    }

    @objc private func flashButtonDidTap() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                if device.torchMode == AVCaptureDevice.TorchMode.on {
                    device.torchMode = AVCaptureDevice.TorchMode.off
                } else {
                    do {
                        try device.setTorchModeOn(level: 1.0)
                    } catch {
                        errorHandler?.throw(error)
                    }
                }
                device.unlockForConfiguration()
            } catch {
                errorHandler?.throw(error)
            }
        }
    }
}
