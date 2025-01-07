//
//  Countries.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

// swiftlint: disable identifier_name

import Foundation

// MARK: - Country
struct Country: Codable {
    let name: String?
    let topLevelDomain: [String]?
    let alpha2Code, alpha3Code: String?
    let callingCodes: [String]?
    let capital: String?
    let altSpellings: [String]?
    let subregion: String?
    let region: Region?
    let population: Int?
    let latlng: [Double]?
    let demonym: String?
    let area: Double?
    let timezones, borders: [String]?
    let nativeName, numericCode: String?
    let flags: Flags?
    let currencies: [Currency]?
    let languages: [Language]?
    let translations: Translations?
    let flag: String?
    let regionalBlocs: [RegionalBloc]?
    let cioc: String?
    let independent: Bool?
    let gini: Double?
}

// MARK: - Currency
struct Currency: Codable {
    let code, name, symbol: String?
}

// MARK: - Flags
struct Flags: Codable {
    let svg: String?
    let png: String?
}

// MARK: - Language
struct Language: Codable {
    let iso6391, iso6392, name, nativeName: String?

    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso639_1"
        case iso6392 = "iso639_2"
        case name, nativeName
    }
}

enum Region: String, Codable, CaseIterable {
    case africa = "Africa"
    case americas = "Americas"
    case antarctic = "Antarctic"
    case antarcticOcean = "Antarctic Ocean"
    case asia = "Asia"
    case europe = "Europe"
    case oceania = "Oceania"
    case polar = "Polar"
}

// MARK: - RegionalBloc
struct RegionalBloc: Codable {
    let acronym: String?
    let name: String?
    let otherNames: [String]?
    let otherAcronyms: [String]?
}

// MARK: - Translations
struct Translations: Codable {
    let br, pt, nl, hr: String?
    let fa, de, es, fr: String?
    let ja, it, hu: String?
}

typealias Countries = [Country]

// swiftlint: enable identifier_name
