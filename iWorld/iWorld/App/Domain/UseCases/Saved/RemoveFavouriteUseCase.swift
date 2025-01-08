//
//  RemoveFavouriteUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation

protocol RemoveFavouriteUseCaseProtocol {
    func execute(countryCode: String)
}

struct RemoveFavouriteUseCase: RemoveFavouriteUseCaseProtocol {
    let repository: CountriesRepositoryProtocol

    init(repository: CountriesRepositoryProtocol = CountriesRepository()) {
        self.repository = repository
    }

    func execute(countryCode: String) {
        repository.removeFromSaved(withCode: countryCode)
    }
}
