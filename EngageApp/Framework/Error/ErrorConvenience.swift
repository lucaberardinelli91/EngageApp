//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

/// Protocol extensions for convenience API
public extension ErrorHandleable {
    func `do`<A>(_ section: () throws -> A) {
        do {
            _ = try section()
        } catch {
            `throw`(error)
        }
    }
}

public extension ErrorHandleable {
    func `throw`(_ error: Error) {
        `throw`(error, finally: { _ in })
    }
}

public extension ErrorHandleable {
    func `catch`<K: Error>(_: K.Type, action: @escaping HandleAction<K>) -> ErrorHandleable {
        return `catch`(action: { e in
            if let k = e as? K {
                try action(k)
            } else {
                throw e
            }
        })
    }

    func `catch`<K: Error>(_ value: K, action: @escaping HandleAction<K>) -> ErrorHandleable where K: Equatable {
        return `catch`(action: { e in
            if let k = e as? K, k == value {
                try action(k)
            } else {
                throw e
            }
        })
    }
}

public extension ErrorHandleable {
    func listen(action: @escaping (Error) -> Void) -> ErrorHandleable {
        return `catch`(action: { e in
            action(e)
            throw e
        })
    }

    func listen<K: Error>(_ type: K.Type, action: @escaping (K) -> Void) -> ErrorHandleable {
        return `catch`(type, action: { e in
            action(e)
            throw e
        })
    }

    func listen<K: Error>(_ value: K, action: @escaping (K) -> Void) -> ErrorHandleable where K: Equatable {
        return `catch`(value, action: { e in
            action(e)
            throw e
        })
    }
}
