//
//  NetworkManager+LocalExecute.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation

extension NetworkManager {
    func getLocalResponse<T: Decodable, E: Decodable>(
        source: RemoteEndpoint,
        bundle: Bundle,
        fileName: String,
        appErrors: [any AppErrorProtocol]?
    ) -> RemoteResponse<T, E> {
        let fileUrl = bundle.url(forResource: fileName, withExtension: "json")
        let data = try? Data(contentsOf: fileUrl!)

        let localResponse = HTTPURLResponse(
            url: fileUrl ?? URL(string: "")!,
            statusCode: 200,
            httpVersion: "HTTP/1.1",
            headerFields: nil
        )!
        let requestInfo = ResponseInfo(
            data: data,
            statusCode: 200,
            endpointErrors: appErrors
        )

        let responseHandler = SuccessResponseHandler(decoder: responseHandler.decoder)

        let result: Result<T, NetworkRequestError<E>> = responseHandler.handle(requestInfo: requestInfo)
        let remoteResponse = RemoteResponse<T, E>(
            source: source,
            urlResponse: localResponse,
            data: data,
            result: result
        )

        return remoteResponse
    }
}
