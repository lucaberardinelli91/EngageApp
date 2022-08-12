//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public protocol WebViewDelegate: NSObject {
    func onAppear()
    func onDisappear()
}

public extension WebViewDelegate {
    func onDisappear() {}
}
