//
//  EngageApp
//  Created by Luca Berardinelli
//
//  Resource: https://iosexample.com/bottom-sheet-modal-view-controller-with-swift/

import Anchorage
import Combine
import UIKit

public class BottomSheetDraggable: BaseView {
    var dismiss: (() -> Void)?
    var earnMoreCoinsTap: (() -> Void)?
    var swipeTap: (() -> Void)?

    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false

        let bottomView = UIView()
        bottomView.backgroundColor = .white

        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFill

        imgView.addSubview(bottomView)
        view.addSubview(imgView)

        bottomView.bottomAnchor /==/ imgView.bottomAnchor
        bottomView.leadingAnchor /==/ imgView.leadingAnchor
        bottomView.trailingAnchor /==/ imgView.trailingAnchor
        bottomView.heightAnchor /==/ 325

        imgView.edgeAnchors /==/ view.edgeAnchors

        return view
    }()

    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true

        return view
    }()

    var pullView: UIView = {
        var containerView = UIView(frame: .zero)
        containerView.backgroundColor = .clear

        var pullView = UIView(frame: .zero)
        pullView.backgroundColor = AppAsset.grayPull.color
        pullView.layer.cornerRadius = 3
        containerView.addSubview(pullView)

        pullView.centerAnchors /==/ containerView.centerAnchors
        pullView.widthAnchor /==/ 60
        pullView.heightAnchor /==/ 6

        return containerView
    }()

    lazy var limitedView: UIView = {
        let view = UIView()
        view.backgroundColor = AppAsset.grayDarker.color

        var label = UILabel()
        LabelStyle.limitedTitle.apply(to: label)
        label.text = L10n.rewardLimited

        view.addSubview(label)
        label.centerYAnchor /==/ view.centerYAnchor
        label.centerXAnchor /==/ view.centerXAnchor

        return view
    }()

    private var closeBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.setImage(AppAsset.fancamClose.image, for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true

        return button
    }()

    var defaultHeight: CGFloat = 300
    var currentContainerHeight: CGFloat = 300
    var dismissibleHeight: CGFloat = 200
    var maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64

    var backgroundImg: UIImage? { didSet { didSetBackgroundImg() }}

    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?

    override func configureUI() {
        super.configureUI()

        backgroundColor = .white

        backgroundView.addSubview(closeBtn)

        addSubview(pullView)
        addSubview(backgroundView)

        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        setDragGesture()
    }

    override func configureConstraints() {
        super.configureConstraints()

        backgroundView.edgeAnchors /==/ edgeAnchors

        closeBtn.topAnchor /==/ backgroundView.topAnchor + 40
        closeBtn.trailingAnchor /==/ backgroundView.trailingAnchor - 20

        containerView.leadingAnchor /==/ leadingAnchor
        containerView.trailingAnchor /==/ trailingAnchor

        pullView.topAnchor /==/ containerView.topAnchor + 10
        pullView.centerXAnchor /==/ containerView.centerXAnchor
        pullView.heightAnchor /==/ 5
        pullView.widthAnchor /==/ 55

        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: defaultHeight)

        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true

        animateShowDimmedView()
        animatePresentContainer()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        limitedView.clipsToBounds = true
        limitedView.layer.cornerRadius = 17

        containerView.roundCorners(corners: [.topLeft, .topRight], radius: 25)
    }

    @objc func closeButtonDidTap() {
        closeBtn.tapAnimation {
            self.dismiss?()
        }
    }

    private func didSetBackgroundImg() {
        guard let backgroundImg = backgroundImg else { return }
        (backgroundView.subviews[0] as! UIImageView).image = backgroundImg
    }
}

// MARK: - Drag Gesture

extension BottomSheetDraggable {
    func setDragGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleDragGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        addGestureRecognizer(panGesture)
    }

    @objc func handleDragGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let isDraggingDown = translation.y > 0
        let newHeight = currentContainerHeight - translation.y

        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            if newHeight < maximumContainerHeight {
                ((backgroundView.subviews[0] as! UIImageView).subviews[0]).isHidden = true
                // Keep updating the height constraint
                containerViewHeightConstraint?.constant = newHeight
                // refresh layout
                layoutIfNeeded()
            }
        case .ended:
            // This happens when user stop drag,
            // so we will get the last height of container
            // Condition 1: If new height is below min, dismiss controller
            if newHeight < dismissibleHeight {
                animateDismissView()
            } else if newHeight < defaultHeight {
                ((backgroundView.subviews[0] as! UIImageView).subviews[0]).isHidden = false
                // Condition 2: If new height is below default, animate back to default
                animateContainerHeight(defaultHeight)
            } else if newHeight < maximumContainerHeight, isDraggingDown {
                ((backgroundView.subviews[0] as! UIImageView).subviews[0]).isHidden = false
                // Condition 3: If new height is below max and going down, set to default height
                animateContainerHeight(defaultHeight)
            } else if newHeight > defaultHeight, !isDraggingDown {
                // Condition 4: If new height is below max and going up, set to max height at top
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }

    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.layoutIfNeeded()
        }
        currentContainerHeight = height
    }

    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.layoutIfNeeded()
        }
    }

    func animateShowDimmedView() {
        backgroundView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.backgroundView.alpha = 1.0
        }
    }

    func animateDismissView() {
        dismiss?()
    }
}
