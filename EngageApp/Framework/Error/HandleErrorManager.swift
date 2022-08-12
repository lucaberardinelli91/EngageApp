//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public class HandleErrorManager: ErrorHandleable {
    private var parent: HandleErrorManager?
    private let action: HandleAction<Error>

    public convenience init(action: @escaping HandleAction<Error> = { throw $0 }) {
        self.init(action: action, parent: nil)
    }

    private init(action: @escaping HandleAction<Error>, parent: HandleErrorManager? = nil) {
        self.action = action
        self.parent = parent
    }

    public func `throw`(_ error: Error, finally: @escaping (Bool) -> Void) {
        `throw`(error, previous: [], finally: finally)
    }

    private func `throw`(_ error: Error, previous: [HandleErrorManager], finally: ((Bool) -> Void)? = nil) {
        if let parent = parent {
            parent.throw(error, previous: previous + [self], finally: finally)
            return
        }
        serve(error, next: AnyCollection(previous.reversed()), finally: finally)
    }

    private func serve(_ error: Error, next: AnyCollection<HandleErrorManager>, finally: ((Bool) -> Void)? = nil) {
        do {
            try action(error)
            finally?(true)
        } catch {
            if let nextHandler = next.first {
                nextHandler.serve(error, next: next.dropFirst(), finally: finally)
            } else {
                finally?(false)
            }
        }
    }

    public func `catch`(action: @escaping HandleAction<Error>) -> ErrorHandleable {
        return HandleErrorManager(action: action, parent: self)
    }
}
