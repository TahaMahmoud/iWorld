//
//  HighlightCountryUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation

protocol HighlightCountryUseCaseProtocol {
    func execute(countryCode: String)
}

struct HighlightCountryUseCase: HighlightCountryUseCaseProtocol {
    let repository: CountriesRepositoryProtocol

    init(repository: CountriesRepositoryProtocol = DIContainer.countriesRepo) {
        self.repository = repository
    }

    func execute(countryCode: String) {
        repository.highlightCountry(withCode: countryCode)
    }
}
