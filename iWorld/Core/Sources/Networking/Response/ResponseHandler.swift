//
//  ResponseHandler.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation
public struct ResponseInfo {
    var data: Data?
    var statusCode: Int
    var endpointErrors: [any AppErrorProtocol]?
    public init(data: Data? = nil, statusCode: Int, endpointErrors: [any AppErrorProtocol]? = nil) {
        self.data = data
        self.statusCode = statusCode
        self.endpointErrors = endpointErrors
    }
}

public protocol ResponseHandler {
    var errorHandler: ErrorResponseHandlerProtocol { get set }
    var successHandler: SuccessResponseHandlerProtocol { get set }
    var decoder: JSONDecoder { get set }
    var encoder: JSONEncoder { get set }

    func handleResponse<T: Decodable, E: Decodable>(
        responeInfo: ResponseInfo
    )
        -> Result<T, NetworkRequestError<E>>
}

public protocol ErrorResponseHandlerProtocol {
    var decoder: JSONDecoder { get set }
    init(decoder: JSONDecoder)
    func handle<E: Decodable>(
        requestInfo: ResponseInfo
    )
        -> NetworkRequestError<E>
}

public protocol SuccessResponseHandlerProtocol {
    var decoder: JSONDecoder { get set }
    init(decoder: JSONDecoder)
    func handle<T: Decodable, E: Decodable>(
        requestInfo: ResponseInfo
    )
        -> Result<T, NetworkRequestError<E>>
}
