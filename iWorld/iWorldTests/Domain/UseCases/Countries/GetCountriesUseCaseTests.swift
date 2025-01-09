//
//  GetCountriesUseCaseTests.swift
//  iWorldTests
//
//  Created by Taha Mahmoud on 09/01/2025.
//

import Combine
import Factory
@testable import iWorld
import XCTest

final class GetCountriesUseCaseTests: iWorldTestCase {
    fileprivate var countriesRepositoryMock = CountriesRepositoryMock()

    override func setUp() {
        super.setUp()
        countriesRepositoryMock = CountriesRepositoryMock()
        Container.shared.countriesRepo.register { self.countriesRepositoryMock }
    }

    func testGetCountriesWithLimit() async throws {
        // Arrange
        let useCase = GetCountriesUseCase()

        // Act
        let countries = await useCase.execute(limit: 5)

        // Assert
        XCTAssertEqual(countries.count, 5, "Should return the correct number of countries based on the limit.")
    }

    func testGetCountriesWithoutLimit() async throws {
        // Arrange
        let useCase = GetCountriesUseCase()

        // Act
        let countries = await useCase.execute(limit: nil)

        // Assert
        XCTAssertEqual(countries.count, countriesRepositoryMock.countries.count, "Should return all countries when no limit is provided.")
    }

    func testGetCountriesFetchesWhenEmpty() async throws {
        // Arrange
        let useCase = GetCountriesUseCase()
        countriesRepositoryMock.countries = [] // Simulate empty repository

        // Act
        let countries = await useCase.execute(limit: 10)

        // Assert
        XCTAssertFalse(countries.isEmpty, "Should fetch countries when the repository is initially empty.")
    }

    func testGetCountriesByQueryAndRegion() {
        // Arrange
        let useCase = GetCountriesUseCase()
        let query = "land" // Example query
        let region: Region = .europe

        // Act
        let countries = useCase.execute(query: query, region: region)

        // Assert
        let filteredCountries = countriesRepositoryMock.countries.filter {
            ($0.name?.lowercased().contains(query.lowercased()) ?? false) &&
            $0.region == region
        }

        XCTAssertEqual(countries, filteredCountries, "Should return countries matching the query and region.")
    }

    func testGetCountriesByQueryWithNoMatches() {
        // Arrange
        let useCase = GetCountriesUseCase()
        let query = "nonexistent" // Query that matches no countries
        let region: Region = .asia

        // Act
        let countries = useCase.execute(query: query, region: region)

        // Assert
        XCTAssertTrue(countries.isEmpty, "Should return an empty array when no countries match the query and region.")
    }

    func testGetCountriesByRegion() {
        // Arrange
        let useCase = GetCountriesUseCase()
        let region: Region = .africa

        // Act
        let countries = useCase.execute(region: region)

        // Assert
        let filteredCountries = countriesRepositoryMock.countries.filter {
            $0.region?.rawValue.contains(region.rawValue) ?? false
        }
        XCTAssertEqual(countries, filteredCountries, "Should return countries matching the region.")
    }

    func testGetCountriesByQueryCaseInsensitive() {
        // Arrange
        let useCase = GetCountriesUseCase()
        let query = "LAND" // Test case insensitivity
        let region: Region = .europe

        // Act
        let countries = useCase.execute(query: query, region: region)

        // Assert
        let filteredCountries = countriesRepositoryMock.countries.filter {
            ($0.name?.lowercased().contains(query.lowercased()) ?? false) &&
            $0.region == region
        }
        XCTAssertEqual(countries, filteredCountries, "Should return the same results regardless of query case sensitivity.")
    }
}

extension Country: Equatable {
    public static func == (lhs: Country, rhs: Country) -> Bool {
        rhs.id == lhs.id
    }
}
