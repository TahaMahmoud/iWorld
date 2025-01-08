//
//  CountriesRepository.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Foundation

struct CountriesRepository: CountriesRepositoryProtocol {
    private var remoteCountriesDataSource: RemoteCountriesDataSourceProtocol
    private var localCountriesDataSource: LocalCountriesDataSource

    var counrties: Countries = []

    init(
        remoteCountriesDataSource: RemoteCountriesDataSourceProtocol = RemoteCountriesDataSource(),
        localCountriesDataSource: LocalCountriesDataSource = LocalCountriesDataSource()
    ) {
        self.remoteCountriesDataSource = remoteCountriesDataSource
        self.localCountriesDataSource = localCountriesDataSource
    }

    mutating func fetchCountriesData() async throws {
        counrties = []
    }

    func getCountries() -> Countries {
        return counrties
    }

    func getHighlightedCountries() -> Countries {
        []
    }

    func getSavedCountries(limit: Int? = nil) -> Countries {
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
