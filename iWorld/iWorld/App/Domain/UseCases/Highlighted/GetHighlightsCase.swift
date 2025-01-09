//
//  GetHighlightedCountries.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Factory
import Foundation

protocol GetHighlightedCountriesUseCaseProtocol {
    func execute(currentCountryName: String) -> [Country]
}

struct GetHighlightedCountriesUseCase: GetHighlightedCountriesUseCaseProtocol {
    @Injected(\.countriesRepo) private var repository
    @Injected(\.getCountryDetailsUseCase) private var getCountryDetailsUseCase
    @Injected(\.getCurrentLocationUseCase) private var getCurrentLocationUseCase

    let defaultCountry: Country =
        Country(
            name: "Egypt",
            topLevelDomain: nil, alpha2Code: nil,
            alpha3Code: "EGY",
            callingCodes: nil,
            capital: "Cairo",
            altSpellings: nil, subregion: nil, region: .africa, population: nil, latlng: nil, demonym: nil,
            area: nil, timezones: nil, borders: nil, nativeName: nil, numericCode: nil,
            flags: Flags(svg: nil, png: "https://flagcdn.com/w320/eg.png"),
            currencies: nil, languages: nil, translations: nil, flag: nil, regionalBlocs: nil,
            cioc: nil, independent: nil, gini: nil
        )

    func execute(currentCountryName: String) -> [Country] {
        var highlightedCountries = repository.getHighlightedCountries()
        let currentCountry = getCountryDetailsUseCase.execute(countryName: currentCountryName)

        highlightedCountries.insert(currentCountry ?? defaultCountry, at: 0)

        return highlightedCountries
    }
}
