//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import Foundation
import Networking

public struct NetworkingManager {
    private let networking: NetworkingProtocol = {
        let networking = Networking(
            baseURL: Configurator.configurator?.apiURL ?? "",
            interceptor: Configurator.interceptor
        )
        networking.logLevel = .debug
        return networking
    }()

    public var networkingDataSource: NetworkingDataSourceProtocol

    init() {
        networkingDataSource = NetworkingDataSource(networking: networking)
    }
}
