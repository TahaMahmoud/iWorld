//
//  IsSavedCountryUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation
import Factory

protocol IsSavedCountryUseCaseProtocol {
    func execute(countryCode: String) -> Bool
}

struct IsSavedCountryUseCase: IsSavedCountryUseCaseProtocol {
    @Injected(\.countriesRepo) private var repository

    func execute(countryCode: String) -> Bool {
        guard !(countryCode.isEmpty) else { return false }

        let savedCountries = repository.getSavedCountries(limit: nil)

        return !(savedCountries.filter {
            $0.alpha3Code == countryCode
        }.isEmpty)
    }
}
