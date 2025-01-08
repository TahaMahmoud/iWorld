//
//  CountriesRepoProtocol.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation

protocol CountriesRepositoryProtocol {
    func fetchCountriesData() async

    func getCountries() -> [Country]
    func getHighlightedCountries() -> [Country]
    func getSavedCountries(limit: Int?) -> [Country]

    func highlightCountry(withCode countryCode: String)
    func saveCountry(withCode countryCode: String)

    func removeFromHighlighted(withCode countryCode: String)
    func removeFromSaved(withCode countryCode: String)
}
