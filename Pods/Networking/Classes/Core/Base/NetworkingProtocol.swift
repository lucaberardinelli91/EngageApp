//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import Combine

public protocol NetworkingProtocol {
    // MARK: - iOS > 13 Protocols
    
    /// This is the func to use to make an HTTP call in Combine version.
    /// - Parameter request: The `NetworkingRequest` object with HTTP information request.
    /// - Returns  AnyPublisher<SuccessResponse, Error> where `SuccessResponse` is a Decodable to decode in HTTP response.
    @available(iOS 13.0, *)
    func send<SuccessResponse: Decodable>(request: NetworkingRequest) -> AnyPublisher<SuccessResponse, Error>
    
    /// This is the func to use to make an HTTP call in Combine version using a custom decoder.
    /// - Parameters:
    ///   - request: The `NetworkingRequest` object with HTTP information request.
    ///   - decoder: The `JSONDecoder` used to decode the response.
    /// - Returns: AnyPublisher<SuccessResponse, Error> where `SuccessResponse` is a Decodable to decode in HTTP response.
    @available(iOS 13.0, *)
    func send<SuccessResponse: Decodable>(request: NetworkingRequest, decoder: JSONDecoder) -> AnyPublisher<SuccessResponse, Error>
    
    /// This is the func to use to make an HTTP multipart call in Combine version.
    /// - Parameters:
    ///   - request: The `NetworkingRequest` object with HTTP information request.
    ///   - medias: Array of `NetworkingMedia` object with media informations to upload.
    ///   - boundary: The boundary of HTTP multipart request.
    /// - Returns: AnyPublisher<SuccessResponse, Error> where `SuccessResponse` is a Decodable to decode in HTTP response.
    @available(iOS 13.0, *)
    func send<SuccessResponse: Decodable>(request: NetworkingRequest, medias: [NetworkingMedia], boundary: String) -> AnyPublisher<SuccessResponse, Error>
    
    /// This is the func to use to make an HTTP multipart call in Combine version using a custom decoder.
    /// - Parameters:
    ///   - request: The `NetworkingRequest` object with HTTP information request.
    ///   - medias: Array of `NetworkingMedia` object with media informations to upload.
    ///   - boundary: The boundary of HTTP multipart request.
    ///   - decoder: The `JSONDecoder` used to decode the response.
    /// - Returns: AnyPublisher<SuccessResponse, Error> where `SuccessResponse` is a Decodable to decode in HTTP response.
    @available(iOS 13.0, *)
    func send<SuccessResponse: Decodable>(request: NetworkingRequest, medias: [NetworkingMedia], boundary: String, decoder: JSONDecoder) -> AnyPublisher<SuccessResponse, Error>
    
    // MARK: - iOS < 13 Protocols
    
    /// This is the func to use to make an HTTP call.
    /// - Parameters:
    ///   - request: The `NetworkingRequest` object with HTTP information request.
    ///   - completion: The closure with `Result`. `SuccessResponse` is a Decodable to decode in HTTP response.
    func send<SuccessResponse: Decodable>(request: NetworkingRequest, completion: ((Result<SuccessResponse, Error>) -> Void)?)
    
    /// This is the func to use to make an HTTP call using a custom decoder.
    /// - Parameters:
    ///   - request: The `NetworkingRequest` object with HTTP information request.
    ///   - decoder: The `JSONDecoder` used to decode the response.
    ///   - completion: The closure with `Result`. `SuccessResponse` is a Decodable to decode in HTTP response.
    func send<SuccessResponse: Decodable>(request: NetworkingRequest, decoder: JSONDecoder, completion: ((Result<SuccessResponse, Error>) -> Void)?)
    
    /// This is the func to use to make an HTTP multipart call.
    /// - Parameters:
    ///   - request: The `NetworkingRequest` object with HTTP information request.
    ///   - medias: Array of `NetworkingMedia` object with media informations to upload.
    ///   - boundary: The boundary of HTTP multipart request.
    ///   - completion: The closure with `Result`. `SuccessResponse` is a Decodable to decode in HTTP response.
    func send<SuccessResponse: Decodable>(request: NetworkingRequest, medias: [NetworkingMedia], boundary: String, completion: ((Result<SuccessResponse, Error>) -> Void)?)
    
    /// This is the func to use to make an HTTP multipart call using a custom decoder.
    /// - Parameters:
    ///   - request: The `NetworkingRequest` object with HTTP information request.
    ///   - medias: Array of `NetworkingMedia` object with media informations to upload.
    ///   - boundary: The boundary of HTTP multipart request.
    ///   - decoder: The `JSONDecoder` used to decode the response.
    ///   - completion: The closure with `Result`. `SuccessResponse` is a Decodable to decode in HTTP response.
    func send<SuccessResponse: Decodable>(request: NetworkingRequest, medias: [NetworkingMedia], boundary: String, decoder: JSONDecoder, completion: ((Result<SuccessResponse, Error>) -> Void)?)
}
