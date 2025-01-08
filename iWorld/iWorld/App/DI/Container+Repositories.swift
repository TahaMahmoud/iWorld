//
//  Container+Repositories.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Foundation

extension DIContainer {
    static var countriesRepo: CountriesRepositoryProtocol {
        CountriesRepository(
            remoteCountriesDataSource: DIContainer.remoteDataSource,
            localCountriesDataSource: DIContainer.localDataSource
        )
    }
}
