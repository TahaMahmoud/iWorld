//
//  ParameterEncodingProtocol.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation
public protocol ParameterEncodingProtocol {
    func encode(urlRequest: inout URLRequest, with parameters: NetworkHTTPParameters) throws
}
