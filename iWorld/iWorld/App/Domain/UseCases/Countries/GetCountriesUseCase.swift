//
//  GetCountriesUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation

protocol GetCountriesUseCaseProtocol {
    func execute(limit: Int?) -> Countries
    func execute(query: String) -> Countries
    func execute(region: Region) -> Countries
}

struct GetCountriesUseCase: GetCountriesUseCaseProtocol {
    private let repository: CountriesRepoProtocol

    init(repository: CountriesRepoProtocol = CountriesRepository()) {
        self.repository = repository
    }

    func execute(limit: Int?) -> Countries {
        let countries = repository.getCountries()
        return Array(countries.prefix(limit ?? countries.count))
    }

    func execute(query: String) -> Countries {
        let countries = repository.getCountries()

        return countries.filter {
            $0.name?.lowercased().contains(query.lowercased()) ?? false
        }
    }

    func execute(region: Region) -> Countries {
        let countries = repository.getCountries()

        return countries.filter {
            $0.region?.rawValue.contains(region.rawValue) ?? false
        }
    }
}
