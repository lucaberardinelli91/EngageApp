//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit
import WebKit

public class WebViewView: BaseView {
    private let webView: WKWebView = {
        var webViewConfiguration = WKWebViewConfiguration()
        webViewConfiguration.allowsAirPlayForMediaPlayback = true
        webViewConfiguration.allowsPictureInPictureMediaPlayback = true
        var webView = WKWebView(frame: .zero, configuration: webViewConfiguration)

        return webView
    }()

    override func configureUI() {
        super.configureUI()

        backgroundColor = .white
        addSubview(webView)
        webView.backgroundColor = ThemeManager.currentTheme().backgroundColor
    }

    override func configureConstraints() {
        super.configureConstraints()

        webView.topAnchor /==/ safeAreaLayoutGuide.topAnchor
        webView.leftAnchor /==/ leftAnchor
        webView.rightAnchor /==/ rightAnchor
        webView.bottomAnchor /==/ bottomAnchor
    }

    func load(url: URL) {
        webView.load(URLRequest(url: url))
    }
}
