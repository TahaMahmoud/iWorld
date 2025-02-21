//
//  RemoveFavouriteUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation
import Factory

protocol RemoveFavouriteUseCaseProtocol {
    func execute(countryCode: String)
}

struct RemoveFavouriteUseCase: RemoveFavouriteUseCaseProtocol {
    @Injected(\.countriesRepo) private var repository

    func execute(countryCode: String) {
        repository.removeFromSaved(withCode: countryCode)
    }
}
