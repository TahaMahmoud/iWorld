//
//  GetHighlightedCountries.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation
import Factory

protocol GetHighlightedCountriesUseCaseProtocol {
    func execute() -> [Country]
}

struct GetHighlightedCountriesUseCase: GetHighlightedCountriesUseCaseProtocol {
    @Injected(\.countriesRepo) private var repository

    func execute() -> [Country] {
        repository.getHighlightedCountries()
    }
}
