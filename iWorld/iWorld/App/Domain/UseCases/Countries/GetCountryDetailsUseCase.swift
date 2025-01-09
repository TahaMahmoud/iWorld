//
//  GetCountryDetailsUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Factory
import Foundation

protocol GetCountryDetailsUseCaseProtocol {
    func execute(countyCode: String) -> Country?
    func execute(countryName: String) -> Country?
}

struct GetCountryDetailsUseCase: GetCountryDetailsUseCaseProtocol {
    @Injected(\.countriesRepo) private var repository

    func execute(countyCode: String) -> Country? {
        let countries = repository.getCountries()

        let country = countries.first {
            $0.alpha3Code == countyCode
        }

        return country
    }

    func execute(countryName: String) -> Country? {
        let countries = repository.getCountries()

        let country = countries.first {
            $0.name == countryName
        }

        return country
    }
}
