//
//  CountriesRepository.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Foundation
import Factory

class CountriesRepository: CountriesRepositoryProtocol {
    @Injected(\.remoteDataSource) private var remoteCountriesDataSource
    @Injected(\.localDataSource) private var localCountriesDataSource

    var countries: [Country] = []

    init() {
        loadCountriesData()
    }

    private func loadCountriesData() {
        Task {
            await fetchCountriesData()
        }
    }

    func fetchCountriesData() async {
        countries = await remoteCountriesDataSource.fetchCountries()
    }

    func getCountries() -> [Country] {
        countries
    }

    func getHighlightedCountries() -> [Country] {
        localCountriesDataSource.getHighlighted()
    }

    func getSavedCountries(limit: Int? = nil) -> [Country] {
        localCountriesDataSource.getSaved()
    }

    func highlightCountry(withCode countryCode: String) {
        let country = countries.first {
            $0.alpha3Code == countryCode
        }

        guard let country else { return }

        localCountriesDataSource.highlight(country)
    }

    func saveCountry(withCode countryCode: String) {
        let country = countries.first {
            $0.alpha3Code == countryCode
        }

        guard let country else { return }

        localCountriesDataSource.save(country)
    }

    func removeFromHighlighted(withCode countryCode: String) {
        let country = countries.first {
            $0.alpha3Code == countryCode
        }

        guard let country else { return }

        localCountriesDataSource.removeHighlighted(country)
    }

    func removeFromSaved(withCode countryCode: String) {
        let country = countries.first {
            $0.alpha3Code == countryCode
        }

        guard let country else { return }

        localCountriesDataSource.removeSaved(country)
    }
}
