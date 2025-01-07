//
//  CountriesRepoProtocol.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation

protocol CountriesRepoProtocol {
    var countries: Countries { get }
    var highlightedCountries: Countries { get }
    var savedCountries: Countries { get }

    func getCountries() async -> Countries
    func getCountry(withCode numericCode: String) async -> Country
    func getRegions() async -> [Region]
    func getCountries(forRegion region: String) async -> Countries
    func search(withName name: String) async -> Countries

    func getHighlightedCountries() async -> Countries
    func getSavedCountries(limit: Int?) async -> Countries

    func highlightCountry(withCode numericCode: String) async
    func saveCountry(withCode numericCode: String) async

    func isCountrySaved(withCode numericCode: String) async -> Bool
    func isCountryHighlighted(withCode numericCode: String) async -> Bool

    func removeFromHighlighted(withCode numericCode: String) async
    func removeFromSaved(withCode numericCode: String) async
}
