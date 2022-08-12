//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import Photos
import UIKit

public enum GalleryHelper {
    public static func loadLastImageThumb(completion: @escaping (UIImage) -> Void) {
        let imgManager = PHImageManager.default()
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 1
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let fetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)

        if let last = fetchResult.lastObject {
            let scale = UIScreen.main.scale
            let size = CGSize(width: 100 * scale, height: 100 * scale)
            let options = PHImageRequestOptions()

            imgManager.requestImage(for: last, targetSize: size, contentMode: PHImageContentMode.aspectFill, options: options, resultHandler: { image, _ in
                if let image = image {
                    completion(image)
                }
            })
        }
    }

    public static func checkGalleryPermission(completion: @escaping (Bool) -> Void) {
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined || photos == .denied || photos == .restricted {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        } else if photos == .authorized {
            completion(true)
        }

        completion(false)
    }
}
