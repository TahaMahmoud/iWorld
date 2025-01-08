//
//  GetCountriesUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation
import Factory

protocol GetCountriesUseCaseProtocol {
    @discardableResult func execute(limit: Int?) async -> [Country]
    func execute(query: String, region: Region) -> [Country]
    func execute(region: Region) -> [Country]
}

struct GetCountriesUseCase: GetCountriesUseCaseProtocol {
    @Injected(\.countriesRepo) private var repository

    @discardableResult
    func execute(limit: Int?) async -> [Country] {
        var countries = repository.getCountries()

        if countries.isEmpty {
            await repository.fetchCountriesData()
            countries = repository.getCountries()
        }

        return Array(countries.prefix(limit ?? countries.count))
    }

    func execute(query: String, region: Region) -> [Country] {
        let countries = repository.getCountries()

        return countries.filter {
            ($0.name?.lowercased().contains(query.lowercased()) ?? false) &&
            ($0.region == region)
        }
    }

    func execute(region: Region) -> [Country] {
        let countries = repository.getCountries()

        return countries.filter {
            $0.region?.rawValue.contains(region.rawValue) ?? false
        }
    }
}
