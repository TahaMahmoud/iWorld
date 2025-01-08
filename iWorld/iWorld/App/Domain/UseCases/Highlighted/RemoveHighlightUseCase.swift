//
//  RemoveHighlightUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation
import Factory

protocol RemoveHighlightUseCaseProtocol {
    func execute(countryCode: String)
}

struct RemoveHighlightUseCase: RemoveHighlightUseCaseProtocol {
    @Injected(\.countriesRepo) private var repository

    func execute(countryCode: String) {
        repository.removeFromHighlighted(withCode: countryCode)
    }
}
