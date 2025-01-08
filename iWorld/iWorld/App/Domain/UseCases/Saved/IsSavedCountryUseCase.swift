//
//  IsSavedCountryUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation

protocol IsSavedCountryUseCaseProtocol {
    func execute(countryCode: String) -> Bool
}

struct IsSavedCountryUseCase: IsSavedCountryUseCaseProtocol {
    let repository: CountriesRepositoryProtocol

    init(repository: CountriesRepositoryProtocol = DIContainer.countriesRepo) {
        self.repository = repository
    }

    func execute(countryCode: String) -> Bool {
        guard !(countryCode.isEmpty) else { return false }

        let savedCountries = repository.getSavedCountries(limit: nil)

        return !(savedCountries.filter {
            $0.alpha3Code == countryCode
        }.isEmpty)
    }
}
