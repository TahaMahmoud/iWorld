//
//  CountriesRepoProtocol.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation

protocol CountriesRepositoryProtocol {
    mutating func fetchCountriesData() async throws

    func getCountries() -> Countries
    func getHighlightedCountries() -> Countries
    func getSavedCountries(limit: Int?) -> Countries

    func highlightCountry(withCode numericCode: String)
    func saveCountry(withCode numericCode: String)

    func removeFromHighlighted(withCode numericCode: String)
    func removeFromSaved(withCode numericCode: String)
}
