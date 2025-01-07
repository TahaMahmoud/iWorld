//
//  NetworkManagerProtocol.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Combine
import Core

public protocol NetworkManagerProtocol {
    func executeRequest<T: Decodable, E: Decodable>(
        _ endpoint: any RemoteEndpoint,
        appErrors: [any AppErrorProtocol]?
    ) async -> RemoteResponse<T, E>
}
