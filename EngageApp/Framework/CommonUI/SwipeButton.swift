//
//  EngageApp
//  Created by Luca Berardinelli
//
// Resource: https://github.com/TilakGondi/TGFlingActionButton

import Anchorage
import UIKit

enum SwipeDirection {
    case right
    case left
    case none
}

class SwipeButton: UIButton {
    var swipeEnd: (() -> Void)?
    var swipeDirection: SwipeDirection = .none

    lazy var swipableView: UILabel = {
        let label = UILabel(frame: CGRect(x: -7, y: 0, width: self.frame.size.height, height: self.frame.size.height))
        label.isUserInteractionEnabled = true

        return label
    }()

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeManager.currentTheme().secondaryColor.withAlphaComponent(0.2)

        return view
    }()

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        addSubview(containerView)
        containerView.topAnchor /==/ topAnchor + 3
        containerView.leadingAnchor /==/ leadingAnchor
        containerView.trailingAnchor /==/ trailingAnchor
        containerView.bottomAnchor /==/ bottomAnchor - 3
        containerView.layer.cornerRadius = 25

        addSubview(getSwipableView())

        layer.cornerRadius = frame.size.height / 2
        clipsToBounds = true

        setTitle(L10n.rewardSwipeToRedeem, for: .normal)
        setTitleColor(ThemeManager.currentTheme().secondaryColor, for: .normal)

        titleLabel?.font = ThemeManager.currentTheme().primaryBoldFont.font(size: 22)
        titleLabel?.textColor = UIColor.white
        contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        layer.cornerRadius = 28

        let gradient = getGradientLayer(bounds: bounds)
        setTitleColor(gradientColor(bounds: bounds, gradientLayer: gradient), for: .normal)

//        containerView.setGradientBackground(startPoint: CGPoint(x: 0.0, y: 0.5), endPoint: CGPoint(x: 0.5, y: 0.5), startColor: AppAsset.clear.color, endColor: ThemeManager.currentTheme().secondaryColor.color.withAlphaComponent(0.2))
    }

    func getSwipableView() -> UIView {
        let swipeView = UIView()
        let swipeIcon = UIImageView(image: AppAsset.swipeIcon.image)
        let swipeCircle = UIImageView(image: AppAsset.swipeBack.image)

        swipeView.heightAnchor /==/ 60
        swipeView.widthAnchor /==/ swipeView.heightAnchor

        swipeView.addSubview(swipeCircle)
        swipeCircle.centerYAnchor /==/ swipeView.centerYAnchor

        swipeView.addSubview(swipeIcon)
        swipeIcon.widthAnchor /==/ 26
        swipeIcon.heightAnchor /==/ swipeIcon.heightAnchor
        swipeIcon.centerAnchors /==/ swipeCircle.centerAnchors

        swipableView.insertSubview(swipeView, at: 1)
        swipableView.layer.cornerRadius = swipableView.frame.height / 2

        swipeView.leadingAnchor /==/ swipableView.leadingAnchor

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handelPanGesture(panGesture:)))
        swipableView.addGestureRecognizer(panGesture)

        return swipableView
    }

    @objc func handelPanGesture(panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: panGesture.view?.superview)
        let xCurrent = Int(translation.x)
        let xLimitToSwipe = Int(frame.size.width / 1.25)

        if xCurrent >= 0 {
            swipeDirection == .none ? swipeDirection = getSwipeDirection(translation: translation) : nil

            if swipeDirection == .right {
                if panGesture.state == UIGestureRecognizer.State.ended {
                    if xCurrent > xLimitToSwipe {
                        swipeEnd?()
                        UIView.animate(withDuration: 0.2, animations: {
                            self.swipableView.frame = CGRect(x: (self.frame.size.width) - (self.swipableView.frame.size.width) - 8,
                                                             y: self.swipableView.frame.origin.y,
                                                             width: self.swipableView.frame.size.width,
                                                             height: self.frame.size.height - 4)
                        })
                    } else {
                        UIView.animate(withDuration: 0.2, animations: {
                            self.swipableView.frame = CGRect(x: -7,
                                                             y: self.swipableView.frame.origin.y,
                                                             width: self.swipableView.frame.size.width,
                                                             height: self.frame.size.height - 4)
                        })
                    }
                } else {
                    xCurrent > xLimitToSwipe ? nil : UIView.animate(withDuration: 0.0) {
                        self.swipableView.frame = CGRect(x: translation.x,
                                                         y: self.swipableView.frame.origin.y,
                                                         width: self.swipableView.frame.size.width,
                                                         height: self.frame.size.height - 4)
                    }
                }
            }
        }
    }

    func getSwipeDirection(translation: CGPoint) -> SwipeDirection {
        if translation.x > 0 {
            return .right
        } else if translation.x < 0 {
            return .left
        } else {
            return .none
        }
    }

    // Button gradient
    func getGradientLayer(bounds: CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [ThemeManager.currentTheme().secondaryColor.withAlphaComponent(0.2).cgColor, ThemeManager.currentTheme().secondaryColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)

        return gradient
    }

    func gradientColor(bounds _: CGRect, gradientLayer: CAGradientLayer) -> UIColor? {
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return UIColor(patternImage: image!)
    }
}
