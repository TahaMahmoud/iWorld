//
//  RemoteCountriesDataSource.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Foundation

protocol RemoteCountriesDataSourceProtocol {
    func fetchCountries() async throws -> Countries
}

struct RemoteCountriesDataSource: RemoteCountriesDataSourceProtocol {
    func fetchCountries() async throws -> Countries {
        try await []
    }
}
