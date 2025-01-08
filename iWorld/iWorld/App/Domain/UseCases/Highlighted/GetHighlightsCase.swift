//
//  GetHighlightedCountries.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation

protocol GetHighlightedCountriesProtocol {
    func execute() -> Countries
}

struct GetHighlightedCountries: GetHighlightedCountriesProtocol {
    let repository: CountriesRepositoryProtocol

    init(repository: CountriesRepositoryProtocol = CountriesRepository()) {
        self.repository = repository
    }

    func execute() -> Countries {
        repository.getHighlightedCountries()
    }
}
