//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import Foundation

open class BaseViewModel: NSObject {
    /// Cancellables for `Combine`
    public var cancellables: Set<AnyCancellable>

    override public init() {
        cancellables = Set<AnyCancellable>()
    }
}
