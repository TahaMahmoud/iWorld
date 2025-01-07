//
//  NetworkManager+helper.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation
extension NetworkManager {
    func getSuccess<T: Decodable, E: Decodable>(
        source: RemoteEndpoint,
        data: Data,
        response: URLResponse,
        appErrors: [any AppErrorProtocol]?
    ) -> RemoteResponse<T, E> {
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        let requestInfo = ResponseInfo(
            data: data,
            statusCode: statusCode,
            endpointErrors: appErrors
        )
        let result: Result<T, NetworkRequestError<E>> = responseHandler.handleResponse(
            responeInfo: requestInfo
        )
        let remoteResponse = RemoteResponse<T, E>(
            source: source,
            urlResponse: response,
            data: data,
            result: result
        )

        return remoteResponse
    }

    func getError<T, E: Decodable>(
        source: RemoteEndpoint,
        urlResponse: URLResponse = URLResponse(),
        data: Data? = nil,
        error: NetworkRequestError<E>
    ) -> RemoteResponse<T, E> {
        let remoteResponse = RemoteResponse<T, E>(
            source: source,
            urlResponse: urlResponse,
            data: data,
            result: .failure(error)
        )
        return remoteResponse
    }
}
