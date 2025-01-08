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

    func highlightCountry(withCode numericCode: String)
    func saveCountry(withCode numericCode: String)

    func removeFromHighlighted(withCode numericCode: String)
    func removeFromSaved(withCode numericCode: String)
}
