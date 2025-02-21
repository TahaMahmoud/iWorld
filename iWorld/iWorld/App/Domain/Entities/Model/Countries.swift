//
//  Countries.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

// swiftlint: disable identifier_name

import DataPersistence
import Foundation

// MARK: - Country

struct Country: Codable, Identifiable, Cachable {
    var id: String { alpha3Code ?? UUID().uuidString }

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

    init(
        name: String? = nil,
        topLevelDomain: [String]? = nil,
        alpha2Code: String? = nil,
        alpha3Code: String? = nil,
        callingCodes: [String]? = nil,
        capital: String? = nil,
        altSpellings: [String]? = nil,
        subregion: String? = nil,
        region: Region? = nil,
        population: Int? = nil,
        latlng: [Double]? = nil,
        demonym: String? = nil,
        area: Double? = nil,
        timezones: [String]? = nil,
        borders: [String]? = nil,
        nativeName: String? = nil,
        numericCode: String? = nil,
        flags: Flags? = nil,
        currencies: [Currency]? = nil,
        languages: [Language]? = nil,
        translations: Translations? = nil,
        flag: String? = nil,
        regionalBlocs: [RegionalBloc]? = nil,
        cioc: String? = nil,
        independent: Bool? = nil,
        gini: Double? = nil
    ) {
        self.name = name
        self.topLevelDomain = topLevelDomain
        self.alpha2Code = alpha2Code
        self.alpha3Code = alpha3Code
        self.callingCodes = callingCodes
        self.capital = capital
        self.altSpellings = altSpellings
        self.subregion = subregion
        self.region = region
        self.population = population
        self.latlng = latlng
        self.demonym = demonym
        self.area = area
        self.timezones = timezones
        self.borders = borders
        self.nativeName = nativeName
        self.numericCode = numericCode
        self.flags = flags
        self.currencies = currencies
        self.languages = languages
        self.translations = translations
        self.flag = flag
        self.regionalBlocs = regionalBlocs
        self.cioc = cioc
        self.independent = independent
        self.gini = gini
    }
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

enum Region: String, Codable, CaseIterable, Identifiable {
    var id: String { rawValue }

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

// swiftlint: enable identifier_name
