# Networking

Networking library bring together `URLSession`, `Codable` and `Combine` to simplify the HTTP requests send. 

```swift
private let beerWebService: Networking = {
    var webService = Networking(baseURL: "https://api.punkapi.com/v2/", interceptor: CustomWebServiceInterceptor())
    webService.logLevel = .debug
    return webService
}()

let path = ("/beers", [URLQueryItem.init(name: "page", value: "1"), URLQueryItem.init(name: "per_page", value: "25")])
let request = NetworkingRequest(method: .get, path: path)

beerWebService.send(request: request)
```

The library works in two modes, Combine and canonical URLSessionDataTask

# How to install
## CocoaPods

```swift
pod 'Networking'
```

## Swift Package Manager

Add the following dependency to your Package.swift:

```swift
dependencies: [
    .package(url: "https://git.iquii.com/iquii-libraries/ios/networking-ios.git", .upToNextMajor(from: "1.0.0"))
]
```

Or add the dependency to your app using Xcode: File => Swift Packages => Add Package Dependency... and type the git repo url: https://git.iquii.com/iquii-libraries/ios/networking-ios.git

# Requirements

* iOS 12.0+ / macOS 10.15.2+
* Swift 5.2+
* Xcode 11.4+

# How to use

First, you must to create an instance of `Networking` with `baseURL` and optionally `NetworkingInterceptorProtocol`(see section [NetworkingInterceptorProtocol](#NetworkingInterceptorProtocol) to know more)

```swift
var webService = Networking(baseURL: "https://api.punkapi.com/v2/", interceptor: CustomWebServiceInterceptor())
```
At this point the only thing to do is to create a `NetworkingRequest` in this way: 

```swift
let path = ("/beers", [URLQueryItem.init(name: "page", value: "1"), URLQueryItem.init(name: "per_page", value: "25")])
let request = NetworkingRequest(method: .get, path: path)
```
and after make the request. You can choose to handle the request with `Combine` as a `Publisher`, or handle it as canonical `URLSessionDataTask`

```swift
// Combine -> return an `AnyPublisher` object of `Decodable` type. The Decodable type is the model that you want to decode.
webService.send(request: request)
```

```swift
// Canonical URLSessionDataTask -> Will be called a closure with results of type (Result<[Decodable], Error>) -> Void. The Decodable type is the model that you want to decode.
webService.send(request) { (results) in
    completion(results)
}
```

# NetworkingInterceptorProtocol

The `NetworkingInterceptorProtocol` is used to adapt URL request and to define retry mechanism of failed requests. The protocol must to implement the `adapt` method and `retry` method and it's optional.

## Adapt
The `adapt` method is used to inspects and adapts the specified `URLRequest` in some manner and return the request. This is an example od use it: 

```swift
func adapt(_ urlRequest: URLRequest) -> URLRequest {
    var request = urlRequest
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    return request
}
```

## Retry
This func must be used to execute code before retry a failed request. in Combine version, after the code, you must return a `Future` with `RetryResult`. In the normal version instead, tou must call a closure with `RetryResult`. Here are the examples: 

```swift
// Combine version
func retry(_ request: URLRequest, for session: URLSession, dueTo error: Error?) -> AnyPublisher<RetryResult, Error> {
    return Future { promise in
        webService.sendRequest(request: request)
            .sink { completion in
                promise(.success(.doNotRetry))
                } receiveValue: { results in
                promise(.success(.retry))
                }
        }
        .eraseToAnyPublisher()
}
```

```swift
// Normal version
func retry(_ request: URLRequest, for session: URLSession, dueTo error: Error?, completion: @escaping (RetryResult) -> Void) {
    webService.sendRequest(request: request) { completionResult in
        switch completionResult {
        case .success(_):
            completion(.retry)
        case .failure(_):
            completion(.doNotRetry)
        }
    }
}
```
