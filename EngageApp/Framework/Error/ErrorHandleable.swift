//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public typealias HandleAction<T> = (T) throws -> Void

// MARK: - ErrorHandleable

public protocol ErrorHandleable: AnyObject {
    func `throw`(_: Error, finally: @escaping (Bool) -> Void)
    func `catch`(action: @escaping HandleAction<Error>) -> ErrorHandleable
}
