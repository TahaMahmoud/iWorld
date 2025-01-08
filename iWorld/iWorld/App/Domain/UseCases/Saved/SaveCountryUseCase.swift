//
//  SaveCountryUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation

protocol SaveCountryUseCaseProtocol {
    func execute(countryCode: String)
}

struct SaveCountryUseCase: SaveCountryUseCaseProtocol {
    let repository: CountriesRepositoryProtocol

    init(repository: CountriesRepositoryProtocol = CountriesRepository()) {
        self.repository = repository
    }

    func execute(countryCode: String) {
        repository.saveCountry(withCode: countryCode)
    }
}
