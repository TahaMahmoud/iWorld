//
//  RemoteCountriesDataSource.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Foundation
import Networking
import Factory

protocol RemoteCountriesDataSourceProtocol {
    func fetchCountries() async -> [Country]
}

struct RemoteCountriesDataSource: RemoteCountriesDataSourceProtocol {
    @Injected(\.networkManager) private var networkingManger

    func fetchCountries() async -> [Country] {
        let endpoint = RemoteCountriesEndpoint.allCountries

        let result: Result<[Country], NetworkRequestError<AppError>>
        result = await networkingManger.executeRequest(
            endpoint,
            appErrors: nil
        ).result

        switch result {
        case let .success(countries):
            return countries
        case .failure:
            return []
        }
    }
}
