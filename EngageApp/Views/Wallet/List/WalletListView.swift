//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public class WalletListView: BaseView {
    var earnCoinsTap = PassthroughSubject<Void, Never>()
    var dismiss = PassthroughSubject<Void, Never>()
    var coins: Int?

    private let backLayerView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear

        return view
    }()

    lazy var walletView: WalletViewBS = {
        var view = WalletViewBS()

        return view
    }()

    override func configureUI() {
        super.configureUI()

        backgroundColor = .clear
    }

    override func configureConstraints() {
        super.configureConstraints()

        presentWalletView()
    }

    @objc func earnCoinsDidTap() {
        earnCoinsTap.send()
    }
}

extension WalletListView {
    func presentWalletView() {
        addSubview(backLayerView)
        backLayerView.edgeAnchors /==/ edgeAnchors
        backLayerView.alpha = 0
        layoutIfNeeded()

        UIView.animate(withDuration: 0.3) {
            self.backLayerView.alpha = 1
        } completion: { _ in
            self.backLayerView.addSubview(self.walletView)

            self.walletView.dismiss = {
                self.dismissWalletView()
            }

            self.walletView.earnCoinsTap = {
                self.earnCoinsDidTap()
            }

            self.walletView.topAnchor /==/ self.backLayerView.bottomAnchor
            self.walletView.rightAnchor /==/ self.backLayerView.rightAnchor
            self.walletView.leftAnchor /==/ self.backLayerView.leftAnchor
            self.walletView.heightAnchor /==/ self.walletView.getHeight()
            self.layoutIfNeeded()

            self.walletView.coins = "\(self.coins ?? 0)".formatValue()

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 1) {
                self.walletView.transform = .init(translationX: 0, y: -self.walletView.getHeight())
            }
        }
    }

    func dismissWalletView() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, animations: {
            self.dismiss.send()
        }) { _ in
            self.backLayerView.removeFromSuperview()
        }
    }
}
