//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import UIKit

public protocol WebViewModelProtocol {
    func getTitleFromURL()
}

public class WebViewViewModel: BaseViewModel, WebViewModelProtocol {
    private var url: URL
    public var title: String?

    @Published var getURLState: LoadingState<(
        url: URL,
        title: String?
    ), CustomError> = .idle

    public init(url: URL, title: String?) {
        self.url = url
        self.title = title
    }

    public func getTitleFromURL() {
        let urlString = url.absoluteString
        if urlString.localizedStandardContains("tos") {
            let itemModel = WelcomeFooterItemModel(type: .TermsAndConditions)
            getURLState = .success((url: url, title: itemModel.title))
        } else if urlString.localizedStandardContains("privacy") {
            let itemModel = WelcomeFooterItemModel(type: .PrivacyPolicy)
            getURLState = .success((url: url, title: itemModel.title))
        } else {
            getURLState = .success((url: url, title: title))
        }
    }
}
