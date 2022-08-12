//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Foundation

class PageControlView: UICollectionReusableView {
    var pageControl: UIPageControl = {
        var pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = ThemeManager.currentTheme().secondaryColor
        pageControl.pageIndicatorTintColor = ThemeManager.currentTheme().secondaryColor.withAlphaComponent(0.3)
        pageControl.backgroundColor = .clear
        pageControl.isUserInteractionEnabled = false

        return pageControl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pageControl)

        backgroundColor = .clear
    }

    func setConstraints() {
        pageControl.bottomAnchor /==/ bottomAnchor - 5
        pageControl.centerXAnchor /==/ centerXAnchor
        pageControl.heightAnchor /==/ 40
    }

    override public func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        layer.zPosition = CGFloat(layoutAttributes.zIndex)
    }

    func updatePageControlIndex(index: Int) {
        pageControl.currentPage = index
    }
}
