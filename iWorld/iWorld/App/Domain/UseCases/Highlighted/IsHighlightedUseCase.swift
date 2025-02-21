//
//  IsHighlighedUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation
import Factory

protocol IsHighlightedUseCaseProtocol {
    func execute(countryCode: String) -> Bool
}

struct IsHighlightedUseCase: IsHighlightedUseCaseProtocol {
    @Injected(\.countriesRepo) private var repository

    func execute(countryCode: String) -> Bool {
        guard !(countryCode.isEmpty) else { return false }

        let highlighedCountries = repository.getHighlightedCountries()

        return !(highlighedCountries.filter {
            $0.alpha3Code == countryCode
        }.isEmpty)
    }
}
