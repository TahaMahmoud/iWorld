//
//  SaveCountryUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation
import Factory

protocol SaveCountryUseCaseProtocol {
    func execute(countryCode: String)
}

struct SaveCountryUseCase: SaveCountryUseCaseProtocol {
    @Injected(\.countriesRepo) private var repository

    func execute(countryCode: String) {
        repository.saveCountry(withCode: countryCode)
    }
}
