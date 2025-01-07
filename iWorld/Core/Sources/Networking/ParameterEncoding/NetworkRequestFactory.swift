//
//  ParameterEncoding.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation
public enum ParameterEncoding {
    case url
    case query
    case httpBody
    case json
}

/// An enum which holds a different types of parameter encoding.
public extension ParameterEncoding {
    func encode<E: Decodable>(
        errorType: E.Type,
        urlRequest: inout URLRequest,
        bodyParameters: NetworkHTTPParameters?,
        urlParameters: NetworkHTTPParameters?
    ) throws {
        do {
            switch self {
            case .url:
                guard let urlParameters = urlParameters else { return }
                let encoder = DataParameterUrlEncoder<E>()
                try encoder.encode(urlRequest: &urlRequest, with: urlParameters)

            case .json:
                if let bodyParameters = bodyParameters, !bodyParameters.isEmpty {
                    let encoder = JSONParameterEncoder<E>()
                    try encoder.encode(urlRequest: &urlRequest, with: bodyParameters)
                }

            case .query:
                guard let urlParameters = urlParameters else { return }
                let encoder = URLParameterEncoder<E>()
                try encoder.encode(urlRequest: &urlRequest, with: urlParameters)

            case .httpBody:
                guard let bodyParameters = bodyParameters else { return }
                let encoder = DataParameterEncoder<E>()
                try encoder.encode(urlRequest: &urlRequest, with: bodyParameters)
            }
        } catch {
            throw error
        }
    }
}

/// A struct which is used in encoding url parameters into encoded query.
public struct URLParameterEncoder<E: Decodable>: ParameterEncodingProtocol {
    public func encode(urlRequest: inout URLRequest, with parameters: NetworkHTTPParameters) throws {
        guard let url = urlRequest.url else {
            throw NetworkRequestError<E>.failure(reason: .missingUrl)
        }
        guard var urlComponents = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false),
            !parameters.isEmpty else { return }
        urlComponents.setQueryItems(with: parameters)
        urlRequest.url = urlComponents.url
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}

/// A struct which is used in encoding body parameters to json data
public struct JSONParameterEncoder<E: Decodable>: ParameterEncodingProtocol {
    public func encode(urlRequest: inout URLRequest, with parameters: NetworkHTTPParameters) throws {
        do {
            let jsonData = try JSONSerialization.data(
                withJSONObject: serializedParameters(parameters),
                options: .prettyPrinted
            )
            urlRequest.httpBody = jsonData
            let contentTypeHeaderName = "Content-Type"
            if urlRequest.value(forHTTPHeaderField: contentTypeHeaderName) == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: contentTypeHeaderName)
            }
        } catch {
            throw NetworkRequestError<E>.failure(reason: .encodingFailed)
        }
    }

    func encoded(urlRequest: inout URLRequest, encodable: Encodable, encoder: JSONEncoder = JSONEncoder()) throws {
        do {
            let encodable = AnyEncodable(encodable)
            urlRequest.httpBody = try encoder.encode(encodable)

            let contentTypeHeaderName = "Content-Type"
            if urlRequest.value(forHTTPHeaderField: contentTypeHeaderName) == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: contentTypeHeaderName)
            }

        } catch {
            throw NetworkRequestError<E>.failure(reason: .encodingFailed)
        }
    }

    func serializedParameters(_ parameters: NetworkHTTPParameters) -> [String: Any] {
        var serializedParameters: [String: Any] = [:]
        for (key, component) in parameters {
            serializedParameters[key] = component
        }

        return serializedParameters
    }
}

/// A struct which is used in encoding body parameters to data utf8
public struct DataParameterEncoder<E: Decodable>: ParameterEncodingProtocol {
    public func encode(urlRequest: inout URLRequest, with parameters: NetworkHTTPParameters) throws {
        var urlComponents = URLComponents()
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        urlRequest.httpBody = urlComponents.percentEncodedQuery?.data(using: .utf8)
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
    }
}

public struct DataParameterUrlEncoder<E: Decodable>: ParameterEncodingProtocol {
    public func encode(urlRequest: inout URLRequest, with parameters: NetworkHTTPParameters) throws {
        urlRequest.httpBody = Data(urlEncoded(formDataSet: parameters).utf8)
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
    }

    func urlEncoded(formDataSet: NetworkHTTPParameters) -> String {
        return formDataSet.map { key, value in
            key + "=\(value)"
        }
        .joined(separator: "&")
    }
}

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: Any]) {
        queryItems = parameters.map {
            URLQueryItem(
                name: $0.key,
                value: "\($0.value)")
        }
    }
}
