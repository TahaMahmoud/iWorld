//
//  CountriesRepositoryMock.swift
//  iWorldTests
//
//  Created by Taha Mahmoud on 09/01/2025.
//

import Foundation
@testable import iWorld

class CountriesRepositoryMock: CountriesRepositoryProtocol {
    var countries: [Country] = []
    var highlighedCountries: [Country] = []
    var savedCountries: [Country] = []

    init(countries: [Country] = []) {
        self.countries = countries
    }

    init() {
        countries = loadCountries()
    }

    func fetchCountriesData() async {
        countries = loadCountries()
    }

    func getCountries() -> [Country] {
        return countries
    }

    func getHighlightedCountries() -> [Country] {
        return highlighedCountries
    }

    func getSavedCountries(limit: Int?) -> [Country] {
        return savedCountries
    }

    func highlightCountry(withCode countryCode: String) {
        if let country = countries.first(where: { $0.id == countryCode }) {
            highlighedCountries.append(country)
        }
    }

    func saveCountry(withCode countryCode: String) {
        if let country = countries.first(where: { $0.id == countryCode }) {
            savedCountries.append(country)
        }
    }

    func removeFromHighlighted(withCode countryCode: String) {
        if let country = highlighedCountries.first(where: { $0.id == countryCode }) {
            highlighedCountries.removeAll(where: { $0.id == countryCode })
        }
    }

    func removeFromSaved(withCode countryCode: String) {
        if let country = savedCountries.first(where: { $0.id == countryCode }) {
            savedCountries.removeAll(where: { $0.id == countryCode })
        }
    }

    func loadCountries() -> [Country] {
        guard let url = Bundle(for: Self.self).url(forResource: "countries", withExtension: "json"),
              let data = try? Data(contentsOf: url)
        else {
            fatalError("Couldn't read data.json file")
        }

        do {
            let decoder = JSONDecoder()
            let countries = try decoder.decode([Country].self, from: data)
            return countries
        } catch {
            return []
        }
    }
}
