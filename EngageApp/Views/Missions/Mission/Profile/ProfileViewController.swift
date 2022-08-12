//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import AVFoundation
import Combine
import Foundation
import UIKit

public protocol UserViewControllerProtocol {}

public class ProfileViewController: BasePackedViewController<ProfileView, ProfileViewModel>, UserViewControllerProtocol, UIImagePickerControllerDelegate {
    public weak var profileCoordinator: ProfileCoordinatorProtocol?
    private let imagePicker = ImagePicker()
    public var userInfo: UserInfo? { didSet { didSetUserInfo() }}

    override public init(viewModel: ProfileViewModel) {
        super.init(viewModel: viewModel)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        configureBinds()
        setInteractions()

        loadUserImage()

        navigationController?.isNavigationBarHidden = true
    }

    private func setInteractions() {
        interaction(_view.userImgTap) { _ in
            self.imagePicker.photoGalleryAccessRequest()
        }

        handle(imagePicker.$imageDidSelectState, success: { _, image in
            UIImage.saveImageToDocumentDirectory(image: image)
            self._view.userImg = image
        })

        handle(imagePicker.$grantedAccessState, success: { imagePicker, grantedAccess, sourceType in
            if !grantedAccess {
                self.errorHandler?.throw(CustomError.cameraPermissionDenied)
            } else {
                DispatchQueue.main.async {
                    imagePicker.present(parent: self, sourceType: sourceType)
                }
            }
        })

        interaction(_view.backTap) {
            let transition = CATransition()
            transition.duration = 0.2
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
            self.view.window!.layer.add(transition, forKey: nil)
            self.dismiss(animated: false, completion: nil)
        }

        interaction(_view.helpTap) {
            self.profileCoordinator?.routeToHelp()
        }

        interaction(_view.logoutTap) {
            self.viewModel.deleteAccessToken()
        }

        interaction(_view.tosTap) {
            self.viewModel.getUser()
        }

        interaction(_view.tosUrlTap) { url in
            self.profileCoordinator?.routeTowebView(url: url)
        }

        interaction(_view.dismiss) { privacyFlags in
            self.viewModel.saveUser(privacyFlags)
        }
    }

    private func didSetUserInfo() {
        guard let userInfo = userInfo else { return }
        _view.userInfo = userInfo
    }

    private func loadUserImage() {
        guard let userImg = UIImage.loadImageFromDocumentDirectory(nameOfImage: "user_image") else { return }
        _view.userImg = userImg
    }

    private func configureBinds() {
        handle(viewModel.$deleteAccessTokenState, success: { [self] _ in
            self.profileCoordinator?.routeToWelcome()
        }, failure: { error in
            print("[ERROR] delete access token: \(error)")
        })

        handle(viewModel.$getUserState, success: { [self] privacyFlags in
            self._view.presentPrivacyTermsView(with: Privacy.getPrivacyConditions(), privacyFlags: privacyFlags)
        }, failure: { error in
            print("[ERROR] get user: \(error)")
        })
    }
}
