//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import Networking

public enum Configurator {
    public static var configurator: BaseConfiguratorProtocol!
    /// This is the main and only instance of `MainContainer`, that's an implementation of `MainContainerProtocol`. In this object there is only and one instance of each UseCase provided by framework
    public private(set) static var mainContainer: MainContainerProtocol = MainContainer()
    static var interceptor: NetworkingInterceptorProtocol?

    public static func setup(configurator: BaseConfiguratorProtocol, checkAssets: Bool = true) {
        if checkAssets {
            Configurator.checkAssets()
        }
        self.configurator = configurator
        interceptor = Interceptor(deviceModel: configurator.deviceModel)
        /// Start monitoring to check internet connection
        ConnectionHelper.shared.startMonitoring()
    }

    private static func checkAssets() {
        guard let _ = Bundle.main.path(forResource: "loader", ofType: "json") else {
            fatalError("❌ ASSETS: loader.json not found")
        }
    }
}
