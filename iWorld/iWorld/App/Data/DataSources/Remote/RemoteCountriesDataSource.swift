//
//  RemoteCountriesDataSource.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Foundation
import Networking

protocol RemoteCountriesDataSourceProtocol {
    func fetchCountries() async throws -> Countries
}

struct RemoteCountriesDataSource: RemoteCountriesDataSourceProtocol {
    private let networkingManger: NetworkManagerProtocol

    public init(networkingManger: NetworkManagerProtocol = NetworkManager(
        responseHandler: NetworkResponseHandler(), authProvider: nil
    )) {
        self.networkingManger = networkingManger
    }

    func fetchCountries() async -> Countries {
        let endpoint = CountriesEndpoint.allCountries

        let result: Result<Countries, NetworkRequestError<AppError>>
        result = await networkingManger.executeRequest(
            endpoint,
            appErrors: nil
        ).result

        switch result {
        case let .success(countries):
            return countries
        case let .failure(error):
            return []
        }
    }
}
