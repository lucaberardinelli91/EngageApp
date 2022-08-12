//
//  EngageApp
//  Created by Luca Berardinelli
//

import AVFoundation
import Foundation
import UIKit

class CameraController: NSObject {
    var captureSession: AVCaptureSession?
    var videoDevice: AVCaptureDevice?
    var previewLayer: AVCaptureVideoPreviewLayer?

    var videoOutput = AVCaptureVideoDataOutput()
    var photoOutput = AVCapturePhotoOutput()

    func prepare(cameraPosition: CameraPosition, completionHandler: @escaping (Error?) -> Void) {
        func createCaptureSession() {
            captureSession = AVCaptureSession()
        }

        func configureCaptureDevices() throws {
            guard UIImagePickerController.isCameraDeviceAvailable(.front), UIImagePickerController.isCameraDeviceAvailable(.rear) else {
                return
            }
            guard let vd = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraPosition == .front ? .front : .back) else { fatalError("No dual camera.") }
            videoDevice = vd
        }

        func configureDeviceInputs() throws {
            if captureSession == nil {
                throw CustomError.cameraPermissionDenied
            }
            captureSession?.beginConfiguration()

            guard let videoDevice = videoDevice else { throw CustomError.cameraPermissionDenied }
            guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { throw CustomError.cameraPermissionDenied }
            guard let captureSession = captureSession else { throw CustomError.cameraPermissionDenied }
            guard captureSession.canAddInput(videoDeviceInput) else { throw CustomError.cameraPermissionDenied }
            captureSession.addInput(videoDeviceInput)
            captureSession.commitConfiguration()
        }

        func configurePhotoOutput() throws {
            guard let captureSession = captureSession else {
                return
            }
            captureSession.beginConfiguration()

            photoOutput = AVCapturePhotoOutput()
            photoOutput.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])], completionHandler: nil)

            guard captureSession.canAddOutput(photoOutput)
            else { throw CustomError.cameraPermissionDenied }
            captureSession.addOutput(photoOutput)

            captureSession.sessionPreset = .photo
            captureSession.commitConfiguration()

            captureSession.startRunning()
        }

        DispatchQueue(label: "prepare", qos: .userInitiated).async {
            do {
                createCaptureSession()
                try configureCaptureDevices()
                try configureDeviceInputs()
                try configurePhotoOutput()
            } catch {
                DispatchQueue.main.async {
                    completionHandler(error)
                }

                return
            }

            DispatchQueue.main.async {
                completionHandler(nil)
            }
        }
    }

    func displayPreview(on view: UIView) throws {
        guard let captureSession = captureSession, captureSession.isRunning else {
            return
        }

        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer?.videoGravity = .resizeAspectFill
        self.previewLayer?.connection?.videoOrientation = .portrait
        guard let previewLayer = previewLayer else { return }

        view.layer.insertSublayer(previewLayer, at: 0)
        self.previewLayer?.frame = view.frame
    }

    func removeDisplayPreview(on view: UIView) throws {
        guard let sublayers = view.layer.sublayers else { return }

        for layer in sublayers {
            if layer is AVCaptureVideoPreviewLayer {
                layer.removeFromSuperlayer()
                break
            }
        }
    }

    func captureImage(delegate: AVCapturePhotoCaptureDelegate) {
        let photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        photoOutput.capturePhoto(with: photoSettings, delegate: delegate)
    }

    func pause() {
        previewLayer?.connection?.isEnabled = false
    }

    func resume() {
        previewLayer?.connection?.isEnabled = true
    }

    func stopRunning() {
        if captureSession?.isRunning ?? false {
            captureSession?.stopRunning()
        }
        videoDevice = nil
        previewLayer?.removeFromSuperlayer()
        previewLayer = nil
        captureSession = nil
    }

    func switchCamera() {
        captureSession?.beginConfiguration()
        guard let currentInput = captureSession?.inputs.first as? AVCaptureDeviceInput else { return }
        captureSession?.removeInput(currentInput)

        guard let newCameraDevice = currentInput.device.position == .back ? getCamera(with: .front) : getCamera(with: .back) else { return }

        guard let newVideoInput = try? AVCaptureDeviceInput(device: newCameraDevice) else { return }
        captureSession?.addInput(newVideoInput)
        captureSession?.commitConfiguration()
    }

    func getCameraPosition() -> CameraPosition {
        guard let currentInput = captureSession?.inputs.first as? AVCaptureDeviceInput else { return .unknown }
        if currentInput.device.position == .back {
            return .front
        } else {
            return .rear
        }
    }
}

extension CameraController {
    func getCamera(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let devices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: position)

        return devices.devices.filter {
            $0.position == position
        }.first
    }
}
