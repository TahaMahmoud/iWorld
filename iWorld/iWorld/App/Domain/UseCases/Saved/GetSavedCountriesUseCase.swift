//
//  GetSavedCountriesUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation
import Factory

protocol GetSavedCountriesUseCaseProtocol {
    func execute(limit: Int?) -> [Country]
}

struct GetSavedCountriesUseCase: GetSavedCountriesUseCaseProtocol {
    @Injected(\.countriesRepo) private var repository

    func execute(limit: Int?) -> [Country] {
        repository.getSavedCountries(limit: limit)
    }
}
