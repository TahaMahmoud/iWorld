//
//  IsHighlighedUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation

protocol IsHighlighedUseCaseProtocol {
    func execute(countryCode: String) -> Bool
}

struct IsHighlighedUseCase: IsHighlighedUseCaseProtocol {
    let repository: CountriesRepositoryProtocol

    init(repository: CountriesRepositoryProtocol = DIContainer.countriesRepo) {
        self.repository = repository
    }

    func execute(countryCode: String) -> Bool {
        guard !(countryCode.isEmpty) else { return false }

        let highlighedCountries = repository.getHighlightedCountries()

        return !(highlighedCountries.filter {
            $0.alpha3Code == countryCode
        }.isEmpty)
    }
}
