//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit

public class SplashView: BaseView {
    
    private lazy var backgroundImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.backgroundSplash.image
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    override func configureUI() {
        super.configureUI()

        addSubview(backgroundImgView)
    }

    override func configureConstraints() {
        super.configureConstraints()

        backgroundImgView.edgeAnchors /==/ edgeAnchors
    }
}
