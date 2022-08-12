//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Foundation
import UIKit

class DottedProgress: BaseView {
    // Step 1
    private lazy var step1View: UIView = {
        let view = UIView()
        view.accessibilityIdentifier = "1"
        view.backgroundColor = ThemeManager.currentTheme().secondaryColor.withAlphaComponent(0.7)
        return view
    }()

    private lazy var step1SpacerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    public var step1StkView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private lazy var step1AroundView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()

    // Step 2
    private lazy var step2View: UIView = {
        let view = UIView()
        view.accessibilityIdentifier = "2"
        view.backgroundColor = ThemeManager.currentTheme().secondaryColor.withAlphaComponent(0.7)
        return view
    }()

    private lazy var step2SpacerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    public var step2StkView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private lazy var step2AroundView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()

    // Step 3
    private lazy var step3View: UIView = {
        let view = UIView()
        view.accessibilityIdentifier = "3"
        view.backgroundColor = ThemeManager.currentTheme().secondaryColor.withAlphaComponent(0.7)
        return view
    }()

    private lazy var step3SpacerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    public var step3StkView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private lazy var step3AroundView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()

    public var stepStkView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
//        stackView.spacing = 50
        return stackView
    }()

    override func configureUI() {
        super.configureUI()

        step1AroundView.addSubview(step1View)
        step2AroundView.addSubview(step2View)
        step3AroundView.addSubview(step3View)

        step1StkView.addArrangedSubview(step1AroundView)
        step1StkView.addArrangedSubview(step1SpacerView)
        stepStkView.addArrangedSubview(step1StkView)

        step2StkView.addArrangedSubview(step2SpacerView)
        step2StkView.addArrangedSubview(step2AroundView)
        stepStkView.addArrangedSubview(step2StkView)

        step3StkView.addArrangedSubview(step3AroundView)
        step3StkView.addArrangedSubview(step3SpacerView)
        stepStkView.addArrangedSubview(step3StkView)

        addSubview(stepStkView)
    }

    override func configureConstraints() {
        super.configureConstraints()

        step1AroundView.widthAnchor /==/ 10
        step1AroundView.heightAnchor /==/ 10
        step1View.centerAnchors /==/ step1AroundView.centerAnchors
        step1View.widthAnchor /==/ 10.5
        step1View.heightAnchor /==/ 10.5
        step1SpacerView.widthAnchor /==/ 5
        step1SpacerView.heightAnchor /==/ 5
        step1StkView.widthAnchor /==/ 15

        step2AroundView.widthAnchor /==/ 10
        step2AroundView.heightAnchor /==/ 10
        step2View.centerAnchors /==/ step2AroundView.centerAnchors
        step2View.widthAnchor /==/ 10.5
        step2View.heightAnchor /==/ 10.5
        step2SpacerView.widthAnchor /==/ 5
        step2SpacerView.heightAnchor /==/ 5
        step2StkView.widthAnchor /==/ 15

        step3AroundView.widthAnchor /==/ 10
        step3AroundView.heightAnchor /==/ 10
        step3View.centerAnchors /==/ step3AroundView.centerAnchors
        step3View.widthAnchor /==/ 10.5
        step3View.heightAnchor /==/ 10.5
        step3SpacerView.widthAnchor /==/ 5
        step3SpacerView.heightAnchor /==/ 5
        step3StkView.widthAnchor /==/ 15

        stepStkView.centerXAnchor /==/ centerXAnchor
        stepStkView.widthAnchor /==/ 78
        stepStkView.heightAnchor /==/ 21
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        step1AroundView.layer.cornerRadius = 8
        step2AroundView.layer.cornerRadius = 8
        step3AroundView.layer.cornerRadius = 8
    }
}
