//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public class ShareHelper: ShareHelperProtocol {
    public static var shared: ShareHelperProtocol = ShareHelper()

    public func share(title: String, url: String? = nil) {
        let firstActivityItem = "\(title) \(url ?? "")"

//    guard let secondActivityItem = URL(string: url) else { return }

        let activityViewController = UIActivityViewController(activityItems: [firstActivityItem], applicationActivities: nil)

        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message,
            UIActivity.ActivityType.postToFacebook,
            UIActivity.ActivityType.postToTwitter,
            UIActivity.ActivityType.mail,
        ] as? UIActivityItemsConfigurationReading

        activityViewController.isModalInPresentation = true
        Utility.ApplicationHelper.getVisibleViewController()?.present(activityViewController, animated: true, completion: nil)
    }

    public func shareImage(image: Data) {
        if let _image = UIImage(data: image) {
            let imageShare = [_image]
            let activityViewController = UIActivityViewController(activityItems: imageShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = Utility.ApplicationHelper.getVisibleViewController()?.view

            Utility.ApplicationHelper.getVisibleViewController()?.present(activityViewController, animated: true, completion: nil)
        }
    }
}
