//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

public extension BaseViewController {
    internal func addCloseButton() {
        navigationItem.setHidesBackButton(true, animated: false)

        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark")?.withTintColor(ThemeManager.currentTheme().navigationBarForegroundColor, renderingMode: .alwaysTemplate), style: .plain, target: self, action: #selector(closeDidTap))

        closeButton.tintColor = .white
        closeButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        if var rightBarButtonItems = navigationItem.rightBarButtonItems {
            rightBarButtonItems += [closeButton]
        } else {
            navigationItem.rightBarButtonItems = [closeButton]
        }
    }

    @objc private func closeDidTap() {
        closeAction()
    }

    func addGradientOnNavigation() {
        navigationController?.navigationBar._setGradientBackground(colors: [.black, .clear], startPoint: .top, endPoint: .bottom, locations: [0.0, 1.0])
    }

    func adjustInsets(bottomInset: CGFloat = CGFloat(Constants.tabBarHeight), forceBottomInsets: Bool = false) {
        /// Adjust content inset to fit tab bar
        view.subviews.forEach { view in
            if view is UICollectionView {
                (view as! UICollectionView).contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: !forceBottomInsets ? (self.tabBarController?.tabBar.bounds.height ?? bottomInset) : bottomInset, right: 0.0)
            }
        }
    }
}
