//
//  AppError.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

enum AppError: Error, Decodable {
    case unexpected
    case locationNotAvailable
    case countryDetailsNotAvailable
    case highlightsLimitExceeded
}
