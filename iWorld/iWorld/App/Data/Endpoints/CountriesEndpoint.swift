//
//  CountriesEndpoint.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Core
import Foundation
import Networking

enum CountriesEndpoint {
    case allCountries
}

extension CountriesEndpoint: RemoteEndpoint {
    var baseUrl: URL {
        let baseURLString = "https://restcountries.com/v2/"
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
}
