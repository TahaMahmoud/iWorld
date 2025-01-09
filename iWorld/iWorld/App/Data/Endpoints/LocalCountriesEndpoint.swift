//
//  LocalCountriesEndpoint.swift
//  iWorld
//
//  Created by Taha Mahmoud on 09/01/2025.
//

import Foundation
import Networking

enum LocalCountriesEndpoint {
    case allCountries
}

extension LocalCountriesEndpoint: RemoteEndpoint {
    var baseUrl: URL {
        let baseURLString = "https://restcountries.com/v2"
        let baseURL = URL(string: baseURLString)
        return baseURL ?? URL(string: "")!
    }

    var path: String {
        switch self {
        case .allCountries:
            "all"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .allCountries:
            return .get
        }
    }

    var type: EndpointType {
        .localFile(bundle: .main, fileName: "countries")
    }
}
