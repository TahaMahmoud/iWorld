//
//  GetCountryDetailsUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation

protocol GetCountryDetailsUseCaseProtocol {
    func execute(countyCode: String) -> Country?
}

struct GetCountryDetailsUseCase: GetCountryDetailsUseCaseProtocol {
    private let repository: CountriesRepositoryProtocol

    init(repository: CountriesRepositoryProtocol = DIContainer.countriesRepo) {
        self.repository = repository
    }

    func execute(countyCode: String) -> Country? {
        let countries = repository.getCountries()

        let country = countries.first {
            $0.alpha3Code == countyCode
        }

        return country
    }
}
