//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Foundation
import UIKit

class ButtonRounded: BaseView {
    private lazy var aroundView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = ThemeManager.currentTheme().secondaryColor.cgColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(btnDidTap(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    private var nextBtn: UIButton = {
        var button = UIButton(frame: .zero)
        button.backgroundColor = ThemeManager.currentTheme().secondaryColor
        button.setImage(AppAsset.icnNext.image, for: .normal)
        button.hero.id = Constants.HeroTransitionsID.welcomeTransition
        button.addTarget(self, action: #selector(btnDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var btnTapped: (() -> Void)?

    override func configureUI() {
        super.configureUI()

        addSubview(aroundView)
        aroundView.addSubview(nextBtn)
    }

    override func configureConstraints() {
        super.configureConstraints()

        aroundView.centerAnchors /==/ centerAnchors
        aroundView.widthAnchor /==/ 155
        aroundView.heightAnchor /==/ 65

        nextBtn.centerAnchors /==/ aroundView.centerAnchors
        nextBtn.widthAnchor /==/ 145
        nextBtn.heightAnchor /==/ 55
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        nextBtn.clipsToBounds = true
        nextBtn.layer.cornerRadius = 28
        aroundView.layer.cornerRadius = 34
    }
}

extension ButtonRounded {
    @objc func btnDidTap(_: UITapGestureRecognizer) {
        aroundView.tapAnimation {
            self.btnTapped?()
        }
    }
}
