//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import Network

public class ConnectionHelper {
    static let shared = ConnectionHelper()

    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor

    public init() {
        monitor = NWPathMonitor()
    }

    public func checkConnection() -> Bool {
        var isConnected = true
        if monitor.currentPath.status == .satisfied {
            isConnected = true
        } else {
            isConnected = false
        }
        stopMonitoring()

        return isConnected
    }

    func startMonitoring() {
        monitor.start(queue: queue)
    }

    private func stopMonitoring() {
        monitor.cancel()
    }
}
