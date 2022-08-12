//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Foundation
import Lottie

public class CustomLoader: BaseView, ModalView {
    public var from: Modable
    public var type: ModalType

    private let backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        return view
    }()

    let containerLoader: AnimationView = {
        var loader = AnimationView(name: "loader", bundle: DataBundleResolver.returnMainBundle(), imageProvider: nil, animationCache: nil)
        loader.contentMode = .scaleAspectFit
        loader.loopMode = .autoReverse

        return loader
    }()

    public init(frame: CGRect, from: Modable) {
        self.from = from
        type = .loader

        super.init(frame: frame)
        configureUI()
    }

    override func configureUI() {
        super.configureUI()

        UIView.transition(with: backgroundView, duration: 0.5, options: .transitionCrossDissolve) {
            self.addSubview(self.backgroundView)
        } completion: { completed in
            if completed {
                self.addSubview(self.containerLoader)
                self.configureConstraints()
            }
        }

        containerLoader.play()
    }

    override func configureConstraints() {
        super.configureConstraints()

        backgroundView.edgeAnchors /==/ edgeAnchors

        containerLoader.centerAnchors /==/ centerAnchors
        containerLoader.widthAnchor /==/ 200
        containerLoader.heightAnchor /==/ 200
    }
}
