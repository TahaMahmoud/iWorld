//
//  RequestParameterTask.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation
struct AnyEncodable: Encodable {

    private let encodable: Encodable

    public init(_ encodable: Encodable) {
        self.encodable = encodable
    }

    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}

public enum RequestParameterTask {
    /// A request with no additional data.
    case requestPlain
//    /// A request body set with `Encodable` type
    case requestJSONEncodable(Encodable)
    /// A request body set with `Encodable` type and custom encoder
    case requestCustomJSONEncodable(Encodable, encoder: JSONEncoder = JSONEncoder())
    /// A requests body set with encoded parameters.
    case requestParameters(parameters: NetworkHTTPParameters, encoding: ParameterEncoding)
    /// A requests body set with encoded parameters combined with url parameters.
    case requestCompositeParameters(bodyParameters: NetworkHTTPParameters,
                                    bodyEncoding: ParameterEncoding,
                                    urlParameters: NetworkHTTPParameters)
    /// A request body set with `Encodable` type and custom encoder combined with url parameters.
    case requestCompositeCustomJSONEncodable(Encodable,
                                                  encoder: JSONEncoder = JSONEncoder(),
                                                  urlParameters: NetworkHTTPParameters)
}
