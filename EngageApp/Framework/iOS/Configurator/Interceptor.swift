//
//  EngageApp
//  Created by Luca Berardinelli
//

import Combine
import KeychainAccess
import Networking

// MARK: - CustomInterceptor

public class Interceptor: NetworkingInterceptorProtocol {
    private var cancellables = Set<AnyCancellable>()

    private let keychain: Keychain
    private let deviceModel: DeviceModel

    public init(deviceModel: DeviceModel) {
        self.deviceModel = deviceModel
        keychain = Keychain(service: Constants.appBundle)
    }

    public func adapt(_ urlRequest: URLRequest) -> URLRequest {
        var finalRequest = urlRequest
        finalRequest.addValue(getConnectionHeader(), forHTTPHeaderField: "Connection")
        finalRequest.addValue(getUserAgent(), forHTTPHeaderField: "User-Agent")
        if let _ = Configurator.configurator?.apiKey {
            if let apiKey = getApiKey() {
                finalRequest.addValue(apiKey, forHTTPHeaderField: "apikey")
            }
        }
        finalRequest.addValue(getClientType(), forHTTPHeaderField: "x-client-type")
        /// In case of multipart API, we pass the `Content-Type` from external
        if urlRequest.allHTTPHeaderFields?["Content-Type"] == nil {
            finalRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        finalRequest.addValue(getClientGuid(), forHTTPHeaderField: "x-client-guid")
        finalRequest.addValue(getClientVersion(), forHTTPHeaderField: "x-client-version")
        finalRequest.addValue(getLanguage(), forHTTPHeaderField: "Accept-Language")
        finalRequest.addValue(getBuildVersion(), forHTTPHeaderField: "x-client-build")
        guard let token = keychain[KeychainKeys.accessTokenKey] else { return finalRequest }
        finalRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return finalRequest
    }

    public func retry(_: URLRequest, for _: URLSession, dueTo error: Error?) -> AnyPublisher<RetryResult, Error> {
        return Future { promise in
            if let error = error as? NetworkingError {
                switch error {
                case .underlying(response: let response, data: _):
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 else {
                        promise(.success(.doNotRetry))
                        return
                    }

                default:
                    promise(.success(.doNotRetry))
                }
            }
        }.eraseToAnyPublisher()
    }
}

private extension Interceptor {
    func getUserAgent() -> String {
        return deviceModel.userAgent()
    }

    func getConnectionHeader() -> String {
        return "close"
    }

    func getApiKey() -> String? {
        return Configurator.configurator?.apiKey
    }

    func getClientType() -> String {
        return "mobileApp"
    }

    func getContentType() -> String {
        return "application/json"
    }

    func getClientGuid() -> String {
        return deviceModel.guid
    }

    func getClientVersion() -> String {
        return deviceModel.clientVersion()
    }

    func getLanguage() -> String {
        return deviceModel.language
    }

    func getBuildVersion() -> String {
        return deviceModel.buildVersion()
    }
}
