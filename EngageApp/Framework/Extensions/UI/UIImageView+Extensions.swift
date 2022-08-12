//
//  EngageApp
//  Created by Luca Berardinelli
//

import AVFoundation
import Foundation
import SDWebImage
import UIKit

public extension UIImageView {
    func tryWithImageFromYoutube(url: URL) {
        func getYoutubeId(youtubeUrl: String) -> String? {
            return URLComponents(string: youtubeUrl)?.queryItems?.first(where: { $0.name == "v" })?.value
        }

        if let youtubeID = getYoutubeId(youtubeUrl: url.absoluteString) {
            let imageURL = "https://img.youtube.com/vi/\(youtubeID)/0.jpg"
            sd_setImage(with: URL(string: imageURL)) { image, _, _, _url in
                SDImageCache.shared.store(image, forKey: _url?.absoluteString)
            }
        }
    }

    func tryWithImageFromVideo(url: URL, at time: TimeInterval) {
        DispatchQueue.global(qos: .background).async {
            let asset = AVAsset(url: url)
            let assetImgGenerate = AVAssetImageGenerator(asset: asset)
            assetImgGenerate.appliesPreferredTrackTransform = true
            let _time = CMTimeMakeWithSeconds(time, preferredTimescale: 60)
            let times = [NSValue(time: _time)]
            assetImgGenerate.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    let uiImage = UIImage(cgImage: image)
                    /// Store video thumbnail in `SDImageCache`
                    SDImageCache.shared.store(uiImage, forKey: url.absoluteString)
                    DispatchQueue.main.async {
                        self.image = uiImage
                    }
                }
            })
        }
    }

    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: @escaping (UIImage) -> Void) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            completion(image)
        }.resume()
    }

    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode) { image in
            completion(image)
        }
    }
}
