//
//  GetSavedCountriesUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation

protocol GetSavedCountriesUseCaseProtocol {
    func execute(limit: Int?) -> [Country]
}

struct GetSavedCountriesUseCase: GetSavedCountriesUseCaseProtocol {
    let repository: CountriesRepositoryProtocol

    init(repository: CountriesRepositoryProtocol = CountriesRepository()) {
        self.repository = repository
    }

    func execute(limit: Int?) -> [Country] {
        repository.getSavedCountries(limit: limit)
    }
}
