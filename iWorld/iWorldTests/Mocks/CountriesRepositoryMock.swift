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
    var highlightedCountries: [Country] = []
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
        return highlightedCountries
    }

    func getSavedCountries(limit: Int?) -> [Country] {
        guard let limit else {
            return savedCountries
        }

        return Array(savedCountries.prefix(limit))
    }

    func highlightCountry(withCode countryCode: String) {
        if let country = countries.first(where: { $0.id == countryCode }),
           highlightedCountries.contains(country) == false {
            highlightedCountries.append(country)
        }
    }

    func saveCountry(withCode countryCode: String) {
        if let country = countries.first(where: { $0.id == countryCode }),
           savedCountries.contains(country) == false {
            savedCountries.append(country)
        }
    }

    func removeFromHighlighted(withCode countryCode: String) {
        if let country = highlightedCountries.first(where: { $0.id == countryCode }) {
            highlightedCountries.removeAll(where: { $0.id == countryCode })
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
