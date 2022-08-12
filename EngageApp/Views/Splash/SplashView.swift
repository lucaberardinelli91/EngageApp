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

    private lazy var brandLogoImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.brandLogo.image
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()

    private lazy var brandNameImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.brandName.image
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()

    override func configureUI() {
        super.configureUI()

        addSubview(backgroundImgView)
        addSubview(brandLogoImgView)
        addSubview(brandNameImgView)
    }

    override func configureConstraints() {
        super.configureConstraints()

        backgroundImgView.edgeAnchors /==/ edgeAnchors

        brandLogoImgView.centerXAnchor /==/ centerXAnchor
        brandLogoImgView.centerYAnchor /==/ centerYAnchor + 120
        brandLogoImgView.heightAnchor /==/ 115
        brandLogoImgView.widthAnchor /==/ 117

        brandNameImgView.centerXAnchor /==/ centerXAnchor
        brandNameImgView.heightAnchor /==/ 25
        brandNameImgView.widthAnchor /==/ 25
        brandNameImgView.topAnchor /==/ brandLogoImgView.bottomAnchor + 90
    }
}
