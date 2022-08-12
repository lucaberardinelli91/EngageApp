//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

/** This class is used to log a HTTP request and his response
 */
class NetworkingLogger {
    
    // MARK: - Internal properties
    
    var logLevel = NetworkingLoggerLogLevel.debug
    
    // MARK: - Internal methods
    
    func logRequest(_ request: URLRequest) {
        guard logLevel != .none else { return}
        
        print("\n⬆️ ----- START REQUEST ----- ⬆️")
        if let url = request.url {
            print("    -- Url: \(url)")
        }
        if let method = request.httpMethod {
            print("    -- Method: \(method)")
        }
        if let body = request.httpBody, let stringBody = String(data: body, encoding: .utf8) {
            print("    -- Body : \(stringBody)")
        }
        if let headers = request.allHTTPHeaderFields, headers.count > 0 {
            print("    -- Headers")
            for (key, value) in headers {
                print("        -- \(key): \(value)")
            }
        }
        print("⬆️ ----- END REQUEST ----- ⬆️")
    }
    
    func logResponse(_ response: URLResponse?, data: Data?, error: Error? = nil) {
        guard logLevel != .none else { return }
        
        print("\n⬇️ ----- START RESPONSE ----- ⬇️")
        if let response = response as? HTTPURLResponse {
            print("    -- Url: \(response.url?.absoluteString ?? "NO URL")")
            
            let statusCode = response.statusCode
            if statusCode >= 200 && statusCode < 300 {
                print("    -- Status Code: ✅ \(statusCode)")
            } else {
                print("    -- Status Code: ❌ \(statusCode)")
            }
        } else {
            print("    -- Response: NO RESPONSE")
        }
        if let data = data {
            if let stringBody = String(data: data, encoding: .utf8) {
                print("    -- Body : \(stringBody)")
            } else {
                print("    -- Body : NO HTTP BODY")
            }
        } else {
            print("    -- data: NO DATA")
        }
        if let error = error {
            print("    -- Error: 🚨 \(error.localizedDescription)")
        } else {
            print("    -- Error: 👌 NO ERROR")
        }
        print("⬇️ ----- END RESPONSE ----- ⬇️")
    }
    
}
