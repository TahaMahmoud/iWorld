//
//  NetworkRequestFactory.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation

public final class NetworkRequestFactory<E: Decodable> {
    var authProvider: AuthTokenProviderProtocol?
    var encoder: JSONEncoder

    init(
        authProvider: AuthTokenProviderProtocol?,
        encoder: JSONEncoder
    ) {
        self.authProvider = authProvider
        self.encoder = encoder
    }

    public func generateRequest(isConnected: Bool, endpoint: RemoteEndpoint) throws -> URLRequest {
        guard let url = getFullURLPath(
            baseUrl: endpoint.baseUrl,
            apiVersion: endpoint.apiVersion,
            path: endpoint.path
        ) else {
            throw NetworkRequestError<E>.failure(reason: .badRequest)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        urlRequest.cachePolicy = isConnected ? endpoint.connectedCachePolicy : endpoint.unconnectedCachePolicy
        setAuthorizationType(&urlRequest, endpoint: endpoint)
        buildHeaders(&urlRequest, endpoint: endpoint)
        try? encodeParameters(&urlRequest, endpoint: endpoint)
        return urlRequest
    }

    private func encodeParameters(_ urlRequest: inout URLRequest, endpoint: RemoteEndpoint) throws {
        switch endpoint.requestTask {
        case .requestPlain:
            let contentTypeHeaderName = "Content-Type"
            if urlRequest.value(forHTTPHeaderField: contentTypeHeaderName) == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: contentTypeHeaderName)
            }
        case let .requestJSONEncodable(encodable):
            let parameterEncoder = JSONParameterEncoder<E>()
            try? parameterEncoder.encoded(
                urlRequest: &urlRequest,
                encodable: encodable,
                encoder: encoder
            )

        case let .requestCustomJSONEncodable(encodable, encoder):
            let parameterEncoder = JSONParameterEncoder<E>()
            try? parameterEncoder.encoded(urlRequest: &urlRequest, encodable: encodable, encoder: encoder)

        case let .requestParameters(parameters, parameterEncoding):
            try parameterEncoding.encode(
                errorType: E.self,
                urlRequest: &urlRequest,
                bodyParameters: parameters,
                urlParameters: parameters
            )
        case let .requestCompositeParameters(bodyParameters, bodyEncoding, urlParameters):
            try? bodyEncoding.encode(
                errorType: E.self,
                urlRequest: &urlRequest,
                bodyParameters: bodyParameters,
                urlParameters: urlParameters
            )

            let urlParameterEncoder = URLParameterEncoder<E>()
            try? urlParameterEncoder.encode(urlRequest: &urlRequest, with: urlParameters)

        case let .requestCompositeCustomJSONEncodable(encodable, encoder, urlParameters):
            let bodyParameterEncoder = JSONParameterEncoder<E>()
            let urlParameterEncoder = URLParameterEncoder<E>()

            try? bodyParameterEncoder.encoded(urlRequest: &urlRequest, encodable: encodable, encoder: encoder)
            try? urlParameterEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
        }
    }

    private func getFullURLPath(baseUrl: URL, apiVersion: String?, path: String) -> URL? {
        let validURL: String

        if let apiVersion = apiVersion {
            validURL = "\(baseUrl)/\(apiVersion)/\(path)"
        } else {
            validURL = "\(baseUrl)/\(path)"
        }

        return URL(string: validURL)
    }

    private func setAuthorizationType(_ request: inout URLRequest, endpoint: RemoteEndpoint) {
        let prefix = endpoint.authorizationType.prefix ?? ""
        let key = endpoint.authorizationType.key
        var apiToken = ""

        switch endpoint.authorizationType {
        case .token:
            apiToken = authProvider?.bearerToken ?? ""

        case let .operationToken(token):
            apiToken = token

        case let .accessToken(token):
            apiToken = token

        default:
            return
        }

        if endpoint.authorizationType != .none, prefix.isEmpty {
            request.setValue(
                "\(apiToken)",
                forHTTPHeaderField: key
            )
        } else if endpoint.authorizationType != .none, !prefix.isEmpty {
            request.setValue(
                "\(prefix) \(apiToken)",
                forHTTPHeaderField: key
            )
        }
    }

    private func buildHeaders(_ request: inout URLRequest, endpoint: RemoteEndpoint) {
        for (headerField, value) in endpoint.headers ?? [:] {
            request.setValue(value, forHTTPHeaderField: headerField)
        }
    }
}
