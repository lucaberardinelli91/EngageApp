//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public extension UIView {
    //  Example
    //  nextButton.setGradientBackground(locations: [0.0, 1.0], colorTop: ThemeManager.currentTheme().primaryColor, colorBottom: ThemeManager.currentTheme().blueLight)
    func setGradientBackground(locations: [NSNumber], colorTop: UIColor, colorBottom: UIColor, withCornerRadius: CGFloat = 0, animated: Bool = false) {
        let colorTop = colorTop
        let colorBottom = colorBottom

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.locations = locations
        gradientLayer.frame = bounds

        gradientLayer.cornerRadius = withCornerRadius
        gradientLayer.masksToBounds = true

        if animated {
            /// Animation
            let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
            gradientChangeAnimation.duration = 0.3
            gradientChangeAnimation.fromValue = [
                colorBottom.cgColor,
                colorTop.cgColor,
            ]

            gradientChangeAnimation.fillMode = CAMediaTimingFillMode.both
            gradientChangeAnimation.isRemovedOnCompletion = false
            gradientLayer.add(gradientChangeAnimation, forKey: "colorChange")
        }

        layer.insertSublayer(gradientLayer, at: 0)
    }

    //  Example
    //  nextButton.setGradientBackground(startPoint: CGPoint(x: 0.0, y: 0.5), endPoint: CGPoint(x: 1.0, y: 0.5), startColor: ThemeManager.currentTheme().primaryColor, endColor: ThemeManager.currentTheme().blueLight)
    func setGradientBackground(startPoint: CGPoint, endPoint: CGPoint, startColor: UIColor, endColor: UIColor) {
        let gradientLayerName = "gradientLayer"

        if let oldlayer = layer.sublayers?.filter({ $0.name == gradientLayerName }).first {
            oldlayer.removeFromSuperlayer()
        }

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = bounds
        gradientLayer.name = gradientLayerName

        layer.insertSublayer(gradientLayer, at: 0)
    }

    func setHorizontalGradientColor(leftColor: UIColor, rightColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        let updatedFrame = bounds
        gradientLayer.frame = updatedFrame
        gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    /// Transparent gradient
    func setTransparentGradient(locations: [NSNumber], atTop: Bool) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds

        atTop ? (gradientLayer.colors = [
            UIColor.white.withAlphaComponent(0).cgColor,
            UIColor.white.withAlphaComponent(0.8).cgColor,
        ]) : (gradientLayer.colors = [
            UIColor.white.withAlphaComponent(0.8).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor,
        ])

        gradientLayer.locations = locations
        layer.mask = gradientLayer
        layer.masksToBounds = true
    }

    func removeGradient() {
        guard let subLayers = layer.sublayers else { return }
        for layer in subLayers {
            if layer is CAGradientLayer {
                layer.removeFromSuperlayer()
            }
        }
    }

    func addShadow(color: UIColor, opacity: Float, radius: CGFloat, offset: CGSize) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }

    func removeShadow() {
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOpacity = 0
        layer.shadowOffset = .zero
        layer.shadowRadius = 0
    }

    func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    func tapAnimation(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.05, animations: {
                self.transform = .init(scaleX: 0.9, y: 0.9)
            }) { _ in
                UIView.animate(
                    withDuration: 0.1,
                    delay: 0,
                    usingSpringWithDamping: 0.4,
                    initialSpringVelocity: 20,
                    options: [.curveEaseOut],
                    animations: {
                        self.transform = .identity
                    }
                ) { _ in
                    completion?()
                }
            }
        }
    }

    func tapAnimationAlternative(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = .init(scaleX: 0.8, y: 0.8)
            }) { _ in
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0,
                    usingSpringWithDamping: 0.6,
                    initialSpringVelocity: 20,
                    options: [.curveEaseOut, .allowUserInteraction],
                    animations: {
                        self.transform = .identity
                    }
                ) { _ in
                    completion?()
                }
            }
        }
    }

    /// Used to animate the separators in matches view controller. Blink the view every 0.5 seconds with `repeat`
    func blink() {
        alpha = 0.2
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut, .repeat, .autoreverse], animations: { self.alpha = 1.0 }, completion: nil)
    }

    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)

        return renderer.image {
            rendererContext in

            layer.render(in: rendererContext.cgContext)
        }
    }
}
