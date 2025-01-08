//
//  HighlightCountryUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation
import Factory

protocol HighlightCountryUseCaseProtocol {
    func execute(countryCode: String)
}

struct HighlightCountryUseCase: HighlightCountryUseCaseProtocol {
    @Injected(\.countriesRepo) private var repository

    func execute(countryCode: String) {
        repository.highlightCountry(withCode: countryCode)
    }
}
