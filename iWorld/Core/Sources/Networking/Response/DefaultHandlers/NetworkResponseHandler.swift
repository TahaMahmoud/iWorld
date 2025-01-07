//
//  NetworkResponseHandler.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation
public class NetworkResponseHandler: ResponseHandler {
    public var decoder: JSONDecoder
    public var encoder: JSONEncoder
    public var errorHandler: ErrorResponseHandlerProtocol
    public var successHandler: SuccessResponseHandlerProtocol

    public init(
        errorHandler: ErrorResponseHandlerProtocol = ErrorResponseHandler(),
        successHandler: SuccessResponseHandlerProtocol = SuccessResponseHandler(),
        decoder: JSONDecoder = JSONDecoder(),
        encoder: JSONEncoder = JSONEncoder()
    ) {
        self.errorHandler = errorHandler
        self.successHandler = successHandler

        self.decoder = decoder
        self.encoder = encoder

        self.errorHandler.decoder = decoder
        self.successHandler.decoder = decoder
    }
}
