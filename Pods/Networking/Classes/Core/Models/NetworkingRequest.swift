//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

/// Public struct used to make an HTTP request. The `Body`struct contains the Encodable object to encode in the reqeust.
public struct NetworkingRequest {

    // MARK: - Public properties
    
    public typealias Path = (url: String, query: [URLQueryItem]?)
    public typealias Body = (data: Encodable, encoding: Encoding)
 
    public enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    public enum Encoding {
        case json
        case urlEncoded
    }

    public var method: HTTPMethod
    public var path: Path
    public var header: [String:Any]?
    public var body: Body?
    
    // MARK: - Object lifecycle
    
    public init(method: HTTPMethod, path: Path, header: [String:Any]? = nil, body: Body? = nil) {
        self.method = method
        self.path = path
        self.header = header
        self.body = body
    }
    
}
