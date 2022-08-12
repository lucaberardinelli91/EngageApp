//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

// MARK: - BaseConfiguratorProtocol

public protocol BaseConfiguratorProtocol {
    var baseURL: String { get }
    var apiURL: String { get }
    var apiKey: String { get }
    var theme: Theme { get }
    var deviceModel: DeviceModel { get }
}

// MARK: - Configurator

public struct BaseConfigurator: BaseConfiguratorProtocol {
    public var baseURL: String
    public var apiKey: String
    public var apiVersion: ApiVersion
    public var theme: Theme
    public var deviceModel: DeviceModel

    public var apiURL: String {
        buildApiURL(baseURL: baseURL)
    }

    public init(deviceModel: DeviceModel = DeviceModel(), baseURL: String, apiKey: String, apiVersion: ApiVersion, theme: Theme) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.apiVersion = apiVersion
        self.theme = theme
        self.deviceModel = deviceModel

        ThemeManager.applyTheme(theme: theme)
    }

    private func buildApiURL(baseURL: String) -> String {
        let urlComponents = URLComponents(string: baseURL)
        guard let host = urlComponents?.host, let scheme = urlComponents?.scheme else {
            assertionFailure("URL not valid")
            return baseURL
        }

        return "\(scheme)://\(host)/api/\(apiVersion)"
    }
}

// MARK: - ApiVersion

public enum ApiVersion: String {
    case v1
    case v2
    case v3
}
