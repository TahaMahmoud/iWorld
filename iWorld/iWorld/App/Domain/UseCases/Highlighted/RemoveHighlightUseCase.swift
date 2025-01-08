//
//  RemoveHighlightUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation

protocol RemoveHighlightUseCaseProtocol {
    func execute(countryCode: String)
}

struct RemoveHighlightUseCase: RemoveHighlightUseCaseProtocol {
    let repository: CountriesRepositoryProtocol

    init(repository: CountriesRepositoryProtocol = CountriesRepository()) {
        self.repository = repository
    }

    func execute(countryCode: String) {
        repository.removeFromHighlighted(withCode: countryCode)
    }
}
