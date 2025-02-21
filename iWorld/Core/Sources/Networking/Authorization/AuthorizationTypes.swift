//
//  AuthorizationType.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation
public enum AuthorizationType: Equatable {
    case none
    case token
    case operationToken(token: String)
    case accessToken(token: String)
}

public extension AuthorizationType {
    var key: String {
        switch self {
        case .none:
            return ""
        case .token:
            return "Authorization"
        case .operationToken:
            return "operationToken"
        case .accessToken:
            return "x-special-access-token"
        }
    }

    var prefix: String? {
        switch self {
        case .token:
            return "Bearer"
        default:
            return nil
        }
    }
}
