//
//  GetHighlightedCountries.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation

protocol GetHighlightedCountriesUseCaseProtocol {
    func execute() -> [Country]
}

struct GetHighlightedCountriesUseCase: GetHighlightedCountriesUseCaseProtocol {
    let repository: CountriesRepositoryProtocol

    init(repository: CountriesRepositoryProtocol = DIContainer.countriesRepo) {
        self.repository = repository
    }

    func execute() -> [Country] {
        repository.getHighlightedCountries()
    }
}
