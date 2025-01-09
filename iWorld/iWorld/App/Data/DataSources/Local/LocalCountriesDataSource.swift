//
//  LocalCountriesDataSource.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Factory
import Foundation
import Networking

protocol LocalCountriesDataSourceProtocol {
    func getLocalCountries() async -> [Country]

    func getHighlighted() -> [Country]
    func getSaved() -> [Country]

    func highlight(_ country: Country)
    func save(_ country: Country)

    func removeHighlighted(_ country: Country)
    func removeSaved(_ country: Country)
}

struct LocalCountriesDataSource: LocalCountriesDataSourceProtocol {
    private let highlightedKey: String = "iworld-highlighted"
    private let savedKey: String = "iworld-saved"

    @Injected(\.dataManager) private var dataManager
    @Injected(\.networkManager) private var networkingManger

    func getLocalCountries() async -> [Country] {
        let endpoint = LocalCountriesEndpoint.allCountries

        let result: Result<[Country], NetworkRequestError<AppError>>
        result = await networkingManger.executeRequest(
            endpoint,
            appErrors: nil
        ).result

        switch result {
        case let .success(countries):
            return countries
        case .failure:
            return []
        }
    }

    func getHighlighted() -> [Country] {
        dataManager.retrieve(
            [Country].self,
            forKey: highlightedKey,
            using: .userDefaults
        ) ?? []
    }

    func getSaved() -> [Country] {
        dataManager.retrieve(
            [Country].self,
            forKey: savedKey,
            using: .userDefaults
        ) ?? []
    }

    func highlight(_ country: Country) {
        var highlights = getHighlighted()
        let isExist = highlights.contains(where: { $0.alpha3Code == country.alpha3Code })

        guard !isExist else { return }

        highlights.append(country)

        dataManager.save(
            data: highlights,
            forKey: highlightedKey,
            using: .userDefaults
        )
    }

    func save(_ country: Country) {
        var saved = getSaved()
        let isExist = saved.contains(where: { $0.alpha3Code == country.alpha3Code })

        guard !isExist else { return }

        saved.append(country)

        dataManager.save(
            data: saved,
            forKey: savedKey,
            using: .userDefaults
        )
    }

    func removeHighlighted(_ country: Country) {
        let highlights = getHighlighted()
        let isExist = highlights.contains(where: { $0.alpha3Code == country.alpha3Code })

        guard isExist else { return }

        let updatedHighlightedCountries = highlights.filter({ $0.alpha3Code != country.alpha3Code })

        dataManager.update(
            data: updatedHighlightedCountries,
            forKey: highlightedKey,
            using: .userDefaults
        )
    }

    func removeSaved(_ country: Country) {
        let saved = getSaved()
        let isExist = saved.contains(where: { $0.alpha3Code == country.alpha3Code })

        guard isExist else { return }

        let updatedSavedCountries = saved.filter({ $0.alpha3Code != country.alpha3Code })

        dataManager.update(
            data: updatedSavedCountries,
            forKey: savedKey,
            using: .userDefaults
        )
    }
}
