//
//  NetworkErrorCode.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation
public struct NetworkErrorCode {
    public static let noContent = 204
    public static let badRequest = 400
    public static let unauthorized = 401
    public static let forbidden = 403
    public static let validationError = 422
    public static let notFound = 404
    public static let preconditionRequired = 428
    public static let malformedResponse = 999
    public static let custom = 1000
    public static let tooManyRequests = 429
    public static let malformedData = 1001
    public static let waf = 511
    public static let timeout = 408
    public static let noInternet = 1009
    public static let sessionExpired = 412
    public static let conflict = 409
    public static let serverMaintenance = 503
    public static let serverError = 500
}
