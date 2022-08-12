//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import Combine

/// Public class used to build an object that will deal with HTTP calls. It's builded with the `baseURL` and the `WebServiceInterceptorProtocol` passed on init.
public class Networking: NSObject, NetworkingProtocol {
    
    // MARK: - Public methods
    
    /// Prints network calls in the console.
    /// Values available are .none and .debug(default).
    /// - .none: The logger is off.
    /// - .debug: All the network informations(request and response) are printed.
    public var logLevel: NetworkingLoggerLogLevel {
        get { return logger.logLevel }
        set { logger.logLevel = newValue }
    }
    
    // MARK: - Business logic properties
    
    private let session: URLSession
    private let baseURL: URL
    
    /// The interceptor is used to adapt URL request and retry mechanism
    private var interceptor: NetworkingInterceptorProtocol?
    
    /// Instance of NetworkingLogger
    private var logger: NetworkingLogger = NetworkingLogger()
    
    /// The init of a Networking instance.
    /// - Parameter baseURL: The host baseURL for this instance of Networking
    /// - Parameter interceptor: The interceptor is used to adapt URL request and retry mechanism
    public init(baseURL: String, interceptor: NetworkingInterceptorProtocol? = nil) {
        guard let url = URL(string: baseURL) else { fatalError("Base URL cannot be invalid!") }
        self.baseURL = url
        self.interceptor = interceptor
        
        let configuration = URLSessionConfiguration.default
        self.session = .init(configuration: configuration)
    }
    
    // MARK: - iOS > 13 Protocols
    
    /// This is the func to use to make an HTTP call in Combine version.
    /// - Parameter request: The `NetworkingRequest` object with HTTP information request.
    /// - Returns  AnyPublisher<SuccessResponse, Error> where `SuccessResponse` is a Decodable to decode in HTTP response.
    @available(iOS 13.0, *)
    public func send<SuccessResponse: Decodable>(request: NetworkingRequest) -> AnyPublisher<SuccessResponse, Error> {
        send(request: request, decoder: JSONDecoder())
    }
    
    /// This is the func to use to make an HTTP call in Combine version using a custom decoder.
    /// - Parameters:
    ///   - request: The `NetworkingRequest` object with HTTP information request.
    ///   - decoder: The `JSONDecoder` used to decode the response.
    /// - Returns: AnyPublisher<SuccessResponse, Error> where `SuccessResponse` is a Decodable to decode in HTTP response.
    @available(iOS 13.0, *)
    public func send<SuccessResponse>(request: NetworkingRequest, decoder: JSONDecoder) -> AnyPublisher<SuccessResponse, Error> where SuccessResponse : Decodable {
        guard let finalUrl = makeUrl(path: request.path.url, queryItems: request.path.query) else {
            return Fail(error: NetworkingError.invalidUrl)
                .eraseToAnyPublisher()
        }
        
        let finalRequest = makeRequest(url: finalUrl, request: request)
        
        return send(request: finalRequest)
            .decode(type: SuccessResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }

    /// This is the func to use to make an HTTP multipart call in Combine version.
    /// - Parameters:
    ///   - request: The `NetworkingRequest` object with HTTP information request.
    ///   - medias: Array of `NetworkingMedia` object with media informations to upload.
    ///   - boundary: The boundary of HTTP multipart request.
    /// - Returns: AnyPublisher<SuccessResponse, Error> where `SuccessResponse` is a Decodable to decode in HTTP response.
    @available(iOS 13.0, *)
    public func send<SuccessResponse: Decodable>(request: NetworkingRequest, medias: [NetworkingMedia], boundary: String) -> AnyPublisher<SuccessResponse, Error> {
        send(request: request, medias: medias, boundary: boundary, decoder: JSONDecoder())
    }
    
    /// This is the func to use to make an HTTP multipart call in Combine version using a custom decoder.
    /// - Parameters:
    ///   - request: The `NetworkingRequest` object with HTTP information request.
    ///   - medias: Array of `NetworkingMedia` object with media informations to upload.
    ///   - boundary: The boundary of HTTP multipart request.
    ///   - decoder: The `JSONDecoder` used to decode the response.
    /// - Returns: AnyPublisher<SuccessResponse, Error> where `SuccessResponse` is a Decodable to decode in HTTP response.
    @available(iOS 13.0, *)
    public func send<SuccessResponse>(request: NetworkingRequest, medias: [NetworkingMedia], boundary: String, decoder: JSONDecoder) -> AnyPublisher<SuccessResponse, Error> where SuccessResponse : Decodable {
        guard let finalUrl = makeUrl(path: request.path.url, queryItems: request.path.query) else {
            return Fail(error: NetworkingError.invalidUrl)
                .eraseToAnyPublisher()
        }
        
        let finalRequest = makeMultipartURLRequest(url: finalUrl, request: request, medias: medias, boundary: boundary)
        
        return send(request: finalRequest)
            .decode(type: SuccessResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    // MARK: - iOS < 13 Protocols
    
    /// This is the func to use to make an HTTP call.
    /// - Parameters:
    ///   - request: The `NetworkingRequest` object with HTTP information request.
    ///   - completion: The closure with `Result`. `SuccessResponse` is a Decodable to decode in HTTP response.
    public func send<SuccessResponse: Decodable>(request: NetworkingRequest, completion: ((Result<SuccessResponse, Error>) -> Void)?) {
        send(request: request, decoder: JSONDecoder(), completion: completion)
    }
    
    /// This is the func to use to make an HTTP call using a custom decoder.
    /// - Parameters:
    ///   - request: The `NetworkingRequest` object with HTTP information request.
    ///   - decoder: The `JSONDecoder` used to decode the response.
    ///   - completion: The closure with `Result`. `SuccessResponse` is a Decodable to decode in HTTP response.
    public func send<SuccessResponse>(request: NetworkingRequest, decoder: JSONDecoder, completion: ((Result<SuccessResponse, Error>) -> Void)?) where SuccessResponse : Decodable {
        guard let finalUrl = makeUrl(path: request.path.url, queryItems: request.path.query) else {
            completion?(.failure(NetworkingError.invalidUrl))
            return
        }
        
        let request = makeRequest(url: finalUrl, request: request)
        send(request: request, completion: { (result) in
            switch result {
            case .success(let result):
                do {
                    let decodedObject = try decoder.decode(SuccessResponse.self, from: result)
                    completion?(.success(decodedObject))
                } catch {
                    completion?(.failure(NetworkingError.decodingFailed(error: error)))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        })
    }
    
    /// This is the func to use to make an HTTP multipart call.
    /// - Parameters:
    ///   - request: The `NetworkingRequest` object with HTTP information request.
    ///   - medias: Array of `NetworkingMedia` object with media informations to upload.
    ///   - boundary: The boundary of HTTP multipart request.
    ///   - completion: The closure with `Result`. `SuccessResponse` is a Decodable to decode in HTTP response.
    public func send<SuccessResponse: Decodable>(request: NetworkingRequest, medias: [NetworkingMedia], boundary: String, completion: ((Result<SuccessResponse, Error>) -> Void)?) {
        send(request: request, medias: medias, boundary: boundary, decoder: JSONDecoder(), completion: completion)
    }
    
    /// This is the func to use to make an HTTP multipart call using a custom decoder.
    /// - Parameters:
    ///   - request: The `NetworkingRequest` object with HTTP information request. 
    ///   - medias: Array of `NetworkingMedia` object with media informations to upload.
    ///   - boundary: The boundary of HTTP multipart request.
    ///   - decoder: The `JSONDecoder` used to decode the response.
    ///   - completion: The closure with `Result`. `SuccessResponse` is a Decodable to decode in HTTP response.
    public func send<SuccessResponse>(request: NetworkingRequest, medias: [NetworkingMedia], boundary: String, decoder: JSONDecoder, completion: ((Result<SuccessResponse, Error>) -> Void)?) where SuccessResponse : Decodable {
        guard let finalUrl = makeUrl(path: request.path.url, queryItems: request.path.query) else {
            completion?(.failure(NetworkingError.invalidUrl))
            return
        }
        
        let request = makeMultipartURLRequest(url: finalUrl, request: request, medias: medias, boundary: boundary)
        send(request: request, completion: { (result) in
            switch result {
            case .success(let result):
                do {
                    let decodedObject = try decoder.decode(SuccessResponse.self, from: result)
                    completion?(.success(decodedObject))
                } catch {
                    completion?(.failure(NetworkingError.decodingFailed(error: error)))
                }
                
            case .failure(let error):
                completion?(.failure(error))
            }
        })
    }
}

// MARK: - Private methods

private extension Networking {
    
    /// This method is used to build an `URL` object
    func makeUrl(path: String, queryItems: [URLQueryItem]?) -> URL? {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = baseURL.path + path
        components.queryItems = queryItems
        guard let url = components.url else { return nil }
        return url
    }
    
    /// This method is used to build an `URLRequest` object
    func makeRequest(url: URL, request: NetworkingRequest) -> URLRequest {
        var finalRequest = URLRequest(url: url)
        finalRequest.httpMethod = request.method.rawValue
        
        request.header?.forEach { (key, value) in
            if let value = value as? String {
                finalRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        switch request.body?.encoding {
        case .json:
            guard let dictionary = request.body?.data.dictionary else { break }
            finalRequest.httpBody = try? JSONSerialization.data(withJSONObject: dictionary)
        case .urlEncoded:
            guard let params = request.body?.data.dictionary else { break }
            let httpBody = params
                .map({ (key, value) -> String in
                    return "\(key)=\(value)"
                })
                .joined(separator: "&")
                .data(using: String.Encoding.utf8)
            finalRequest.httpBody = httpBody
        case .none:
            break
        }
        
        return finalRequest
    }
    
    /// This method is used to build an `URLRequest` object
    func makeMultipartURLRequest(url: URL, request: NetworkingRequest, medias: [NetworkingMedia]?, boundary: String) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        request.header?.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        urlRequest.httpBody = makeMultipartBody(request: request, medias: medias, boundary: boundary)
        return urlRequest
    }
    
    /// This method is used to build the HTTP multipart Body
    func makeMultipartBody(request: NetworkingRequest, medias: [NetworkingMedia]?, boundary: String) -> Data {
        
        func append(_ string: String, to data: inout Data) {
            guard let dataToAppend = string.data(using: .utf8) else {
                assertionFailure("Could not append data!")
                return
            }
            data.append(dataToAppend)
        }
        
        let lineBreak = "\r\n"
        var body = Data()
        
        let params = request.body?.data.dictionary
        params?.compactMap { $0 }
            .forEach { param in
                let valueString = String(describing: param.value)
                append("--\(boundary + lineBreak)", to: &body)
                append("Content-Disposition: form-data; name=\"\(param.key)\"\(lineBreak + lineBreak)", to: &body)
                append("\(valueString + lineBreak)", to: &body)
            }
        
        medias?.compactMap { $0 }
            .forEach { media in
                append("--\(boundary + lineBreak)", to: &body)
                append("Content-Disposition: form-data; name=\"\(media.key)\"; filename=\"\(media.filename)\"\(lineBreak)", to: &body)
                append("Content-Type: \(media.mimeType + lineBreak + lineBreak)", to: &body)
                body.append(media.data)
                append(lineBreak, to: &body)
            }
        
        append("--\(boundary)--\(lineBreak)", to: &body)
        
        return body
    }
    
}

// MARK: - Functions used with combine

@available(iOS 13.0, *)
private extension Networking {
    
    /// This func is the final step to make an HTTP call in Combine version using the `dataTaskPublisher`func.
    func send(request: URLRequest) -> AnyPublisher<Data, Error> {
        
        func publisher(_ output: URLSession.DataTaskPublisher.Output) -> AnyPublisher<Data, Error> {
            let response = output.response
            let data = output.data
            
            guard let httpResponse = output.response as? HTTPURLResponse else {
                return Fail(error: NetworkingError.invalidHTTPResponse)
                    .eraseToAnyPublisher()
            }
            
            let statusCode = httpResponse.statusCode
            switch statusCode {
            case 200...299:
                logger.logResponse(response, data: data)
                return Result.success(data)
                    .publisher
                    .eraseToAnyPublisher()
            default:
                let error = NetworkingError.underlying(
                    response: response,
                    data: data
                )
                
                logger.logResponse(response, data: data, error: error)
                
                return shouldRetry(
                    request: request,
                    error: error
                )
            }
        }
        
        var finalRequest = request
        if let interceptor = interceptor {
            finalRequest = interceptor.adapt(finalRequest)
        }
        
        logger.logRequest(finalRequest)
        
        return session.dataTaskPublisher(for: finalRequest)
            .mapError { $0 }
            .flatMap { publisher($0) }
            .eraseToAnyPublisher()
    }
    
    /// Func used to understand if the system should retry the request in Combine version
    func shouldRetry(request: URLRequest, error: Error) -> AnyPublisher<Data, Error> {
        guard let interceptor = interceptor else { return Fail(error: error).eraseToAnyPublisher() }
        
        return interceptor.retry(request, for: session, dueTo: error)
            .flatMap({ (retryResult) -> AnyPublisher<Data, Error> in
                switch retryResult {
                case .retry:
                    return self.send(request: request)
                case .doNotRetry:
                    return Fail(error: error).eraseToAnyPublisher()
                }
            })
            .eraseToAnyPublisher()
    }
    
}

// MARK: - Functions used without combine

private extension Networking {
    
    /// This func is the final step to make an HTTP call in non Comibne version using the `dataTask`func.
    func send(request: URLRequest, completion: ((Result<Data, Error>) -> Void)?) {
        var finalRequest = request
        
        if let interceptor = interceptor {
            finalRequest = interceptor.adapt(finalRequest)
        }
        
        logger.logRequest(finalRequest)
        
        let task = session.dataTask(with: finalRequest) { (data, response, error) in
            self.logger.logResponse(response, data: data, error: error)
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                
                switch statusCode {
                case 200...299:
                    if let data = data {
                        completion?(.success(data))
                    } else {
                        completion?(.failure(NetworkingError.underlying(response: httpResponse, data: nil)))
                    }
                default:
                    self.shouldRetry(request: request, error: NetworkingError.underlying(response: response, data: data)) { (completionResult) in
                        completion?(completionResult)
                    }
                }
            } else {
                completion?(.failure(NetworkingError.invalidHTTPResponse))
            }
        }
        task.resume()
    }
    
    /// Func used to understand if the system should retry the request
    func shouldRetry(request: URLRequest, error: Error, completion: ((Result<Data, Error>) -> Void)?)  {
        guard let interceptor = interceptor else {
            completion?(.failure(NetworkingError.other(error: error)))
            return
        }
        
        interceptor.retry(request, for: session, dueTo: error) { (retryResult) in
            switch retryResult {
            case .retry:
                self.send(request: request) { (completionResult) in
                    completion?(completionResult)
                }
            case .doNotRetry:
                completion?(.failure(NetworkingError.other(error: error)))
            }
        }
    }
    
}
