//
//  CountriesDataSourceMock.swift
//  iWorld
//
//  Created by Taha Mahmoud on 09/01/2025.
//

@testable import iWorld
import Foundation

final class RemoteCountriesDataSourceMock: RemoteCountriesDataSourceProtocol {
    var countries: [Country] = []

    init(countries: [Country] = []) {
        self.countries = countries
    }
    
    func fetchCountries() async -> [Country] {
        return countries.isEmpty ? loadCountries() : countries
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

final class LocalCountriesDataSourceMock: LocalCountriesDataSourceProtocol {
    var highlightedCountries: [Country] = []
    var savedCountries: [Country] = []

    func getLocalCountries() -> [Country] {
        return []
    }

    func getHighlighted() -> [Country] {
        return highlightedCountries
    }

    func getSaved() -> [Country] {
        return savedCountries
    }

    func highlight(_ country: Country) {
        highlightedCountries.append(country)
    }

    func save(_ country: Country) {
        savedCountries.append(country)
    }

    func removeHighlighted(_ country: Country) {
        highlightedCountries.removeAll { $0.alpha3Code == country.alpha3Code }
    }

    func removeSaved(_ country: Country) {
        savedCountries.removeAll { $0.alpha3Code == country.alpha3Code }
    }
}
