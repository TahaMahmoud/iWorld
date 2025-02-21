//
//  HighlightCountryUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Factory
import Foundation

protocol HighlightCountryUseCaseProtocol {
    func execute(countryCode: String) throws
}

struct HighlightCountryUseCase: HighlightCountryUseCaseProtocol {
    @Injected(\.countriesRepo) private var repository
    let highlighsLimit: Int = 5

    func execute(countryCode: String) throws {
        let highlights = repository.getHighlightedCountries()
        guard highlights.count <= highlighsLimit else {
            throw AppError.highlightsLimitExceeded
        }

        repository.highlightCountry(withCode: countryCode)
    }
}
