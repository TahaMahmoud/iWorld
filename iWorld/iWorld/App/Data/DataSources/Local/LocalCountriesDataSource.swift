//
//  LocalCountriesDataSource.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Foundation

protocol LocalCountriesDataSourceProtocol {
    func getLocalCountries() -> [Country]

    func getHighlighted() -> [Country]
    func getSaved() -> [Country]

    func highlight(_ country: Country)
    func save(_ country: Country)

    func removeHighlighted(_ country: Country)
    func removeSaved(_ country: Country)
}

struct LocalCountriesDataSource: LocalCountriesDataSourceProtocol {
    func getLocalCountries() -> [Country] {
        []
    }

    func getHighlighted() -> [Country] {
        []
    }

    func getSaved() -> [Country] {
        []
    }

    func highlight(_ country: Country) {
    }

    func save(_ country: Country) {
    }

    func removeHighlighted(_ country: Country) {
    }

    func removeSaved(_ country: Country) {
    }
}
