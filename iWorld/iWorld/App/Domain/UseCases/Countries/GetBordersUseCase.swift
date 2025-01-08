//
//  GetBordersUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Foundation

protocol GetBordersUseCaseProtocol {
    func execute(countyCode: String) -> Countries
}

struct GetBordersUseCase: GetBordersUseCaseProtocol {
    private let repository: CountriesRepositoryProtocol

    init(repository: CountriesRepositoryProtocol = CountriesRepository()) {
        self.repository = repository
    }

    func execute(countyCode: String) -> Countries {
        let countries = repository.getCountries()

        let borders = countries.first {
            $0.alpha3Code == countyCode
        }?.borders ?? []

        var borderCountries: Countries = []

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
