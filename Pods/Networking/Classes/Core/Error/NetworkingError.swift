//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

/// Enum for errors
public enum NetworkingError: Error {
    case invalidUrl
    case invalidHTTPResponse
    case sessionFailed(error: URLError)
    case decodingFailed(error: Error)
    case other(error: Error)
    case underlying(response: URLResponse?, data: Data?)
  }
