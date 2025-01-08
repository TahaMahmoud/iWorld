//
//  CountriesRepository.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Foundation

class CountriesRepository: CountriesRepositoryProtocol {
    private var remoteCountriesDataSource: RemoteCountriesDataSourceProtocol
    private var localCountriesDataSource: LocalCountriesDataSourceProtocol

    var counrties: [Country] = []

    init(
        remoteCountriesDataSource: RemoteCountriesDataSourceProtocol = DIContainer.remoteDataSource,
        localCountriesDataSource: LocalCountriesDataSourceProtocol = DIContainer.localDataSource
    ) {
        self.remoteCountriesDataSource = remoteCountriesDataSource
        self.localCountriesDataSource = localCountriesDataSource

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
        return counrties
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
