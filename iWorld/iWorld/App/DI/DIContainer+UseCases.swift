//
//  DIContainer+UseCases.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Foundation

extension DIContainer {
    static var getCountriesUseCase: GetCountriesUseCaseProtocol {
        GetCountriesUseCase(repository: DIContainer.countriesRepo)
    }
    
    static var getBordersUseCase: GetBordersUseCaseProtocol {
        GetBordersUseCase(repository: DIContainer.countriesRepo)
    }
    
    static var getCountryDetailsUseCase: GetCountryDetailsUseCaseProtocol {
        GetCountryDetailsUseCase(repository: DIContainer.countriesRepo)
    }
    
    static var getRegionsUseCase: GetRegionsUseCaseProtocol {
        GetRegionsUseCase()
    }
    
    static var getHighlightedCountriesUseCase: GetHighlightedCountriesUseCaseProtocol {
        GetHighlightedCountriesUseCase(repository: DIContainer.countriesRepo)
    }
    
    static var highlightCountryUseCase: HighlightCountryUseCaseProtocol {
        HighlightCountryUseCase(repository: DIContainer.countriesRepo)
    }
    
    static var isHighlighedUseCase: IsHighlighedUseCaseProtocol {
        IsHighlighedUseCase(repository: DIContainer.countriesRepo)
    }
    
    static var removeHighlightUseCase: RemoveHighlightUseCaseProtocol {
        RemoveHighlightUseCase(repository: DIContainer.countriesRepo)
    }
    
    static var getSavedCountriesUseCase: GetSavedCountriesUseCaseProtocol {
        GetSavedCountriesUseCase(repository: DIContainer.countriesRepo)
    }
    
    static var isSavedCountryUseCase: IsSavedCountryUseCaseProtocol {
        IsSavedCountryUseCase(repository: DIContainer.countriesRepo)
    }
    
    static var removeFavouriteUseCase: RemoveFavouriteUseCaseProtocol {
        RemoveFavouriteUseCase(repository: DIContainer.countriesRepo)
    }
    
    static var saveCountryUseCase: SaveCountryUseCaseProtocol {
        SaveCountryUseCase(repository: DIContainer.countriesRepo)
    }
}
