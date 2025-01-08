//
//  GetBordersUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Foundation

protocol GetBordersUseCaseProtocol {
    func execute(countryCode: String) -> [Country]
}

struct GetBordersUseCase: GetBordersUseCaseProtocol {
    private let repository: CountriesRepositoryProtocol

    init(repository: CountriesRepositoryProtocol = DIContainer.countriesRepo) {
        self.repository = repository
    }

    func execute(countryCode: String) -> [Country] {
        let countries = repository.getCountries()

        let borders = countries.first {
            $0.alpha3Code == countryCode
        }?.borders ?? []

        var borderCountries: [Country] = []

        for borderCode in borders {
            let country = countries.first {
                $0.alpha3Code == borderCode
            }

            if let country {
                borderCountries.append(country)
            }
        }

        return borderCountries
    }
}
