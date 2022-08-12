//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

extension BaseViewController {
    func observeError() {
        /// Initialization of `errorHandler`
        errorHandler = HandleErrorManager().listen(CustomError.self, action: { _ in
            // ...
        })
    }

    private func defaultBehavior(error: CustomError) {
        let isConnected = ConnectionHelper.shared.checkConnection()
        if isConnected {
            /// The default behavior is to show the toast with `localizedDescription` string
            DispatchQueue.main.async {
                self.showToast(color: .systemRed, text: error.localizedDescription)
            }
        } else {
            showToast(color: .systemRed, text: "No connection available")
        }
    }
}
