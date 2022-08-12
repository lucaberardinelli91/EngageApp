//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Foundation

// MARK: - UINavigationBarGradientView

public class UINavigationBarGradientView: UIView {
    public enum Point {
        case topRight
        case topLeft
        case bottomRight
        case bottomLeft
        case top
        case bottom
        case custom(point: CGPoint)

        var point: CGPoint {
            switch self {
            case .topRight: return CGPoint(x: 1, y: 0)
            case .topLeft: return CGPoint(x: 0, y: 0)
            case .bottomRight: return CGPoint(x: 1, y: 1)
            case .bottomLeft: return CGPoint(x: 0, y: 1)
            case .top: return CGPoint(x: 0.5, y: 0.2)
            case .bottom: return CGPoint(x: 0.5, y: 1)
            case let .custom(point): return point
            }
        }
    }

    private weak var gradientLayer: CAGradientLayer!

    convenience init(
        colors: [UIColor],
        startPoint: Point = .topLeft,
        endPoint: Point = .bottomLeft,
        locations: [NSNumber] = [0, 1]
    ) {
        self.init(frame: .zero)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
        set(colors: colors, startPoint: startPoint, endPoint: endPoint, locations: locations)
        backgroundColor = .clear
    }

    func set(
        colors: [UIColor],
        startPoint: Point = .topLeft,
        endPoint: Point = .bottomLeft,
        locations: [NSNumber] = [0, 1]
    ) {
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint.point
        gradientLayer.endPoint = endPoint.point
        gradientLayer.locations = locations
    }

    func setupConstraints() {
        guard let parentView = superview else { return }
        edgeAnchors /==/ parentView.edgeAnchors
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        guard let gradientLayer = gradientLayer else { return }
        gradientLayer.frame = frame
        superview?.addSubview(self)
    }
}
