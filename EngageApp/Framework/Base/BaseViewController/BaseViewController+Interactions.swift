//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import Foundation

public extension BaseViewController {
    func interaction<Value: Any>(_ input: PassthroughSubject<Value, Never>, _ success: ((Value) -> Void)? = nil) {
        input
            .receive(on: RunLoop.main)
            .sink { value in
                success?(value)
            }
            .store(in: &cancellables)
    }
}
