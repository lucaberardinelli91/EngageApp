//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine

// MARK: - State

public enum LoadingState<Value, Error: Swift.Error> {
    case idle
    case loading
    case success(Value)
    case failure(Error)
}

public extension LoadingState {
    var value: Value? {
        guard case let .success(value) = self else { return nil }
        return value
    }
}
