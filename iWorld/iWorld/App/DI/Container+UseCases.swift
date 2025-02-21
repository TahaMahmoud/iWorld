//
//  Container+UseCases.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Foundation
import Factory

extension Container {
    var getCountriesUseCase: Factory<GetCountriesUseCaseProtocol> {
        self { GetCountriesUseCase() }.shared
    }

    var getBordersUseCase: Factory<GetBordersUseCaseProtocol> {
        self { GetBordersUseCase() }.shared
    }

    var getCountryDetailsUseCase: Factory<GetCountryDetailsUseCaseProtocol> {
        self { GetCountryDetailsUseCase() }.shared
    }

    var getRegionsUseCase: Factory<GetRegionsUseCaseProtocol> {
        self { GetRegionsUseCase() }.shared
    }

    var getHighlightedCountriesUseCase: Factory<GetHighlightedCountriesUseCaseProtocol> {
        self { GetHighlightedCountriesUseCase() }.shared
    }

    var highlightCountryUseCase: Factory<HighlightCountryUseCaseProtocol> {
        self { HighlightCountryUseCase() }.shared
    }

    var isHighlightedUseCase: Factory<IsHighlightedUseCaseProtocol> {
        self { IsHighlightedUseCase() }.shared
    }

    var removeHighlightUseCase: Factory<RemoveHighlightUseCaseProtocol> {
        self { RemoveHighlightUseCase() }.shared
    }

    var getSavedCountriesUseCase: Factory<GetSavedCountriesUseCaseProtocol> {
        self { GetSavedCountriesUseCase() }.shared
    }

    var isSavedCountryUseCase: Factory<IsSavedCountryUseCaseProtocol> {
        self { IsSavedCountryUseCase() }.shared
    }

    var removeFavouriteUseCase: Factory<RemoveFavouriteUseCaseProtocol> {
        self { RemoveFavouriteUseCase() }.shared
    }

    var saveCountryUseCase: Factory<SaveCountryUseCaseProtocol> {
        self { SaveCountryUseCase() }.shared
    }

    var getCurrentLocationUseCase: Factory<GetCurrentLocationUseCaseProtocol> {
        self { GetCurrentLocationUseCase() }.shared
    }
}
