//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

public extension BaseViewController {
    func handleState<Value: Any, CustomError>(state: LoadingState<Value, CustomError>, showLoader: Bool = true, success: ((Value) -> Void)? = nil, failure: ((CustomError) -> Void)? = { _ in }, throwBaseError: Bool = true) {
        switch state {
        case .idle:
            break
        case .loading:
            showLoader ? self.showLoader() : nil
        case let .success(value):
            hideLoader()
            success?(value)
        case let .failure(error):
            hideLoader()
            if throwBaseError {
                errorHandler?.throw(error)
                failure?(error)
            } else {
                failure?(error)
            }
        }
    }

    func handle<Value: Any, CustomError>(_ loadingState: Published<LoadingState<Value, CustomError>>.Publisher, showLoader: Bool = true, success: ((Value) -> Void)? = nil, failure: ((CustomError) -> Void)? = nil, throwBaseError: Bool = true) {
        loadingState
            .sink { state in
                self.handleState(state: state, showLoader: showLoader, success: success, failure: failure, throwBaseError: throwBaseError)
            }
            .store(in: &cancellables)
    }
}
