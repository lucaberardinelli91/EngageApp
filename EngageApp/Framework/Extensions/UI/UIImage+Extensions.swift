//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }

    func addFilter(filter: FilterType) -> UIImage {
        let filter = CIFilter(name: filter.rawValue)
        /// Convert UIImage to CIImage and set as input
        let ciInput = CIImage(image: self)
        filter?.setValue(ciInput, forKey: "inputImage")
        /// Get output CIImage, render as CGImage first to retain proper UIImage scale
        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
        /// Return the image
        return UIImage(cgImage: cgImage!)
    }

    enum FilterType: String {
        case chrome = "CIPhotoEffectChrome"
        case fade = "CIPhotoEffectFade"
        case instant = "CIPhotoEffectInstant"
        case mono = "CIPhotoEffectMono"
        case noir = "CIPhotoEffectNoir"
        case process = "CIPhotoEffectProcess"
        case tonal = "CIPhotoEffectTonal"
        case transfer = "CIPhotoEffectTransfer"
    }

    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }

    func fixOrientation() -> UIImage {
        /// No-op if the orientation is already correct
        if imageOrientation == UIImage.Orientation.up {
            return self
        }

        /// We need to calculate the proper transformation to make the image upright.
        /// We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform = CGAffineTransform.identity

        if imageOrientation == UIImage.Orientation.down || imageOrientation == UIImage.Orientation.downMirrored {
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        }

        if imageOrientation == UIImage.Orientation.left || imageOrientation == UIImage.Orientation.leftMirrored {
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2.0))
        }

        if imageOrientation == UIImage.Orientation.right || imageOrientation == UIImage.Orientation.rightMirrored {
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi / 2.0))
        }

        if imageOrientation == UIImage.Orientation.upMirrored || imageOrientation == UIImage.Orientation.downMirrored {
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        }

        if imageOrientation == UIImage.Orientation.leftMirrored || imageOrientation == UIImage.Orientation.rightMirrored {
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        }

        /// Now we draw the underlying CGImage into a new context, applying the transform
        /// calculated above.
        let ctx = CGContext(
            data: nil,
            width: Int(size.width),
            height: Int(size.height),
            bitsPerComponent: cgImage!.bitsPerComponent,
            bytesPerRow: 0,
            space: cgImage!.colorSpace!,
            bitmapInfo: cgImage!.bitmapInfo.rawValue
        )!

        ctx.concatenate(transform)

        if
            imageOrientation == UIImage.Orientation.left ||
            imageOrientation == UIImage.Orientation.leftMirrored ||
            imageOrientation == UIImage.Orientation.right ||
            imageOrientation == UIImage.Orientation.rightMirrored
        {
            ctx.draw(cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        } else {
            ctx.draw(cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }

        /// And now we just create a new UIImage from the drawing context and return it
        return UIImage(cgImage: ctx.makeImage()!)
    }

    func aspectFitImage(inRect rect: CGRect) -> UIImage? {
        let width = size.width
        let height = size.height
        let aspectWidth = rect.width / width
        let aspectHeight = rect.height / height
        let scaleFactor = aspectWidth > aspectHeight ? rect.size.height / height : rect.size.width / width

        UIGraphicsBeginImageContextWithOptions(CGSize(width: width * scaleFactor, height: height * scaleFactor), false, 0.0)
        draw(in: CGRect(x: 0.0, y: 0.0, width: width * scaleFactor, height: height * scaleFactor))

        defer {
            UIGraphicsEndImageContext()
        }

        return UIGraphicsGetImageFromCurrentImageContext()
    }

    func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    static func loadImageFromDocumentDirectory(nameOfImage: String) -> UIImage? {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath = paths.first {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(nameOfImage)
            let image = UIImage(contentsOfFile: imageURL.path)
            return image
        }
        return UIImage(named: "user_image_default")
    }

    static func saveImageToDocumentDirectory(image: UIImage) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "user_image" // name of the image to be saved
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if let data = image.jpegData(compressionQuality: 1.0) {
            do {
                try data.write(to: fileURL)
                print("file saved")
            } catch {
                print("error saving file:", error)
            }
        }
    }
}

// MARK: - EncodableImage

public struct EncodableImage: Encodable {
    public let pngData: Data?

    public init(image: Data?) {
        pngData = image
    }
}
