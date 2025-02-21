//
//  RemoteEndpoint.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation
public typealias NetworkHTTPParameters = [String: AnyHashable]
/// Represents a remote endpoint with all of its configurations.
public protocol RemoteEndpoint {
    typealias HTTPHeaders = [String: String]

    /// The base URL of the remote endpoint.
    var baseUrl: URL { get }

    /// The api version of the remote endpoint.
    var apiVersion: String? { get }

    /// The path of the remote endpoint.
    var path: String { get }

    /// The HTTP method used for requests to this endpoint.
    var httpMethod: HTTPMethod { get }

    /// The HTTP headers to be included in requests to this endpoint.
    var headers: HTTPHeaders? { get }

    /// Whether or not requests to this endpoint should wait
    /// until the internet connection is available before being sent.
    var waitsForInternetConnection: Bool { get }

    /// The retry policy that specifies when can requests to this endpoint be retried.
    var retryPolicy: RetryPolicy { get }

    /// The cache policy to be used when the device is connected to the internet.
    var connectedCachePolicy: URLRequest.CachePolicy { get }

    /// The cache policy to be used when the device is not connected to the internet.
    ///  - Note: Will not take effect if `waitsForInternetConnection` is set to `true`
    var unconnectedCachePolicy: URLRequest.CachePolicy { get }

    /// the authorization type to be used to authorise the user through different mechanism
    var authorizationType: AuthorizationType { get }
    /// The `Task` for the request.
    var requestTask: RequestParameterTask { get }

    var type: EndpointType { get }
}

public extension RemoteEndpoint {
    var waitsForInternetConnection: Bool {
        true
    }

    var retryPolicy: Networking.RetryPolicy {
        .neverRetry
    }

    var connectedCachePolicy: URLRequest.CachePolicy {
        .useProtocolCachePolicy
    }

    var unconnectedCachePolicy: URLRequest.CachePolicy {
        .useProtocolCachePolicy
    }

    var authorizationType: AuthorizationType {
        return .none
    }

    var apiVersion: String? {
        nil
    }

    var headers: HTTPHeaders? {
        nil
    }

    var requestTask: RequestParameterTask {
        .requestPlain
    }

    var type: EndpointType {
        .server
    }
}

public enum EndpointType: Equatable {
    case server
    case localFile(bundle: Bundle, fileName: String)
}
