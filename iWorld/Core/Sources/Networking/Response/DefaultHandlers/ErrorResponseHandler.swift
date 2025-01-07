//
//  ResponseHandler+failure.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation
public class ErrorResponseHandler: ErrorResponseHandlerProtocol {
    public var decoder: JSONDecoder

    public required init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    public func handle<E: Decodable>(
        requestInfo: ResponseInfo
    )
        -> NetworkRequestError<E> {
        // if the failure included in the service
        let endPointStatusCode = requestInfo.endpointErrors?.first.map { $0.statusCode }
        guard requestInfo.statusCode == endPointStatusCode else {
            return handleServiceFailure(statusCode: requestInfo.statusCode)
        }

        return handleEndPointError(
            data: requestInfo.data,
            statusCode: requestInfo.statusCode,
            endpointErrors: requestInfo.endpointErrors
        )
    }

    func handleServiceFailure<E: Decodable>(statusCode: Int) -> NetworkRequestError<E> {
        switch statusCode {
        case NetworkErrorCode.noContent:
            return .failure(reason: .noContent)
        case NetworkErrorCode.unauthorized:
            return .failure(reason: .unauthorized)
        case NetworkErrorCode.badRequest:
            return .failure(reason: .badRequest)
        case NetworkErrorCode.notFound:
            return .failure(reason: .notFound)
        case NetworkErrorCode.timeout:
            return .failure(reason: .timeout)
        case NetworkErrorCode.tooManyRequests:
            return .failure(reason: .tooManyRequests)
        case NetworkErrorCode.sessionExpired:
            return .failure(reason: .sessionExpired)
        case NetworkErrorCode.conflict:
            return .failure(reason: .conflict)
        case NetworkErrorCode.serverMaintenance:
            return .failure(reason: .serverMaintenance)
        case NetworkErrorCode.preconditionRequired:
            return .failure(reason: .preconditionRequired)
        case NetworkErrorCode.serverError:
            return .failure(reason: .serverError)
        default:
            return .failure(reason: .other(statusCode: statusCode))
        }
    }

    func handleEndPointError<E: Decodable>(
        data: Data?,
        statusCode: Int,
        endpointErrors: [any AppErrorProtocol]?
    )
        -> NetworkRequestError<E> {
        do {
            guard let data = data else {
                return .failure(reason: .noContent)
            }
            let responseModel = try decoder.decode(E.self, from: data)
            return .appError(error: responseModel)
        } catch {
            return .failure(reason: .encodingFailed)
        }
    }
}
