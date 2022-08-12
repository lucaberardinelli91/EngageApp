//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import AVFoundation
import Combine
import UIKit

enum CapturePhotoState {
    case capture
    case send
}

public class FanCamView: BaseView {
    var flipCameraTap = PassthroughSubject<Void, Never>()
    var cheeseTap = PassthroughSubject<Void, Never>()
    var imageGalleyTap = PassthroughSubject<Void, Never>()
    var flashTap = PassthroughSubject<Void, Never>()
    var backTap = PassthroughSubject<Void, Never>()
    var infoTap = PassthroughSubject<Void, Never>()
    var closeTap = PassthroughSubject<Void, Never>()
    var saveWithCommentTap = PassthroughSubject<String, Never>()
    var saveWithoutCommentTap = PassthroughSubject<Void, Never>()
    var capturePhotoState: CapturePhotoState = .capture
    var isInfoOpen = false

    var controlsContainerView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = .black

        return view
    }()

    private var flashBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.setImage(AppAsset.fancamFlashOff.image, for: .normal)
        button.addTarget(self, action: #selector(flashDidTap), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.isEnabled = false

        return button
    }()

    private var infoBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.setImage(AppAsset.fancamInfoOff.image, for: .normal)
        button.addTarget(self, action: #selector(infoDidTap), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true

        return button
    }()

    private var closeBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.setImage(AppAsset.close.image.alpha(0.5), for: .normal)
        button.addTarget(self, action: #selector(closeDidTap), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true

        return button
    }()

    private var backBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.setImage(AppAsset.fancamBack.image, for: .normal)
        button.addTarget(self, action: #selector(backDidTap), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true

        return button
    }()

    private var cheeseBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.setImage(AppAsset.fancamCheese.image, for: .normal)
        button.addTarget(self, action: #selector(cheeseCameraDidTap), for: .touchUpInside)

        return button
    }()

    private var flipCamBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.setImage(AppAsset.fancamFront.image, for: .normal)
        button.addTarget(self, action: #selector(flipCameraDidTap), for: .touchUpInside)

        return button
    }()

    private var photoGalleryBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.contentMode = .scaleAspectFill
        button.setImage(AppAsset.fancamGalleryImages.image, for: .normal)
        button.addTarget(self, action: #selector(imageGalleryDidTap), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8

        return button
    }()

    lazy var addCommentView: FanCamAddCommentView = {
        var view = FanCamAddCommentView()
        view.saveWithoutCommentTap = { [self] in
            saveWithoutCommentTap.send()
        }
        view.saveWithCommentTap = { [self] comment in
            saveWithCommentTap.send(comment)
        }

        return view
    }()

    var infoView: FanCamInfoBS = {
        var view = FanCamInfoBS()

        return view
    }()

    private let backgroundLayerView: UIView = {
        var view = UIView()
        view.backgroundColor = ThemeManager.currentTheme().primaryColor.withAlphaComponent(0.5)

        return view
    }()

    public var previewContainerView: UIView = {
        var view = UIView()
        view.backgroundColor = .black

        return view
    }()

    private lazy var imageCapturedImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFill

        return imgView
    }()

    var imageCaptured: UIImage? { didSet { didSetImageCaptured() }}

    override func configureUI() {
        backgroundColor = .black

        addSubview(previewContainerView)
        addSubview(controlsContainerView)

        previewContainerView.addSubview(flashBtn)
        previewContainerView.addSubview(infoBtn)
        previewContainerView.addSubview(closeBtn)

        controlsContainerView.addSubview(photoGalleryBtn)
        controlsContainerView.addSubview(cheeseBtn)
        controlsContainerView.addSubview(flipCamBtn)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(recognizer:)))
        tapGesture.delegate = self
        addGestureRecognizer(tapGesture)
    }

    override func configureConstraints() {
        previewContainerView.topAnchor /==/ topAnchor
        previewContainerView.leftAnchor /==/ leftAnchor
        previewContainerView.rightAnchor /==/ rightAnchor
        previewContainerView.heightAnchor /==/ heightAnchor * 0.83

        flashBtn.leadingAnchor /==/ previewContainerView.leadingAnchor + 35
        flashBtn.topAnchor /==/ previewContainerView.topAnchor + 54
        flashBtn.widthAnchor /==/ 45
        flashBtn.heightAnchor /==/ 45

        infoBtn.topAnchor /==/ flashBtn.topAnchor
        infoBtn.centerXAnchor /==/ previewContainerView.centerXAnchor
        infoBtn.widthAnchor /==/ 45
        infoBtn.heightAnchor /==/ 45

        closeBtn.topAnchor /==/ flashBtn.topAnchor
        closeBtn.trailingAnchor /==/ previewContainerView.trailingAnchor - 35
        closeBtn.widthAnchor /==/ 45
        closeBtn.heightAnchor /==/ 45

        controlsContainerView.topAnchor /==/ previewContainerView.bottomAnchor
        controlsContainerView.bottomAnchor /==/ bottomAnchor
        controlsContainerView.leftAnchor /==/ leftAnchor
        controlsContainerView.rightAnchor /==/ rightAnchor

        photoGalleryBtn.leadingAnchor /==/ leadingAnchor + 35
        photoGalleryBtn.centerYAnchor /==/ controlsContainerView.centerYAnchor
        photoGalleryBtn.widthAnchor /==/ 50
        photoGalleryBtn.widthAnchor /==/ photoGalleryBtn.heightAnchor

        cheeseBtn.heightAnchor /==/ 85
        cheeseBtn.centerXAnchor /==/ centerXAnchor
        cheeseBtn.widthAnchor /==/ cheeseBtn.heightAnchor
        cheeseBtn.topAnchor /==/ controlsContainerView.topAnchor - 35

        flipCamBtn.trailingAnchor /==/ trailingAnchor - 35
        flipCamBtn.centerYAnchor /==/ controlsContainerView.centerYAnchor
        photoGalleryBtn.widthAnchor /==/ 50
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        previewContainerView.clipsToBounds = true
        previewContainerView.layer.cornerRadius = 10
        previewContainerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    func drawView() {
        configureUI()
        configureConstraints()
    }

    func setCameraIcon(cameraPosition: CameraPosition) {
        UIView.transition(with: flipCamBtn, duration: 0.5, options: [.allowUserInteraction, .curveEaseInOut, .transitionFlipFromRight]) {
            cameraPosition == .front ? self.flipCamBtn.setImage(AppAsset.fancamRear.image, for: .normal) : self.flipCamBtn.setImage(AppAsset.fancamFront.image, for: .normal)
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        imageCapturedImgView.clipsToBounds = true
        imageCapturedImgView.layer.cornerRadius = 10
    }

    @objc func flipCameraDidTap() {
        flashBtn.isEnabled = !flashBtn.isEnabled
        flipCamBtn.tapAnimation {
            self.flipCameraTap.send()
        }
    }

    @objc func cheeseCameraDidTap() {
        cheeseBtn.tapAnimation { [self] in
            switch capturePhotoState {
            case .capture:
                cheeseBtn.tapAnimation {
                    self.cheeseTap.send()
                }
                photoCaptured()
            case .send:
                break
            }
        }
    }

    private func enableButtons(_ isEnabled: Bool) {
        flashBtn.isEnabled = isEnabled
        infoBtn.isEnabled = isEnabled
        closeBtn.isEnabled = isEnabled
        photoGalleryBtn.isEnabled = isEnabled
        cheeseBtn.isEnabled = isEnabled
        flipCamBtn.isEnabled = isEnabled
    }

    private func showButtons(isHidden: Bool) {
        flashBtn.isHidden = isHidden
        flashBtn.isEnabled = isHidden
        backBtn.isHidden = !isHidden
        backBtn.isEnabled = isHidden
        infoBtn.isHidden = isHidden
        closeBtn.isHidden = !isHidden
        photoGalleryBtn.isHidden = isHidden
        flipCamBtn.isHidden = isHidden
    }

    private func photoCaptured() {
        cheeseBtn.isHidden = true
        closeBtn.setImage(AppAsset.fancamCloseCaptured.image, for: .normal)
        backBtn.setImage(AppAsset.fancamBackCaptured.image, for: .normal)
    }

    @objc func backDidTap() {
        backBtn.tapAnimation {
            self.backTap.send()
        }
    }

    @objc func flashDidTap() {
        flashBtn.tapAnimation {
            self.flashTap.send()
        }
    }

    @objc func infoDidTap() {
        infoBtn.tapAnimation {
            self.infoBtn.setImage(AppAsset.fancamInfoOn.image, for: .normal)
            self.presentInfoView()
        }
    }

    @objc func closeDidTap() {
        closeBtn.tapAnimation {
            self.closeTap.send()
        }
    }

    @objc func imageGalleryDidTap() {
        photoGalleryBtn.tapAnimation {
            GalleryHelper.checkGalleryPermission { authorized in
                authorized ? self.imageGalleyTap.send() : nil
            }
        }
    }

    private func didSetImageCaptured() {
        guard let imageCaptured = imageCaptured else { return }

        imageCapturedImgView.image = imageCaptured
        presentAddCommentView()
    }

    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let translatedPoint = cheeseBtn.convert(point, from: self)

        if cheeseBtn.bounds.contains(translatedPoint) {
            return cheeseBtn.hitTest(translatedPoint, with: event)
        }
        return super.hitTest(point, with: event)
    }

    @objc func handleTapGesture(recognizer _: UIPanGestureRecognizer) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, animations: {
            self.infoView.transform = .identity
        }) { _ in
            self.backgroundLayerView.removeFromSuperview()
            self.enableButtons(true)
            self.infoView.isHidden = true
            self.infoBtn.setImage(AppAsset.fancamInfoOff.image, for: .normal)
        }
    }
}

extension FanCamView {
    func presentAddCommentView() {
        addSubview(backgroundLayerView)
        backgroundLayerView.edgeAnchors /==/ edgeAnchors
        backgroundLayerView.alpha = 0
        layoutIfNeeded()

        backgroundLayerView.backgroundColor = ThemeManager.currentTheme().primaryColor

        UIView.animate(withDuration: 0.3) {
            self.backgroundLayerView.alpha = 1
        } completion: { _ in
            self.backgroundLayerView.addSubview(self.backBtn)
            self.backgroundLayerView.addSubview(self.closeBtn)
            self.backgroundLayerView.addSubview(self.imageCapturedImgView)
            self.backgroundLayerView.addSubview(self.addCommentView)

            self.showButtons(isHidden: true)

            self.backBtn.leadingAnchor /==/ self.backgroundLayerView.leadingAnchor + 35
            self.backBtn.topAnchor /==/ self.backgroundLayerView.topAnchor + 54
            self.backBtn.widthAnchor /==/ 45
            self.backBtn.heightAnchor /==/ 45

            self.backBtn.addTarget(self, action: #selector(self.dismissAddCommentView), for: .touchUpInside)

            self.closeBtn.topAnchor /==/ self.backgroundLayerView.topAnchor + 54
            self.closeBtn.trailingAnchor /==/ self.backgroundLayerView.trailingAnchor - 35
            self.closeBtn.widthAnchor /==/ 45
            self.closeBtn.heightAnchor /==/ 45

            self.addCommentView.heightAnchor /==/ UIScreen.main.bounds.height * 0.55
            self.addCommentView.rightAnchor /==/ self.backgroundLayerView.rightAnchor
            self.addCommentView.leftAnchor /==/ self.backgroundLayerView.leftAnchor
            self.addCommentView.bottomAnchor /==/ self.backgroundLayerView.bottomAnchor

            self.imageCapturedImgView.topAnchor /==/ self.topAnchor + 54
            self.imageCapturedImgView.widthAnchor /==/ 150
            self.imageCapturedImgView.centerXAnchor /==/ self.backgroundLayerView.centerXAnchor
            self.imageCapturedImgView.bottomAnchor /==/ self.addCommentView.topAnchor - 8
        }
    }

    @objc func dismissAddCommentView() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, animations: {
            self.addCommentView.transform = .identity
        }) { _ in
            self.backTap.send()
        }
    }
}

extension FanCamView {
    func presentInfoView() {
        addSubview(backgroundLayerView)
        backgroundLayerView.edgeAnchors /==/ edgeAnchors
        backgroundLayerView.alpha = 0
        layoutIfNeeded()

        UIView.animate(withDuration: 0.3) {
            self.backgroundLayerView.alpha = 1
        } completion: { _ in
            self.infoView.isHidden = false

            self.backgroundLayerView.addSubview(self.infoView)

            self.infoView.topAnchor /==/ self.infoBtn.bottomAnchor + 15
            self.infoView.rightAnchor /==/ self.backgroundLayerView.rightAnchor - 25
            self.infoView.leftAnchor /==/ self.backgroundLayerView.leftAnchor + 25
            self.infoView.heightAnchor /==/ self.infoView.getHeight()

            self.enableButtons(false)

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 1) {
                self.infoView.transform = .init(translationX: 0, y: 0)
            }
        }
    }
}

public enum CameraPosition {
    case front
    case rear
    case unknown
}
