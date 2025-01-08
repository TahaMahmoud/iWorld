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

    var counrties: [Country] = []

    init() {
        loadCountriesData()
    }

    private func loadCountriesData() {
        Task {
            await fetchCountriesData()
        }
    }

    func fetchCountriesData() async {
        counrties = await remoteCountriesDataSource.fetchCountries()
    }

    func getCountries() -> [Country] {
        counrties
    }

    func getHighlightedCountries() -> [Country] {
        []
    }

    func getSavedCountries(limit: Int? = nil) -> [Country] {
        []
    }

    func highlightCountry(withCode numericCode: String) {
    }

    func saveCountry(withCode numericCode: String) {
    }

    func removeFromHighlighted(withCode numericCode: String) {
    }

    func removeFromSaved(withCode numericCode: String) {
    }
}
